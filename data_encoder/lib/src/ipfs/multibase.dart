import 'dart:convert';
import 'dart:typed_data';

import 'package:base32/base32.dart' as base32_library;
import 'package:base32/encodings.dart';
import 'package:bs58/bs58.dart';
import 'package:cid/cid.dart';
import 'package:convert/convert.dart';

/// Returns a `Multibase` class based off a given code
Multibase getMultibaseFromCode(final String code) {
  for (final Multibase base in Multibase.values) {
    if (base.baseCode == code) {
      return base;
    }
  }
  throw Exception('Unknown base code: $code');
}

/// Encodes a given [suffixedMultihash] with a given multibase.
/// The encoded is the multibase code + encoded hash.
String encodeInputMultihashWithBase(
    final Multibase base, Uint8List suffixedMultihash) {
  switch (base) {
    case Multibase.base16:
      {
        String encodedHash = hex.encode(suffixedMultihash);
        return base.baseCode + encodedHash;
      }

    case Multibase.base16upper:
      {
        String encodedHash = hex.encode(suffixedMultihash);
        return base.baseCode + encodedHash.toUpperCase();
      }

    case Multibase.base32:
      {
        String encodedHash = base32_library.base32.encode(suffixedMultihash,
            encoding: Encoding.nonStandardRFC4648Lower);
        String padlessEncodedHash = encodedHash.replaceAll("=", "");

        return base.baseCode + padlessEncodedHash;
      }

    case Multibase.base32upper:
      {
        String encodedHash = base32_library.base32
            .encode(suffixedMultihash, encoding: Encoding.standardRFC4648);
        String padlessEncodedHash = encodedHash.replaceAll("=", "");

        return base.baseCode + padlessEncodedHash;
      }

    case Multibase.base58btc:
      {
        String encodedHash = base58.encode(suffixedMultihash);
        return base.baseCode + encodedHash;
      }

    case Multibase.base64:
      {
        String encodedHash = base64Encode(suffixedMultihash);
        return base.baseCode + encodedHash;
      }
  }
}

/// Decodes a given string with a given multibase.
/// The input string should include the code of the multibase, do not splice it beforehand.
Uint8List decodeInputStringWithBase(final Multibase base, String input) {
  final substring = input.substring(1);

  switch (base) {
    case Multibase.base16:
      {
        return Uint8List.fromList(hex.decode(substring));
      }

    case Multibase.base16upper:
      {
        return Uint8List.fromList(hex.decode(substring));
      }

    case Multibase.base32:
      {
        return base32_library.base32
            .decode(substring, encoding: Encoding.nonStandardRFC4648Lower);
      }

    case Multibase.base32upper:
      {
        return base32_library.base32.decode(substring);
      }

    case Multibase.base58btc:
      {
        return base58.decode(substring);
      }

    case Multibase.base64:
      {
        return base64Decode(substring);
      }
  }
}

Uint8List decodeInputString(String input) {
  final base = getMultibaseFromCode(input[0]);
  return decodeInputStringWithBase(base, input);
}
