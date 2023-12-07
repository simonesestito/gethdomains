# GethDomains

<div align="center">
   <b>Decentralized Domain Name Registrar for IPFS and Tor.</b>
</div>
<hr>

Deployed on Sepolia test network at address **{????????}**.

This project is developed as part of the Blockchain and Distributed Ledger Technologies course in the Computer Science master's degree program at Sapienza University of Rome. It serves as a practical application of theoretical concepts covered in the course.

## Technical Summary

### Web3 and Ethereum Integration

This project holds significant importance as it focuses on Web3 integration, specifically interacting with an Ethereum Smart Contract developed in Solidity. The web frontend seamlessly communicates with the blockchain using web3js, possibly with Metamask integration for enhanced user experience and secure transactions.

### Flutter Web Compatibility

This project is designed exclusively for Flutter Web, incorporating JavaScript code essential for Ethereum and Web3 interactions. Ensure that you have the necessary dependencies and configurations set up to run Flutter on the web platform.

### Architecture

The project adopts a robust architectural approach, primarily leveraging the BLoC (Business Logic Component) and Provider patterns. This provides a clear separation between the user interface and business logic, promoting maintainability and scalability.

### Data Abstraction

To streamline data interactions with the Ethereum Smart Contract, the project employs repositories. These repositories serve as an abstraction layer, encapsulating both business logic and implementation details. This separation enhances modularity and facilitates future updates or changes in data handling.

### Blockchain Deployment

The project is deployed on the Sepolia test network, allowing for real-world testing and validation of the integration with Ethereum Smart Contracts. This ensures that the developed solution aligns with the principles of blockchain technology.

### Dependencies

- **Flutter**: Ensure you have the Flutter framework installed, configured, and ready for web development.
- **BLoC Pattern**: Familiarize yourself with the BLoC pattern, which forms the core of the project's architectural design.
- **Provider Package**: This project heavily relies on the Provider package for state management, offering a simple and effective way to propagate changes throughout the application.

### Getting Started

1. **Flutter Web Setup**: Follow Flutter's guidelines for setting up your development environment to support web development.
   
2. **Dependency Installation**: Run `flutter pub get` to install the required dependencies mentioned in the `pubspec.yaml` file.

3. **Blockchain Integration**: Familiarize yourself with the Ethereum Smart Contract integration using web3js and Metamask.

4. **Run the Project**: Execute `flutter run -d web` to launch the application on your local development server.

5. **Explore and Contribute**: Delve into the project structure, explore the BLoC components, providers, and repositories. Contributions are welcome—feel free to submit pull requests for enhancements or bug fixes.

### Copyright

    Copyright (C) 2023-2024
[Alessandro Scifoni](https://github.com/ernutella001)
[Andrea Tarricone](https://github.com/MyNameIsTarric)
[Simone Sestito](https://github.com/simonesestito)
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
