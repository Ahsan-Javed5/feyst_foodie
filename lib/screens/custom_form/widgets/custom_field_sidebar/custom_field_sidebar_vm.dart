import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:open_file/open_file.dart';

import 'package:chef/models/custom_forms/attachment_details.dart';
import 'package:chef/models/custom_forms/upload_attachment.dart';
import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/helpers/toaster_helper.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chef/models/models.dart';
import 'package:chef/screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_m.dart';

@injectable
class CustomFieldSideBarViewModel
    extends BaseViewModel<CustomFieldSideBarState> {
  CustomFieldSideBarViewModel({
    required ApplicationService appState,
    required INetworkService network,
    required IStorageService storageService,
    required this.renderer,
  })  : _appService = appState,
        _network = network,
        _storageService = storageService,
        super(
          const Loading([]),
        );

  final ApplicationService _appService;
  final INetworkService _network;
  final IRendererService renderer;
  final IStorageService _storageService;

  void loadAttachmentList({
    required BuildContext context,
    required String moduleName,
    required String linkedID,
  }) async {
    final exitData = <Attachment>[];
    try {
      final projectId =
          _storageService.readString(key: PreferencesKeys.projectId);
      final header = {
        Api.headerProjectKey: projectId,
      };

      final apiResponse = await _network.gaurdedGet(
        path: Api.apiVersion +
            Api.apiDocuments +
            '?module=$moduleName&linkedID=$linkedID',
        header: header,
      );
      final forms = jsonDecode(apiResponse.body);
      final data = forms[PreferencesKeys.data];
      for (var item in data) {
        exitData.add(
          Attachment.fromJson(item),
        );
      }
      emit(Loaded(exitData));
    } catch (error) {
      Toaster.errorToast(
        context: context,
        message: error.toString(),
      );
      emit(const Loaded([]));
    }
  }

  void loadNewRecordAttachedList(BuildContext context) async {
    late final List<String> ids;
    try {
      ids = _appService.state.workflow!.documentIds!;
    } catch (e) {
      ids = [];
    }
    var newAttachedFiles = <Attachment>[];
    if (ids.isNotEmpty) {
      try {
        final projectId =
            _storageService.readString(key: PreferencesKeys.projectId);
        final header = {
          Api.headerProjectKey: projectId,
        };
        var filesFuture = <Future<dynamic>>[];
        for (var id in ids) {
          filesFuture.add(
            _network.gaurdedGet(
              path: Api.apiVersion + Api.apiDocuments + '/$id',
              header: header,
            ),
          );
        }
        final responses = await Future.wait(filesFuture);
        for (var response in responses) {
          var attachmentDetails =
              AttachmentDetails.fromJson(jsonDecode(response.body));
          var attachmentData = attachmentDetails.data;

          newAttachedFiles.add(Attachment.fromJson(attachmentData.toJson()));
        }
        emit(Loaded(newAttachedFiles));
      } catch (error) {
        Toaster.errorToast(
          context: context,
          message: error.toString(),
        );
        emit(const Loaded([]));
      }
    } else {
      emit(const Loaded([]));
    }
  }

  String getDocumentTitle(String documentId, List<Attachment> attachmentList) {
    var name = '';
    for (var item in attachmentList) {
      if (item.id == documentId) name = item.name;
    }
    return name;
  }

  void downloadAttachment(BuildContext context, String documentId) async {
    emit(Loading(state.attachmentList));

    final path = Api.apiVersion +
        Api.apiDocuments +
        '${Api.apiDocumentsDownloadSwitch}/$documentId';

    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        final response = await _network.gaurdedGet(path: path);
        final filename = getDocumentTitle(documentId, state.attachmentList);
        final savedFile = await _saveFile(response, filename);
        final length = await savedFile.length();
        if (length <= 0) {
          Toaster.errorToast(
            context: context,
            message: Strings.downloadFileError,
          );
        }
      } else if (status.isDenied) {
        Toaster.errorToast(
          context: context,
          message: Strings.needPermissions,
        );
      } else if (status.isPermanentlyDenied) {
        Toaster.errorToast(
          context: context,
          message: Strings.openSettings,
          actions: [
            ToastAction.ok(
              onTap: () {
                OpenSettings.openAppSetting();
              },
            )
          ],
        );
      }
      emit(Loaded(state.attachmentList));
    } catch (e) {
      Toaster.errorToast(
        context: context,
        message: e.toString(),
      );
    }
    emit(Loaded(state.attachmentList));
  }

  Future<File> _saveFile(Response response, String filename) async {
    var path = Strings.downloadBasePath + filename;
    var file = File(path);

    if (!await file.exists()) {
      file = await file.writeAsBytes(response.bodyBytes);
    }
    OpenFile.open(path);
    return file;
  }

  void uploadAttachment({
    required BuildContext context,
    required String moduleName,
    required bool isInEditMode,
    String? linkedId,
    String? linkedRefId,
  }) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        emit(Loading(state.attachmentList));
        final file = File(result.files.single.path!);
        final projectId =
            _storageService.readString(key: PreferencesKeys.projectId);
        final workspaceId =
            _storageService.readString(key: PreferencesKeys.sWorkspaceId);

        final _header = {
          Api.headerProjectKey: projectId,
          Api.headerWorkspaceKey: workspaceId,
        };

        const url =
            Api.apiVersion + Api.apiDocuments + Api.apiDocumentsUploadSwitch;

        final formData = {
          Api.uploadFile: file.path,
          Api.uploadModule: moduleName,
          Api.uploadLinkedID: linkedId,
          Api.uploadLinkedRefID: linkedRefId,
          Api.uploadMeta: jsonEncode({}),
        };

        final response = await _network.upload(
          path: url,
          formData: formData,
          header: _header,
        );
        if (response.statusCode == 201) {
          final uploadedAttachment =
              UploadAttachment.fromJson(jsonDecode(response.body));

          if (!isInEditMode) {
            _appService.updateNewRecordAttachedFilesList(
              uploadedAttachment.data.documentId,
            );
          }
          final successMessage = uploadedAttachment.message;
          Toaster.successToast(
            context: context,
            message: successMessage,
          );
        } else {
          Toaster.errorToast(
            context: context,
            message: response.reasonPhrase!,
          );
        }
      } catch (e) {
        Toaster.showToast(
          context: context,
          message: e.toString(),
          toastType: ToastType.error,
        );
      }
      !isInEditMode
          ? loadNewRecordAttachedList(context)
          : loadAttachmentList(
              context: context,
              moduleName: moduleName,
              linkedID: linkedId!,
            );
    }
  }
}
