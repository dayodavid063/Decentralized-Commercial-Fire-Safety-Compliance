# Decentralized Commercial Fire Safety Compliance

A blockchain-based platform for transparent management and verification of commercial fire safety compliance through smart contracts.

## Overview

This system leverages blockchain technology to create an immutable record of fire safety compliance for commercial structures. By implementing a suite of interconnected smart contracts, the platform provides a verifiable and transparent system for managing building registrations, equipment inventory, inspection scheduling, and regulatory compliance tracking.

## Core Components

### Building Registration Contract
- Records details of commercial structures
- Maintains building specifications, occupancy classification, and construction type
- Stores ownership records and responsible parties
- Provides verifiable digital identity for registered properties

### Equipment Inventory Contract
- Tracks fire extinguishers, alarms, and sprinklers
- Maintains detailed equipment specifications and locations
- Records installation dates and service life information
- Enables equipment-level verification for inspections

### Inspection Scheduling Contract
- Manages required safety checks based on regulatory timelines
- Automates inspection scheduling and notification workflows
- Records inspector credentials and certification
- Stores timestamped inspection reports and findings

### Compliance Tracking Contract
- Ensures adherence to fire code regulations
- Validates compliance status across multiple jurisdictions
- Issues compliance certificates with cryptographic verification
- Tracks violations and remediation activities

## Getting Started

### Prerequisites
- Ethereum wallet (MetaMask recommended)
- Ethereum development environment (Truffle/Hardhat)
- Node.js (v16+)
- Web3.js or ethers.js

### Installation

1. Clone the repository
```
git clone https://github.com/yourusername/fire-safety-blockchain.git
cd fire-safety-blockchain
```

2. Install dependencies
```
npm install
```

3. Compile smart contracts
```
npx hardhat compile
```

4. Deploy to test network
```
npx hardhat run scripts/deploy.js --network <network-name>
```

## Usage Examples

### Register a Commercial Building
```javascript
await buildingContract.registerBuilding(
  "Highrise Office Tower",
  "123 Business Avenue",
  "Type I-A", // construction type
  "B", // occupancy classification
  32, // number of floors
  true, // has basement
  550 // occupant load
);
```

### Add Fire Safety Equipment
```javascript
await equipmentContract.addEquipment(
  buildingId,
  "Fire Extinguisher",
  "ABC Dry Chemical",
  "5th Floor East Corridor",
  "Kidde Pro 10", // model
  "2024-01-15", // installation date
  "2025-01-15" // next service date
);
```

### Schedule Inspection
```javascript
await inspectionContract.scheduleInspection(
  buildingId,
  "Annual Fire Safety Inspection",
  Math.floor(Date.now() / 1000) + 2592000, // 30 days from now
  inspectorWalletAddress,
  ["Fire Alarm System", "Sprinkler System", "Emergency Lighting"]
);
```

### Record Compliance Status
```javascript
await complianceContract.updateComplianceStatus(
  buildingId,
  true, // isCompliant
  "All systems operational and maintained according to code",
  Math.floor(Date.now() / 1000) + 31536000, // valid for 1 year
  inspectorWalletAddress
);
```

## Benefits

- **Transparency**: Immutable record of all fire safety equipment, inspections, and compliance status
- **Accountability**: Clear responsibility tracking for building owners, managers, and inspectors
- **Efficiency**: Automated scheduling and notification systems
- **Security**: Cryptographically secured compliance certificates
- **Accessibility**: Real-time compliance status verification by authorities and stakeholders

## Future Development

- Integration with IoT devices for real-time monitoring of fire safety systems
- Mobile application for inspectors with on-chain verification
- Public-facing compliance verification portal
- Automated alerts for approaching inspection deadlines
- Multi-jurisdictional compliance tracking

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
