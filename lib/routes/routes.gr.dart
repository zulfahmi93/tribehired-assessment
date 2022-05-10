// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../models/models.dart' as _i4;
import '../ui/ui.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    PostListRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.PostListPage());
    },
    PostDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PostDetailsRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.PostDetailsPage(post: args.post, key: args.key));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(PostListRoute.name, path: '/'),
        _i2.RouteConfig(PostDetailsRoute.name, path: '/post-details-page')
      ];
}

/// generated route for
/// [_i1.PostListPage]
class PostListRoute extends _i2.PageRouteInfo<void> {
  const PostListRoute() : super(PostListRoute.name, path: '/');

  static const String name = 'PostListRoute';
}

/// generated route for
/// [_i1.PostDetailsPage]
class PostDetailsRoute extends _i2.PageRouteInfo<PostDetailsRouteArgs> {
  PostDetailsRoute({required _i4.Post post, _i3.Key? key})
      : super(PostDetailsRoute.name,
            path: '/post-details-page',
            args: PostDetailsRouteArgs(post: post, key: key));

  static const String name = 'PostDetailsRoute';
}

class PostDetailsRouteArgs {
  const PostDetailsRouteArgs({required this.post, this.key});

  final _i4.Post post;

  final _i3.Key? key;

  @override
  String toString() {
    return 'PostDetailsRouteArgs{post: $post, key: $key}';
  }
}
