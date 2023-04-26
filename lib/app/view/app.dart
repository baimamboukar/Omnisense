import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnisense/l10n/l10n.dart';
import 'package:omnisense/src/configs/omnisense_theme.dart';
import 'package:omnisense/src/extensions/auth_cubit.dart';
import 'package:omnisense/src/features/settings/settings.dart';
import 'package:omnisense/src/router/router.dart';
import 'package:omnisense/src/router/router.gr.dart' as routes;

class Omnisense extends StatefulWidget {
  const Omnisense({super.key});

  @override
  State<Omnisense> createState() => _OmnisenseState();
}

class _OmnisenseState extends State<Omnisense> {
  late OminsenseRouter router;
  @override
  void initState() {
    router = OminsenseRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const theme = OmnisenseTheme();
    return BlocBuilder<ThemeCubit, bool>(
      builder: (BuildContext context, bool state) {
        return MaterialApp.router(
          title: 'Omnisense AI',
          debugShowCheckedModeBanner: false,
          themeMode: !state ? ThemeMode.light : ThemeMode.dark,
          theme: theme.toThemeData(Brightness.light),
          darkTheme: theme.toThemeData(
            Brightness.dark,
          ),
          // routeInformationParser: router.defaultRouteParser(),
          // routerDelegate: router.delegate(),
          routerConfig: router.config(
            initialRoutes: [
              if (context.isUserLoggedIn)
                const routes.Home()
              else
                const routes.Welcome(),
            ],
          ),
          // routeInformationProvider: router.routeInfoProvider(),
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
