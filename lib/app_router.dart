import 'package:auto_route/auto_route.dart';
import 'package:meet_sam_ava/features/employment_info/view/employment_info_page.dart';
import 'package:meet_sam_ava/features/home/view/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Home route
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          initial: true,
        ),

        // Employment info route - web-friendly path
        AutoRoute(
          path: '/employment-info',
          page: EmploymentInfoRoute.page,
        ),

        // Wildcard route for handling undefined paths (must be last)
        AutoRoute(
          path: '*',
          page: HomeRoute.page.copyWith(
            name: 'HomeRouteWildcard',
          ),
        ),
      ];
}
