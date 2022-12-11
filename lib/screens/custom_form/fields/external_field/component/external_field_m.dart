import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/custom_forms/external_fields/external_field.dart';

part 'external_field_m.freezed.dart';

@freezed
class ExternalFieldState extends BaseState with _$ExternalFieldState {
  const factory ExternalFieldState.loading() = Loading;
  const factory ExternalFieldState.loaded({
    required ExtFieldDisplay extFieldDisplay,
    required DataFromExtField extFieldData,
  }) = Loaded;
}
