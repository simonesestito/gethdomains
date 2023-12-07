import 'package:flutter/material.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/utils/form_utils.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidityBlocksCountInput extends StatelessWidget {
  static const int minBlocks = 10;
  static const int maxBlocks = _fiveYearsInBlocks;
  static const String kValidityBlocksCount = 'validityBlocksCount';

  final void Function() onSubmit;

  static const int _fiveYearsInBlocks = 5 * 365 * 24 * 60 * 60 ~/ 12;

  ValidityBlocksCountInput({
    super.key,
    required FormGroup form,
    required this.onSubmit,
    Domain? editingDomain,
  }) {
    form.replaceControls({
      kValidityBlocksCount: FormControl<int>(
        validators: [
          Validators.number,
          Validators.required,
          Validators.min(minBlocks),
          Validators.max(maxBlocks),
        ],
      )
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppReactiveTextField(
      formControlName: kValidityBlocksCount,
      hintText:
          AppLocalizations.of(context)!.domainRegistrationValidityBlocksLabel,
      helperText:
          AppLocalizations.of(context)!.domainRegistrationValidityBlocksHelper,
      onSubmit: (_) => onSubmit(),
    );
  }
}
