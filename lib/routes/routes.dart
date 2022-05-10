import 'package:auto_route/auto_route.dart';

import '../ui/ui.dart';
import 'routes.gr.dart';

export 'routes.gr.dart';

final router = AppRouter();

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: PostListPage, initial: true),
  ],
)
class $AppRouter {}
