import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

part 'dropdown_m.freezed.dart';

@freezed
class DropdownState extends BaseState with _$DropdownState {
  const factory DropdownState.loading() = Loading;
  const factory DropdownState.loaded({
    required FieldProperties properties,
    required List<DropdownItems> itemsData,
    String? selectedIndex,
  }) = Loaded;
}
