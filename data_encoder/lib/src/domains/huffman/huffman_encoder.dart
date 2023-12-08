/*
 * This file contains the Huffman encoding and decoding functions.
 *
 * The maps have been generated using the corresponding Python script.
 * The data is based on a collection of domain names.
 */

import 'dart:typed_data';

import '../../bit_stream/bit_reader.dart';
import '../../bit_stream/bit_writer.dart';
import '../interface.dart';
import 'huffman_encoding_item.dart';

class HuffmanEncoder extends AbstractDomainEncoder {
  static const bool techniqueIdentifier = true;

  /// In the encoding map, each index corresponds to the charIndex of the lowercase letter.
  ///
  /// The first element in the array is the binary representation that has to be written,
  /// while the second element is the length of the binary representation.
  ///
  /// The index 0 corresponds to the \0 null terminator
  /// and it's used to indicate that the string has ended.
  static final List<HuffmanEncodingItem> _encodingMap = List.unmodifiable([
    HuffmanEncodingItem.fromBin("000"),
    HuffmanEncodingItem.fromBin("1101"),
    HuffmanEncodingItem.fromBin("111001"),
    HuffmanEncodingItem.fromBin("11000"),
    HuffmanEncodingItem.fromBin("10010"),
    HuffmanEncodingItem.fromBin("1111"),
    HuffmanEncodingItem.fromBin("011011"),
    HuffmanEncodingItem.fromBin("00110"),
    HuffmanEncodingItem.fromBin("00111"),
    HuffmanEncodingItem.fromBin("1011"),
    HuffmanEncodingItem.fromBin("1100100"),
    HuffmanEncodingItem.fromBin("111000"),
    HuffmanEncodingItem.fromBin("11101"),
    HuffmanEncodingItem.fromBin("10011"),
    HuffmanEncodingItem.fromBin("0111"),
    HuffmanEncodingItem.fromBin("1010"),
    HuffmanEncodingItem.fromBin("00101"),
    HuffmanEncodingItem.fromBin("0010000"),
    HuffmanEncodingItem.fromBin("0100"),
    HuffmanEncodingItem.fromBin("1000"),
    HuffmanEncodingItem.fromBin("0101"),
    HuffmanEncodingItem.fromBin("01100"),
    HuffmanEncodingItem.fromBin("001001"),
    HuffmanEncodingItem.fromBin("011010"),
    HuffmanEncodingItem.fromBin("1100101"),
    HuffmanEncodingItem.fromBin("110011"),
    HuffmanEncodingItem.fromBin("0010001"),
  ]);

  /// The Huffman tree used for encoding and decoding.
  ///
  /// The decoding map is a tree structure, where each node can be:
  /// - an array of 2 items, where the first item is the left node and the second item is the right node
  /// - a string, which is the decoded character (leaf node)
  static final List<dynamic> _huffmanTree = List.unmodifiable([
    [
      [
        "\u0000",
        [
          [
            [
              ["q", "z"],
              "v"
            ],
            "p"
          ],
          ["g", "h"]
        ]
      ],
      [
        ["r", "t"],
        [
          [
            "u",
            ["w", "f"]
          ],
          "n"
        ]
      ]
    ],
    [
      [
        [
          "s",
          ["d", "m"]
        ],
        ["o", "i"]
      ],
      [
        [
          [
            "c",
            [
              ["j", "x"],
              "y"
            ]
          ],
          "a"
        ],
        [
          [
            ["k", "b"],
            "l"
          ],
          "e"
        ]
      ]
    ]
  ]);

  @override
  Uint8List encode(String data) {
    final bitWriter = BitWriter();

    // Write the identifier of this technique
    bitWriter.writeBit(techniqueIdentifier);

    for (int i = 0; i < data.length; i++) {
      final charIndex = data.codeUnitAt(i) - 96;
      final encodingItem = _encodingMap[charIndex];
      bitWriter.writeBits(encodingItem.binary, encodingItem.length);
    }

    // Finally, encode the null terminator
    final encodingNullTerminatorItem = _encodingMap[0];
    bitWriter.writeBits(
      encodingNullTerminatorItem.binary,
      encodingNullTerminatorItem.length,
    );

    return bitWriter.getBuffer();
  }

  @override
  String decode(Uint8List data) {
    final bitReader = BitReader(buffer: data);

    // Ensure the identifier of this technique is correct
    if (bitReader.readBit() != techniqueIdentifier) {
      throw ArgumentError.value(data, 'buffer', 'Invalid buffer supplied');
    }

    dynamic currentNode = _huffmanTree;

    final decodedChars = [];

    // 1 1111 010

    // Traverse the tree until we reach a leaf node
    while (true) {
      final bit = bitReader.readBit();
      currentNode = currentNode[bit ? 1 : 0];

      if (currentNode is String) {
        // We reached a leaf node, so we can add the decoded character to the array
        // However, this may still be the null terminator, so we have to check for that and stop
        if (currentNode == "\u0000") {
          break;
        }

        // Character found, now restart from the root node
        decodedChars.add(currentNode);
        currentNode = _huffmanTree;
      }
    }

    return decodedChars.join("");
  }
}
