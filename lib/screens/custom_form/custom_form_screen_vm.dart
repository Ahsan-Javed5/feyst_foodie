import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/ui_kit/helpers/dialog_helper.dart';
import 'package:chef/screens/custom_form/custom_form_screen_m.dart';

@injectable
class CustomFormScreenViewModel extends BaseViewModel<CustomFormScreenState> {
  CustomFormScreenViewModel({
    required INetworkService network,
    required INavigationService navigationService,
    required IStorageService storage,
    required this.renderer,
    required this.appService,
  })  : _network = network,
        _navigation = navigationService,
        _storage = storage,
        super(const Loading());

  final ApplicationService appService;
  final IRendererService renderer;

  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;

  @override
  Future<void> close() {
    renderer.clearFieldInputData();
    return super.close();
  }

  void loadForm({
    required BuildContext context,
    required bool isInEditMode,
    String? formId,
    String? recordId,
  }) async {
    try {
      if (!isInEditMode) {
        renderer.clearFieldInputData();
      }
      final apiResponse = await _network.gaurdedGet(
        path: Api.apiVersion + Api.apiForms + '?query={"_id":"$formId"}',
      );
      final formResponse =
          CustomFormDataResponse.fromJson(jsonDecode(apiResponse.body)['rows']);

      final form =
          formResponse.forms.firstWhere((element) => element.sId == formId);
      appService.updateFormRefId(form.refID);
      emit(
        Loaded(
          fields: form.fields!,
          workflowActionData: {},
        ),
      );
    } catch (error) {
      Toaster.errorToast(
        context: context,
        message: error.toString(),
      );
      emit(
        const Loaded(
          fields: [],
          workflowActionData: {},
        ),
      );
    }
  }

  void pop({bool value = false}) => _navigation.pop(value);

  bool needConfirmation() =>
      (state as Loaded).workflowActionData[Strings.actionKey] != Strings.submit;

  void performWorkflowAction({
    required BuildContext context,
    required bool isInEditMode,
    required bool isSaveAsDraft,
    String? recordId,
    String? moduleName,
  }) async {
    final projectId = _storage.readString(key: PreferencesKeys.projectId);
    final tenantID = _storage.readString(key: PreferencesKeys.sTenantId);
    final _workspaceId = _storage.readString(key: PreferencesKeys.sWorkspaceId);
    final baseUrl = _storage.readString(key: PreferencesKeys.sBaseUrl);

    final workflowAction =
        (state as Loaded).workflowActionData[Strings.actionKey];

    if (!isSaveAsDraft) {
      appService.updateWorkflowComment(
        (state as Loaded).workflowActionData[Strings.commentKey]!,
      );
    }
    appService.updateWorkflowData(renderer.fieldInputData);
    final formRefId = appService.state.workflow!.formRefId;

    late String _path;

    final _workflows = appService.state.workflow!.record?.workflow ?? [];

    final data = appService.state.workflow!.toJson(
      isInEdit: isInEditMode,
      recordId: recordId,
      actionName: workflowAction,
      saveAsDraft: isSaveAsDraft,
      formRefId: formRefId,
      workflowId: appService.state.workflow?.workflowId,
      currentStepName: appService.state.workflow?.currentStepName,
      isWorkflowsEmpty: _workflows.isEmpty,
    );

    try {
      var header = <String, String>{
        Api.headerTenantKey: tenantID,
        Api.headerWorkspaceKey: _workspaceId,
        Api.headerProjectKey: projectId,
      };

      if (isSaveAsDraft) {
        if (recordId == null) {
          _path = Api.saveAsDraft + '?moduleName=$moduleName';
          await _network.gaurdedPost(
            path: _path,
            data: jsonEncode(data),
            header: header,
          );
        } else {
          _path = Api.saveAsDraft + '/$recordId' + '?moduleName=$moduleName';
          await _network.gaurdedPut(
            path: _path,
            data: jsonEncode(data),
            header: header,
          );
        }
      } else {
        await _network.gaurdedPost(
          baseURL: baseUrl.split(Api.client)[0] + Api.rest,
          path: _workflows.isEmpty ? Api.createWorkflow : Api.submitWorkflow,
          data: jsonEncode(data),
          header: header,
        );
      }

      Toaster.successToast(
        context: context,
        message: Strings.workflowSuccessMessage,
      );
      _navigation.pop(true);
    } catch (error) {
      Toaster.errorToast(
        context: context,
        message: error.toString(),
      );
    }
  }

  void updateWorkflowActionData(Map<String, String> workflowActionData) {
    emit((state as Loaded).copyWith(workflowActionData: workflowActionData));
  }

  bool checkForPermissions({required bool isInEditMode}) {
    final isNonSubmittedDraft =
        appService.state.workflow!.record?.workflowId != null &&
            appService.state.workflow!.record!.workflowId!.isNotEmpty;
    if (isInEditMode && isNonSubmittedDraft) {
      final wfPermission = appService.state.workflow!.editPermission!;
      return wfPermission.submit || wfPermission.edit || wfPermission.withdraw;
    } else {
      return appService.state.workflow!.createPermission!.create;
    }
  }

  bool isStateValid(FormState? state) => state?.validate() ?? false;

  void onDialogAction({
    required BuildContext context,
    required FormState? state,
    required bool isInEditMode,
    required String? recordId,
    required Map<String, String> actionData,
  }) async {
    if (isStateValid(state)) {
      if (needConfirmation()) {
        await DialogHelper.confirmationDialog(
          context: context,
          onConfirm: () {
            updateWorkflowActionData(actionData);
            performWorkflowAction(
              context: context,
              isInEditMode: isInEditMode,
              recordId: recordId,
              isSaveAsDraft: false,
            );
            pop(value: true);
          },
        );
      } else {
        performWorkflowAction(
          context: context,
          isInEditMode: isInEditMode,
          recordId: recordId,
          isSaveAsDraft: false,
        );
      }
      pop(value: true);
    }
  }
}
