import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gethdomains/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedBloc
  assert(kIsWeb);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorage.webStorageDirectory,
  );

  Provider.debugCheckInvalidValueType = null;

  runApp(const GethDomainsApp());
}
