import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:omnisense/src/app/assets.dart';
import 'package:omnisense/src/extensions/build_context.dart';
import 'package:omnisense/src/router/router.gr.dart' as routes;

@RoutePage(
  name: 'home',
)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        // routes.OmnisenseDesiderata(),
        routes.OmnisenseAI(),
        routes.OmnisenseLearn(),
        routes.OmnisenseUserProfile(),
      ],
      transitionBuilder: (context, child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          backgroundColor: context.colorScheme.background,
          selectedItemColor: context.colorScheme.primary,
          unselectedItemColor: context.colorScheme.primary.withOpacity(.35),
          items: const [
            // BottomNavigationBarItem(
            //   icon: Icon(LineIcons.home),
            //   label: 'Play',
            // ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(Assets.assetsImagesHappy)),
              label: 'Omnisense',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.magic),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Hicons.profile_1),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
