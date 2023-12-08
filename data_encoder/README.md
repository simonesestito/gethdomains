# Smart Contract Data Encoder

Plugin to compress / encode all string data that will be sent to the smart contract.

## Features

- **Domains Compressor**: use Huffman Trees or a simple encoding of 1 character in 5 bits
- **Tor Encoding**: extract the 32 bytes public key from the `.onion` address
- **IPFS Encoding**: extract only the essential information in binary from a v0 or v1 IPFS CID

## Usage

Running the example project, it'll be possible to use it from command line.

```sh
./data_encoder [encode/decode] [FORMAT] [DATA]
```