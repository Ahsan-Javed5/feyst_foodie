import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

part 'table_attachments_m.freezed.dart';

@freezed
class TableAttachmentsState extends BaseState
    with _$TableAttachmentsState {
  const factory TableAttachmentsState.loading(
    List<Attachment> attachmentList,
  ) = Loading;
  const factory TableAttachmentsState.loaded(
    List<Attachment> attachmentList,
  ) = Loaded;
}
