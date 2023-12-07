import 'package:reactive_forms/reactive_forms.dart';

extension FormUtils on FormGroup {
  void replaceControls(Map<String, AbstractControl> controls) {
    // Remove existing controls
    controls.keys.where(contains).forEach(removeControl);

    // Add new controls
    addAll(controls);
  }
}