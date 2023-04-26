// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:omnisense/src/features/auth/presentation/screens/google_auth.dart'
    as _i8;
import 'package:omnisense/src/features/chat/data/models/omnisense_chat.dart'
    as _i11;
import 'package:omnisense/src/features/chat/presentation/screens/omnisense_chat_room.dart'
    as _i7;
import 'package:omnisense/src/features/home/presentation/screens/home_screen.dart'
    as _i6;
import 'package:omnisense/src/features/home/presentation/screens/omnisense_ai.dart'
    as _i3;
import 'package:omnisense/src/features/home/presentation/screens/omnisense_desiderata.dart'
    as _i5;
import 'package:omnisense/src/features/home/presentation/screens/omnisense_learn.dart'
    as _i2;
import 'package:omnisense/src/features/home/presentation/screens/omnisense_user_profile.dart'
    as _i4;
import 'package:omnisense/src/features/settings/welcome/welcome.dart' as _i1;

abstract class $OminsenseRouter extends _i9.RootStackRouter {
  $OminsenseRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    Welcome.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Welcome(),
      );
    },
    OmnisenseLearn.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.OmnisenseLearn(),
      );
    },
    OmnisenseAI.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i3.OmnisenseAI()),
      );
    },
    OmnisenseUserProfile.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i4.OmnisenseUserProfile()),
      );
    },
    OmnisenseDesiderata.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.OmnisenseDesiderata(),
      );
    },
    Home.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    OmnisenseChatRoom.name: (routeData) {
      final args = routeData.argsAs<OmnisenseChatRoomArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(
            child: _i7.OmnisenseChatRoom(
          key: args.key,
          chat: args.chat,
        )),
      );
    },
    GoogleAuth.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.GoogleAuthScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.Welcome]
class Welcome extends _i9.PageRouteInfo<void> {
  const Welcome({List<_i9.PageRouteInfo>? children})
      : super(
          Welcome.name,
          initialChildren: children,
        );

  static const String name = 'Welcome';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.OmnisenseLearn]
class OmnisenseLearn extends _i9.PageRouteInfo<void> {
  const OmnisenseLearn({List<_i9.PageRouteInfo>? children})
      : super(
          OmnisenseLearn.name,
          initialChildren: children,
        );

  static const String name = 'OmnisenseLearn';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.OmnisenseAI]
class OmnisenseAI extends _i9.PageRouteInfo<void> {
  const OmnisenseAI({List<_i9.PageRouteInfo>? children})
      : super(
          OmnisenseAI.name,
          initialChildren: children,
        );

  static const String name = 'OmnisenseAI';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OmnisenseUserProfile]
class OmnisenseUserProfile extends _i9.PageRouteInfo<void> {
  const OmnisenseUserProfile({List<_i9.PageRouteInfo>? children})
      : super(
          OmnisenseUserProfile.name,
          initialChildren: children,
        );

  static const String name = 'OmnisenseUserProfile';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.OmnisenseDesiderata]
class OmnisenseDesiderata extends _i9.PageRouteInfo<void> {
  const OmnisenseDesiderata({List<_i9.PageRouteInfo>? children})
      : super(
          OmnisenseDesiderata.name,
          initialChildren: children,
        );

  static const String name = 'OmnisenseDesiderata';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeScreen]
class Home extends _i9.PageRouteInfo<void> {
  const Home({List<_i9.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.OmnisenseChatRoom]
class OmnisenseChatRoom extends _i9.PageRouteInfo<OmnisenseChatRoomArgs> {
  OmnisenseChatRoom({
    _i10.Key? key,
    required _i11.OmnisenseChat chat,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          OmnisenseChatRoom.name,
          args: OmnisenseChatRoomArgs(
            key: key,
            chat: chat,
          ),
          initialChildren: children,
        );

  static const String name = 'OmnisenseChatRoom';

  static const _i9.PageInfo<OmnisenseChatRoomArgs> page =
      _i9.PageInfo<OmnisenseChatRoomArgs>(name);
}

class OmnisenseChatRoomArgs {
  const OmnisenseChatRoomArgs({
    this.key,
    required this.chat,
  });

  final _i10.Key? key;

  final _i11.OmnisenseChat chat;

  @override
  String toString() {
    return 'OmnisenseChatRoomArgs{key: $key, chat: $chat}';
  }
}

/// generated route for
/// [_i8.GoogleAuthScreen]
class GoogleAuth extends _i9.PageRouteInfo<void> {
  const GoogleAuth({List<_i9.PageRouteInfo>? children})
      : super(
          GoogleAuth.name,
          initialChildren: children,
        );

  static const String name = 'GoogleAuth';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
