// ignore_for_file: cascade_invocations

import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:omnisense/src/extensions/auth_cubit.dart';
import 'package:omnisense/src/extensions/build_context.dart';
import 'package:omnisense/src/extensions/num.dart';
import 'package:omnisense/src/features/auth/auth.dart';
import 'package:omnisense/src/features/settings/thememode/cubit/theme_cubit.dart';
import 'package:omnisense/src/router/router.gr.dart' as routes;

@RoutePage(
  name: 'omnisenseUserProfile',
)
class OmnisenseUserProfile extends StatelessWidget with AutoRouteWrapper {
  const OmnisenseUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          44.vGap,
          Column(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(
                  '${context.user!.profileImageURL}',
                ),
              ),
              4.hGap,
              Text(
                context.user!.name,
              ),
            ],
          ),
          14.vGap,
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              // height: 120,
              width: context.width,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  14.vGap,
                  Text('Tokens', style: context.titleLg),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Used', style: context.bodyLg),
                      Text('Remaining', style: context.bodyLg),
                      Text('Earned', style: context.bodyLg),
                    ],
                  ),
                  14.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('14200', style: context.titleLg),
                      Text('5242', style: context.titleLg),
                      Text('12000', style: context.titleLg),
                    ],
                  ),
                  14.vGap,
                ],
              ),
            ),
          ),
          14.vGap,
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Implement logic to show language selection dialog
            },
          ),
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return ListTile(
                leading: const Icon(Icons.light_mode),
                title: const Text('Dark mode'),
                trailing: Switch(
                  value: state,
                  onChanged: (data) {
                    state
                        ? context.read<ThemeCubit>().reset()
                        : context.read<ThemeCubit>().toggle();
                  },
                ),
              );
            },
          ),
          BlocBuilder<OmnisenseAuthCubit, OmnisenseAuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                authenticated: (user) => ListTile(
                  leading: const Icon(Hicons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    context.read<OmnisenseAuthCubit>().logout();
                    context.router.pushAndPopUntil(
                      const routes.Welcome(),
                      predicate: (route) => false,
                    );
                  },
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return OmnisenseAuthCubit();
          },
        ),
      ],
      child: this,
    );
  }
}

// Custom clipper for profile image
class ProfileImageClipper extends CustomClipper<Path> {
  @override
  @override
  Path getClip(Size size) {
    final path = Path();
    final h = size.height;
    final w = size.width;

    final side = math.min(h, w);
    final altitude = (math.sqrt(3) / 2) * side;

    path.moveTo(0, altitude);
    path.lineTo(side / 2, 0);
    path.lineTo(side, altitude);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
