import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

part 'custom_form_screen_m.freezed.dart';

@freezed
class CustomFormScreenState extends BaseState with _$CustomFormScreenState {
  const factory CustomFormScreenState.loading() = Loading;
  const factory CustomFormScreenState.loaded({
    required List<Fields> fields,
    required Map<String, String> workflowActionData,
  }) = Loaded;
}
