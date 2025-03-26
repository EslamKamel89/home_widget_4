import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/globals/globals_var.dart';
import 'package:home_widget_4/core/router/app_router.dart';
import 'package:home_widget_4/core/router/app_routes_names.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/core/themes/theme_cubit.dart';
import 'package:home_widget_4/features/date_conversion/presentation/cubits/date_conversion/date_conversion_cubit.dart';
import 'package:home_widget_4/features/date_info/presentation/cubits/date_month/date_month_cubit.dart';
import 'package:home_widget_4/features/date_info/presentation/cubits/date_year/date_year_cubit.dart';
import 'package:home_widget_4/features/date_info/presentation/cubits/eclipse/eclipse_cubit.dart';
import 'package:home_widget_4/features/date_info/presentation/cubits/moon_phase/moon_phase_cubit.dart';
import 'package:home_widget_4/features/main_homepage/cubits/moon_image/moon_image_cubit.dart';
import 'package:home_widget_4/features/main_homepage/cubits/update_next_prayer_api/update_next_prayer_api_cubit.dart';
import 'package:intl/intl_standalone.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await findSystemLocale();
  await EasyLocalization.ensureInitialized();
  tz.initializeTimeZones();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs', // Path to translation files
      fallbackLocale: const Locale('en'),
      // child: DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(
            create: (context) => DateConversionCubit(dateConversionRepo: serviceLocator()),
          ),
          BlocProvider(create: (context) => DateYearCubit(dateInfoRepo: serviceLocator())),
          BlocProvider(create: (context) => DateMonthCubit(dateInfoRepo: serviceLocator())),
          BlocProvider(create: (context) => MoonPhaseCubit(dateInfoRepo: serviceLocator())),
          BlocProvider(create: (context) => EclipseCubit(dateInfoRepo: serviceLocator())),

          // BlocProvider(create: (context) => UpdateNextPrayerInfoCubit()),
          // BlocProvider(create: (context) => PrayersTimesTodayCubit()..getPrayersTimesToday()),
          BlocProvider(create: (context) => UpdateNextPrayerApiCubit()..init()),
          // BlocProvider(create: (context) => PrayersTimesByDateCubit()..getPrayersTimesByDate(DateTime.now())),
          BlocProvider(create: (context) => MoonImageCubit()),
        ],
        child: Builder(
          builder: (context) {
            final themeCubit = context.watch<ThemeCubit>();
            return MaterialApp(
              // builder: DevicePreview.appBuilder,
              navigatorKey: navigatorKey,
              theme: themeCubit.state,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutesNames.splashScreen,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              onGenerateRoute: serviceLocator<AppRouter>().onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
