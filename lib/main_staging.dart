import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnisense/app/view/app.dart';
import 'package:omnisense/bootstrap.dart';
import 'package:omnisense/firebase_options.dart';
import 'package:omnisense/src/features/auth/auth.dart';
import 'package:omnisense/src/features/settings/settings.dart';
import 'package:omnisense/src/features/settings/thememode/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  await bootstrap(
    () => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => OmnisenseAuthCubit(),
        )
      ],
      child: const Omnisense(),
    ),
  );
}
