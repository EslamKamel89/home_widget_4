import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/models/api_response_model.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/features/main_homepage/cubits/moon_image/moon_image_cubit.dart';
import 'package:home_widget_4/features/main_homepage/presentation/widgets/moon_image_detailed_modal.dart';

class MoonPhaseImage extends StatefulWidget {
  const MoonPhaseImage({super.key});

  @override
  State<MoonPhaseImage> createState() => _MoonPhaseImageState();
}

class _MoonPhaseImageState extends State<MoonPhaseImage> {
  late MoonImageCubit cubit;
  @override
  void initState() {
    cubit = context.read<MoonImageCubit>();
    _getMoonImage();
    super.initState();
  }

  Future _getMoonImage() async {
    final positionInMemory = serviceLocator<GeoPosition>().getPositionInMemory();
    if (positionInMemory != null) {
      pr(
        'calling cubit.moonImage() in  MoonPhaseImage widget directly because positionInMemory is not null: ${positionNotifier.value}',
      );
      cubit.position = positionInMemory;
      cubit.dateTime = cubit.dateTime ?? DateTime.now();
      await cubit.moonImage();
      return;
    }
    positionNotifier.addListener(() async {
      pr(
        'listener in MoonPhaseImage widget is called because position is changed: ${positionNotifier.value}',
      );
      if (positionNotifier.value == null) return;
      cubit.position = positionNotifier.value;
      cubit.dateTime = cubit.dateTime ?? DateTime.now();
      await cubit.moonImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoonImageCubit, ApiResponseModel<String?>>(
      builder: (context, state) {
        return Container(
          // color: Colors.red,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: context.height / 4),
            child: SizedBox(
              // width: context.width * 0.7,
              child:
                  [ResponseEnum.loading, ResponseEnum.initial].contains(state.response)
                      ? LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            margin: EdgeInsets.only(left: context.width / 5),
                            child: const Center(
                              child: CircularProgressIndicator(color: Colors.white),
                            ),
                          );
                        },
                      )
                      : state.response == ResponseEnum.success && state.data != null
                      ? SizedBox(
                        width: context.width * 0.7,
                        child: InkWell(
                          onTap: () {
                            final positionInMemory =
                                serviceLocator<GeoPosition>().getPositionInMemory();
                            if ([positionInMemory, cubit.dateTime].contains(null)) return;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MoonImageDetailedModal(
                                  position: positionInMemory!,
                                  date: cubit.dateTime!,
                                );
                              },
                            );
                          },
                          child: CachedNetworkImage(imageUrl: state.data!),
                        ),
                      ).animate().scale(
                        duration: 1000.ms,
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                      )
                      : const SizedBox(),
            ),
          ),
        );
      },
    );
  }
}
