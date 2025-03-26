import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/globals/calc_method_settings.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/format_date.dart';
import 'package:home_widget_4/core/heleprs/int_parse.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/core/heleprs/prayer_name_tr.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/models/api_locale.dart';
import 'package:home_widget_4/core/models/api_response_model.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/core/widgets/custom_fading_widget.dart';
import 'package:home_widget_4/features/date_conversion/domain/repo/date_conversion_repo.dart';
import 'package:home_widget_4/features/date_conversion/presentation/cubits/date_conversion/date_conversion_cubit.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/data_selector.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:home_widget_4/features/main_homepage/cubits/moon_image/moon_image_cubit.dart';
import 'package:home_widget_4/features/main_homepage/cubits/prayers_time_api/prayers_time_api_cubit.dart';
import 'package:home_widget_4/features/main_homepage/models/prayers_time_model.dart';
import 'package:home_widget_4/utils/assets/assets.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

ValueNotifier<DateTime> selectedDateNotifier = ValueNotifier(DateTime.now());

class AllPraysTimeWidget extends StatefulWidget {
  const AllPraysTimeWidget({super.key});

  @override
  State<AllPraysTimeWidget> createState() => _AllPraysTimeWidgetState();
}

class _AllPraysTimeWidgetState extends State<AllPraysTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerTimesApiCubit(params: PrayerTimeParams()),
      child: const AppPrayersTimeBuilder(),
    );
  }
}

class AppPrayersTimeBuilder extends StatefulWidget {
  const AppPrayersTimeBuilder({super.key});

  @override
  State<AppPrayersTimeBuilder> createState() => _AppPrayersTimeBuilderState();
}

class _AppPrayersTimeBuilderState extends State<AppPrayersTimeBuilder> {
  DateTime selectedDate = DateTime.now();
  ApiResponseModel<ApiLocale?> newHijriDate = ApiResponseModel(response: ResponseEnum.initial);
  late PrayerTimesApiCubit cubit;
  late MoonImageCubit moonImageCubit;
  @override
  void initState() {
    cubit = context.read<PrayerTimesApiCubit>();
    moonImageCubit = context.read<MoonImageCubit>();
    _getPrayerTime();
    _getNewHijri();
    selectedPrayersNotifier.addListener(_selectedPrayerMethodListener);

    /// i used this function to determine the prayer time calculation method based on position if there are no cached calculation method
    positionNotifier.addListener(checkUserCountry);
    super.initState();
  }

  void _selectedPrayerMethodListener() {
    cubit.params = cubit.params.copyWith(method: selectedPrayersNotifier.value);
    if (mounted) {
      cubit.getPrayerTime();
    }
  }

  Future _getNewHijri() async {
    setState(() {
      newHijriDate = newHijriDate.copyWith(response: ResponseEnum.loading, errorMessage: null);
    });
    DateConversionRepo repo = serviceLocator();
    final response = await repo.getDateConversion(
      selectedDate,
      context.read<DateConversionCubit>().state.selectedOption ?? DataProcessingOption.regular,
    );
    response.fold(
      (_) {
        setState(() {
          newHijriDate = newHijriDate.copyWith(
            response: ResponseEnum.failure,
            errorMessage: 'Error Occured',
          );
        });
      },
      (model) {
        if (mounted) {
          setState(() {
            newHijriDate = ApiResponseModel(
              response: ResponseEnum.success,
              data: ApiLocale(ar: model.newHijriUpdatedAr, en: model.newHijriUpdated),
            );
          });
        }
      },
    );
  }

  Future _getPrayerTime() async {
    final positionInMemory = serviceLocator<GeoPosition>().getPositionInMemory();
    if (positionInMemory != null) {
      pr(
        'calling cubit.getPrayerTime() in  AppPrayersTimeBuilder widget directly because positionInMemory is not null: ${positionNotifier.value}',
      );
      cubit.params = cubit.params.copyWith(
        latitude: positionInMemory.latitude,
        longitude: positionInMemory.longitude,
        method: IslamicOrganization.muslimWorldLeague,
        latitudeAdjustmentMethod: LatitudeAdjustmentMethod.angleBased,
        date: selectedDate,
      );
      await cubit.getPrayerTime();
      return;
    }
    positionNotifier.addListener(() async {
      pr(
        'listener in AppPrayersTimeBuilder widget is called because position is changed: ${positionNotifier.value}',
      );
      if (positionNotifier.value == null) return;
      cubit.params = cubit.params.copyWith(
        latitude: positionNotifier.value!.latitude,
        longitude: positionNotifier.value!.longitude,
        method: IslamicOrganization.muslimWorldLeague,
        latitudeAdjustmentMethod: LatitudeAdjustmentMethod.angleBased,
        date: selectedDate,
      );
      await cubit.getPrayerTime();
    });
  }

  Future _handleDateChange() async {
    _getNewHijri();
    Position? position = await serviceLocator<GeoPosition>().position();
    if ([position, position?.latitude, position?.longitude].contains(null)) {
      return;
    }
    cubit.params = cubit.params.copyWith(
      date: selectedDate,
      latitude: position!.latitude,
      longitude: position.longitude,
    );
    cubit.getPrayerTime();
    moonImageCubit.dateTime = selectedDate;
    moonImageCubit.moonImage();
    selectedDateNotifier.value = selectedDate;
  }

  @override
  void dispose() {
    positionNotifier.removeListener(checkUserCountry);
    selectedPrayersNotifier.removeListener(_selectedPrayerMethodListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesApiCubit, ApiResponseModel<PrayersTimeModel>>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        selectedDate = selectedDate.subtract(const Duration(days: 1));
                        // selectedDate = DateTime(620);
                        await _handleDateChange();
                      },
                      child: Icon(Icons.arrow_back_ios_rounded, size: 30.w),
                    ),
                    Builder(
                      builder: (context) {
                        context.locale;
                        return Column(
                          children: [
                            txt(formateDateDetailed(selectedDate)),
                            newHijriDate.response == ResponseEnum.success
                                ? txt(_localize(newHijriDate.data))
                                : txt(_localize(newHijriDate.data))
                                    .animate(onPlay: (c) => c.repeat())
                                    .fade(duration: 1000.ms, begin: 0.2, end: 0.7)
                                    .then()
                                    .fade(duration: 1000.ms, begin: 0.7, end: 0.2),
                          ],
                        );
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        selectedDate = selectedDate.add(const Duration(days: 1));
                        // selectedDate = DateTime(625);
                        await _handleDateChange();
                      },
                      child: Icon(Icons.arrow_forward_ios_rounded, size: 30.w),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Material(
                borderRadius: BorderRadius.circular(15.w),
                elevation: 2,
                shadowColor: Colors.grey.withOpacity(0.3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    color: Colors.white,
                  ),
                  child: PrayersWidget(
                    state.data,
                  ).animate().fade(duration: 1000.ms, begin: 0, end: 1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _localize(ApiLocale? value) {
    if (isEnglish() && value != null && value.en != null) {
      return '${value.en!} ${selectedDate.year >= 622 ? '(H)' : '(BH)'}';
    }
    if (!isEnglish() && value != null && value.ar != null) {
      return '${value.ar!} ${selectedDate.year >= 622 ? '(هجريا)' : '(قبل الهجرة)'}';
    }
    return '';
  }
}

class PrayersWidget extends StatelessWidget {
  const PrayersWidget(this.model, {super.key});
  final PrayersTimeModel? model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 5.w),
        PrayTimeWidget(
          pray: 'Fajr',
          imagePath: AssetsData.fajr,
          time: model?.fajr,
          // currentTimeZone: model.currentTimeZone,
        ),
        PrayTimeWidget(
          pray: 'Sunrise',
          imagePath: AssetsData.three,
          time: model?.sunrise,
          // currentTimeZone: model.currentTimeZone,
        ),
        PrayTimeWidget(
          pray: 'Dhuhr',
          imagePath: AssetsData.two,
          time: model?.dhuhr,
          // currentTimeZone: model.currentTimeZone,
        ),
        PrayTimeWidget(
          pray: 'Asr',
          imagePath: AssetsData.one,
          time: model?.asr,
          // currentTimeZone: model.currentTimeZone,
        ),
        PrayTimeWidget(
          pray: 'Maghrib',
          imagePath: AssetsData.four,
          time: model?.maghrib,
          // currentTimeZone: model.currentTimeZone,
        ),
        PrayTimeWidget(
          pray: 'Isha',
          imagePath: AssetsData.five,
          time: model?.isha,
          // currentTimeZone: model.currentTimeZone,
        ),
        SizedBox(width: 5.w),
      ],
    );
  }
}

class PrayTimeWidget extends StatelessWidget {
  const PrayTimeWidget({
    super.key,
    required this.pray,
    required this.imagePath,
    required this.time,
  });
  final String pray;
  final String? time;
  final String imagePath;
  // final String? currentTimeZone;
  @override
  Widget build(BuildContext context) {
    context.locale;
    String? amOrpm;
    String? hourStr = time?.split(':').first;
    String? minStr = time?.split(':').last;
    if ([hourStr, minStr, time].contains(null)) {
      return _loadingWidget();
    }
    int? hour = intParse(hourStr);
    amOrpm = hour != null && hour >= 12 ? 'PM' : 'AM';
    hour =
        hour == null
            ? null
            : hour > 12
            ? hour - 12
            : hour;

    return SizedBox(
      // height: 110.h,
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          txt(prayerNameTr(pray), e: St.bold16),
          const SizedBox(height: 5),
          _buildImage(),
          const SizedBox(height: 5),
          txt('${hour.toString().padLeft(2, '0')}:$minStr\n$amOrpm', e: St.reg16),
        ],
      ),
    );
  }

  Column _loadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        txt(pray, e: St.bold16),
        const SizedBox(height: 5),
        CustomFadingWidget(child: _buildImage()),
        const SizedBox(height: 5),
        CustomFadingWidget(child: txt('00:00', e: St.reg16)),
      ],
    );
  }

  Container _buildImage() {
    return Container(
      width: 25.w,
      height: 30.w,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: Image.asset(imagePath, fit: BoxFit.fill),
    );
  }
}
