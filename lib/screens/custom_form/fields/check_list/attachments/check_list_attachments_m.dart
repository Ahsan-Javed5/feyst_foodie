import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

part 'check_list_attachments_m.freezed.dart';

@freezed
class CheckListAttachmentsState extends BaseState
    with _$CheckListAttachmentsState {
  const factory CheckListAttachmentsState.loading(
    List<Attachment> attachmentList,
  ) = Loading;
  const factory CheckListAttachmentsState.loaded(
    List<Attachment> attachmentList,
  ) = Loaded;
}
