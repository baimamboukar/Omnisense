import 'package:auto_route/auto_route.dart';
import 'package:omnisense/src/router/router.gr.dart';

@AutoRouterConfig()
class OminsenseRouter extends $OminsenseRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: GoogleAuth.page,
      path: '/google-auth',
    ),
    AutoRoute(
      page: Welcome.page,
      path: '/welcome',
    ),
    AutoRoute(
      page: Home.page,
      path: '/omnisense-home',
      children: [
        AutoRoute(
          page: OmnisenseLearn.page,
          path: 'omnisense-learn',
        ),
        AutoRoute(
          page: OmnisenseAI.page,
          path: 'omnisense-ai',
        ),
        AutoRoute(
          page: OmnisenseDesiderata.page,
          path: 'omnisense-desiderata',
        ),
        AutoRoute(
          page: OmnisenseUserProfile.page,
          path: 'omnisense-user-profile',
        ),
      ],
    ),
    AutoRoute(
      page: OmnisenseChatRoom.page,
      path: '/omnisense-chat-room',
    ),
  ];
}
