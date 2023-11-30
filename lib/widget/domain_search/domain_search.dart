import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/domain_search/domain_search_bloc.dart';

part 'domain_search_form.dart';
part 'domain_search_button.dart';
part 'domain_search_input.dart';

typedef DomainSearchCallback = void Function(String domain);