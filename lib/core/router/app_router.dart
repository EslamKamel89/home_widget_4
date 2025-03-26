import 'package:flutter/material.dart';
import 'package:home_widget_4/core/router/app_routes_names.dart';
import 'package:home_widget_4/core/router/middleware.dart';
import 'package:home_widget_4/core/widgets/splash_screen.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/date_conversion_view.dart';
import 'package:home_widget_4/features/date_info/presentation/date_month_view.dart';
import 'package:home_widget_4/features/date_info/presentation/date_year_view.dart';
import 'package:home_widget_4/features/date_info/presentation/eclipse_view.dart';
import 'package:home_widget_4/features/date_info/presentation/moon_info_view.dart';
import 'package:home_widget_4/features/main_homepage/presentation/main_homepage.dart';
import 'package:home_widget_4/features/qibla/presenation/qibla_finder_view.dart';
import 'package:home_widget_4/features/world_prayers/presentation/views/world_prayers_view.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(builder: (context) => const SplashScreen(), settings: routeSettings);
      case AppRoutesNames.dateConversionView:
        return CustomPageRoute(
          builder: (context) => const DateConversionView(),
          settings: routeSettings,
        );
      case AppRoutesNames.dateYearView:
        return CustomPageRoute(builder: (context) => const DateYearView(), settings: routeSettings);
      case AppRoutesNames.dateMonthView:
        return CustomPageRoute(
          builder: (context) => const DateMonthView(),
          settings: routeSettings,
        );
      case AppRoutesNames.moonPhaseView:
        return CustomPageRoute(builder: (context) => const MoonInfoView(), settings: routeSettings);
      case AppRoutesNames.eclipseView:
        return CustomPageRoute(builder: (context) => const EclipseView(), settings: routeSettings);
      case AppRoutesNames.mainHomepage:
        return CustomPageRoute(builder: (context) => const MainHomePage(), settings: routeSettings);
      case AppRoutesNames.qiblaFinderView:
        return CustomPageRoute(
          builder: (context) => const QiblaFinderView(),
          settings: routeSettings,
        );
      case AppRoutesNames.worldPrayersView:
        return CustomPageRoute(
          builder: (context) => const WorldPrayersView(),
          settings: routeSettings,
        );
      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required RouteSettings super.settings});
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
