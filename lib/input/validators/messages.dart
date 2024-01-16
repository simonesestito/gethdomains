import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/input/validators/ipfs_cid_validator.dart';
import 'package:gethdomains/input/validators/tor_address_validator.dart';
import 'package:reactive_forms/reactive_forms.dart';

Map<String, String Function(dynamic)> getValidationMessages(
        BuildContext context) =>
    {
      ValidationMessage.required: (_) =>
          AppLocalizations.of(context)!.inputErrorRequired,
      ValidationMessage.minLength: (_) =>
          AppLocalizations.of(context)!.inputErrorDomainTooShort,
      DomainInputValidator.validationName: (_) =>
          AppLocalizations.of(context)!.inputErrorDomainInvalid(
            DomainInputValidator.domainSuffix,
          ),
      ValidationMessage.number: (_) =>
          AppLocalizations.of(context)!.inputErrorNumber,
      ValidationMessage.min: (min) =>
          AppLocalizations.of(context)!.inputErrorMin(_getMin(min)),
      ValidationMessage.max: (max) =>
          AppLocalizations.of(context)!.inputErrorMax(_getMax(max)),
      IpfsCidValidator.validationName: (_) =>
          AppLocalizations.of(context)!.inputErrorIpfsCidInvalid,
      TorAddressValidator.validationName: (_) =>
          AppLocalizations.of(context)!.inputErrorTorHashInvalid,
    };

int _getMin(dynamic minErrorResult) => minErrorResult['min'] as int;
int _getMax(dynamic maxErrorResult) => maxErrorResult['max'] as int;