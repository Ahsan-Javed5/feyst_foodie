import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/models/models.dart';
import 'package:chef/base/base.dart';

part 'radio_list_m.freezed.dart';

@freezed
class RadioListState extends BaseState with _$RadioListState {
  const factory RadioListState.loading() = Loading;
  const factory RadioListState.loaded({
    required Selectable data,
    int? selectedIndex,
  }) = Loaded;
}
