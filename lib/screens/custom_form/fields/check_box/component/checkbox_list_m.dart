import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

part 'checkbox_list_m.freezed.dart';

@freezed
class CheckBoxListState extends BaseState with _$CheckBoxListState {
  const factory CheckBoxListState.loading() = Loading;
  const factory CheckBoxListState.loaded(Selectable data) = Loaded;
}
