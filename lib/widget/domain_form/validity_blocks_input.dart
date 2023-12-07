import 'package:decimal/decimal.dart';
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

  // TODO: Define the cost in GETH per block
  static final Decimal costPerBlock = Decimal.parse('0.0001');

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppReactiveTextField(
          formControlName: kValidityBlocksCount,
          hintText: AppLocalizations.of(context)!
              .domainRegistrationValidityBlocksLabel,
          helperText: AppLocalizations.of(context)!
              .domainRegistrationValidityBlocksHelper,
          onSubmit: (_) => onSubmit(),
        ),
        ReactiveValueListenableBuilder(
          formControlName: kValidityBlocksCount,
          builder: (context, control, child) {
            if (control.value != null) {
              control.markAsTouched();
            }

            final validityBlocksCount = control.value as int?;
            String estimatedCostDisplayMessage = '';
            if (control.valid && validityBlocksCount != null) {
              // Show an estimated cost for the domain registration
              final estimatedCost =
                  costPerBlock * Decimal.fromInt(validityBlocksCount);

              estimatedCostDisplayMessage = AppLocalizations.of(context)!
                  .domainRegistrationValidityBlocksEstimatedCost(
                      estimatedCost.toString());
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(estimatedCostDisplayMessage),
            );
          },
        ),
      ],
    );
  }
}
