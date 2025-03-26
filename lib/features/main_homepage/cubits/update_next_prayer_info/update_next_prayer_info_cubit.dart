import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_next_prayer_info_state.dart';

class UpdateNextPrayerInfoCubit extends Cubit<UpdateNextPrayerInfoState> {
  UpdateNextPrayerInfoCubit() : super(UpdateNextPrayerInfoState());
  update(UpdateNextPrayerInfoState newState) {
    emit(newState);
  }
}
