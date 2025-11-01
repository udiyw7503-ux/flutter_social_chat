import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:billie/core/di/dependency_injector.dart';
import 'package:billie/firebase_options.dart';
import 'package:billie/core/init/app_widget.dart';
import 'package:billie/core/config/env_config.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load environment variables
  await EnvConfig.instance.initialize();

  // Setup dependency injection
  injectionSetup();

  // Initialize hydrated storage for state persistence
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );

  runApp(const AppWidget());
}
