import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:meet_sam_ava/features/employment_info/view/employment_info_page.dart';

import 'package:meet_sam_ava/features/employment_info/view/employment_info_unified_page.dart';
import 'package:meet_sam_ava/features/home/view/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        AutoRoute(path: '/employment', page: EmploymentInfoUnifiedRoute.page),
      ];
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => const HomeView();
}
