import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/referencetable_response.dart';

part 'auto_complete_field_m.freezed.dart';

@freezed
class AutoCompleteFieldState extends BaseState with _$AutoCompleteFieldState {
  const factory AutoCompleteFieldState.loading() = Loading;
  const factory AutoCompleteFieldState.loaded({
    required ReferenceTableRecord referenceTableRecord,
  }) = Loaded;
}
