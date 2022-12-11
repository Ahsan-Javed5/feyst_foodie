import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

part 'custom_field_sidebar_m.freezed.dart';

@freezed
class CustomFieldSideBarState extends BaseState with _$CustomFieldSideBarState {
  const factory CustomFieldSideBarState.loading(
    List<Attachment> attachmentList,
  ) = Loading;
  const factory CustomFieldSideBarState.loaded(
    List<Attachment> attachmentList,
  ) = Loaded;
}
