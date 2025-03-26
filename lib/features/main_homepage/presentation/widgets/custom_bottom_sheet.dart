import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/router/app_routes_names.dart';
import 'package:home_widget_4/features/main_homepage/presentation/widgets/grid_item.dart';
import 'package:home_widget_4/utils/assets/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class MainpageBottomSheetWidget extends StatefulWidget {
  const MainpageBottomSheetWidget({super.key});

  @override
  State<MainpageBottomSheetWidget> createState() => _MainpageBottomSheetWidgetState();
}

class _MainpageBottomSheetWidgetState extends State<MainpageBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 600.h,
      width: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GridItem(
                  title: "DATE_CONVERSION".tr(),
                  image: AssetsData.dateConversionIcon,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutesNames.dateConversionView);
                  },
                ),
              ),
              Expanded(
                child: GridItem(
                  title: 'MOON_PHASE'.tr(),
                  image: AssetsData.moonIcon,
                  onTap: () async {
                    Navigator.of(context).pushNamed(AppRoutesNames.moonPhaseView);
                  },
                ),
              ),
              Expanded(
                child: GridItem(
                  title: 'ECLIPSE'.tr(),
                  image: AssetsData.moonEclipseIcon,
                  onTap: () async {
                    Navigator.of(context).pushNamed(AppRoutesNames.eclipseView);
                  },
                ),
              ),
              Expanded(
                child: GridItem(
                  title: 'FIND_QIBLA'.tr(),
                  image: AssetsData.compass,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutesNames.qiblaFinderView);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GridItem(
                  title: 'MOSQUES'.tr(),
                  image: AssetsData.mosque,
                  onTap: () async {
                    // const url = "geo:0,0?q=mosque";
                    const url =
                        'https://www.google.com/maps/search/mosques+near+me/@31.0437726,31.3662496,15z/data=!3m1!4b1?entry=ttu&g_ep=EgoyMDI1MDMxNy4wIKXMDSoASAFQAw%3D%3D';
                    await launchUrl(Uri.parse(url));
                  },
                ),
              ),
              Expanded(
                child: GridItem(
                  title: 'HALAL'.tr(),
                  image: AssetsData.hallalResturant,
                  onTap: () async {
                    // const url = "geo:0,0?q=halal+restraurant";
                    const url =
                        'https://www.google.com/maps/search/halal+restraurant+near+me/@31.0437726,31.3662496,15z/data=!3m1!4b1?entry=ttu&g_ep=EgoyMDI1MDMxNy4wIKXMDSoASAFQAw%3D%3D';
                    await launchUrl(Uri.parse(url));
                  },
                ),
              ),
              Expanded(
                child: GridItem(
                  title: 'WORLD_PRAYERS_2'.tr(),
                  image: AssetsData.globe,
                  onTap: () async {
                    Navigator.of(context).pushNamed(AppRoutesNames.worldPrayersView);
                  },
                ),
              ),
              Expanded(
                child: GridItem(
                  title: 'Home Widget',
                  image: AssetsData.homeWidget,
                  onTap: () async {
                    Navigator.of(context).pushNamed(AppRoutesNames.homeWidgetView);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      // StaggeredGrid.count(
      //   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   //   crossAxisCount: 3,
      //   //   mainAxisSpacing: 8,
      //   //   crossAxisSpacing: 8,
      //   //   // childAspectRatio: 1, // Width/height ratio (1 = square)
      //   //   mainAxisExtent: 170.h,
      //   // ),
      //   crossAxisCount: 3,

      //   mainAxisSpacing: 3,
      //   crossAxisSpacing: 4,
      //   children: [
      //     StaggeredGridTile.count(
      //       crossAxisCellCount: 1,
      //       mainAxisCellCount: 1.25,
      //       child: GridItem(
      //         title: 'Find Qibla',
      //         image: AssetsData.compass,
      //         onTap: () {
      //           Navigator.of(context).pushNamed(AppRoutesNames.qiblaFinderView);
      //         },
      //       ),
      //     ),
      //     StaggeredGridTile.count(
      //       crossAxisCellCount: 1,
      //       mainAxisCellCount: 1.25,
      //       child: GridItem(
      //         title: 'Mosques',
      //         image: AssetsData.mosque,
      //         onTap: () {
      //           Navigator.of(context).pushNamed(AppRoutesNames.qiblaFinderView);
      //         },
      //       ),
      //     ),
      //     StaggeredGridTile.count(
      //       crossAxisCellCount: 1,
      //       mainAxisCellCount: 1.25,
      //       child: GridItem(
      //         title: 'Halal Restruants',
      //         image: AssetsData.hallalResturant,
      //         onTap: () {
      //           Navigator.of(context).pushNamed(AppRoutesNames.qiblaFinderView);
      //         },
      //       ),
      //     ),
      // const StaggeredGridTile.count(
      //   crossAxisCellCount: 3,
      //   mainAxisCellCount: 2,
      //   child: NextPrayerWidget(),
      //   // child: NextPrayerWidget(),
      //     // ),
      //   ],
      // ),
    );
  }
}
