import 'package:chef/base/base.dart';
import 'package:chef/models/booking/booking_list_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/booking/advance_pending_response.dart';

part 'booking_item_screen_m.freezed.dart';

@freezed
class BookingItemScreenState extends BaseState with _$BookingItemScreenState {
  const factory BookingItemScreenState.loading() = Loading;
  const factory BookingItemScreenState.loaded(
      AdvancePendingResponse advancePendingResponse) = Loaded;
}
