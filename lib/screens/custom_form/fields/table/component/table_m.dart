import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

part 'table_m.freezed.dart';

@freezed
class TableState extends BaseState with _$TableState {
  const factory TableState.loading() = Loading;
  const factory TableState.loaded(Map<dynamic, dynamic> subTableData) = Loaded;
}
