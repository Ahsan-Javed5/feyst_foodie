import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

part 'check_list_m.freezed.dart';

@freezed
class CheckListState extends BaseState with _$CheckListState {
  const factory CheckListState.loading() = Loading;
  const factory CheckListState.loaded(CheckList data) = Loaded;
  const factory CheckListState.error() = Error;
}
