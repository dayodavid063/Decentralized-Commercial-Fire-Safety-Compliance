;; Compliance Tracking Contract
;; Tracks fire safety compliance status for commercial buildings

;; Compliance data structure
(define-map compliance-status
  { building-id: uint }
  {
    is-compliant: bool,
    last-inspection-date: uint,
    next-required-date: uint,
    compliance-history: (list 20 {
      date: uint,
      status: bool
    })
  }
)

;; Update compliance status (only called from inspection contract)
(define-public (update-compliance-status
    (building-id uint)
    (is-compliant bool)
    (inspection-date uint)
    (next-required-date uint))
  (let
    (
      (current-status (default-to {
        is-compliant: false,
        last-inspection-date: u0,
        next-required-date: u0,
        compliance-history: (list)
      } (map-get? compliance-status { building-id: building-id })))
      (new-history-entry {
        date: inspection-date,
        status: is-compliant
      })
      (updated-history (unwrap-panic (as-max-len?
                                      (append (get compliance-history current-status) new-history-entry)
                                      u20)))
    )
    ;; Check if caller is the inspection contract
    (asserts! (is-eq contract-caller .inspection-scheduling) (err u1))

    ;; Update compliance status
    (map-set compliance-status
      { building-id: building-id }
      {
        is-compliant: is-compliant,
        last-inspection-date: inspection-date,
        next-required-date: next-required-date,
        compliance-history: updated-history
      }
    )

    (ok true)
  )
)

;; Get compliance status for a building
(define-read-only (get-compliance-status (building-id uint))
  (map-get? compliance-status { building-id: building-id })
)

;; Check if a building is compliant
(define-read-only (is-building-compliant? (building-id uint))
  (let
    (
      (status (default-to {
        is-compliant: false,
        last-inspection-date: u0,
        next-required-date: u0,
        compliance-history: (list)
      } (map-get? compliance-status { building-id: building-id })))
      (current-time (unwrap-panic (get-block-info? time (- block-height u1))))
    )
    (and
      (get is-compliant status)
      (or
        (is-eq (get next-required-date status) u0)
        (< current-time (get next-required-date status))
      )
    )
  )
)

;; Get buildings requiring inspection
(define-read-only (needs-inspection? (building-id uint))
  (let
    (
      (status (default-to {
        is-compliant: false,
        last-inspection-date: u0,
        next-required-date: u0,
        compliance-history: (list)
      } (map-get? compliance-status { building-id: building-id })))
      (current-time (unwrap-panic (get-block-info? time (- block-height u1))))
    )
    (and
      (> (get next-required-date status) u0)
      (>= current-time (get next-required-date status))
    )
  )
)
