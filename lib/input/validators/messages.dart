import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/input/validators/ipfs_cid_validator.dart';
import 'package:gethdomains/input/validators/tor_address_validator.dart';
import 'package:reactive_forms/reactive_forms.dart';

Map<String, String Function(Object)> getValidationMessages(
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
      IpfsCidValidator.validationName: (_) =>
          AppLocalizations.of(context)!.inputErrorIpfsCidInvalid,
      TorAddressValidator.validationName: (_) =>
          AppLocalizations.of(context)!.inputErrorTorHashInvalid,
    };
