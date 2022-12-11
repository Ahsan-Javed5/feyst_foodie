import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/annotations.dart';
import 'package:chef/base/base.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/ui_kit/helpers/dialog_helper.dart';
import 'package:chef/services/services.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/screens/custom_form/custom_form_screen_m.dart';
import 'package:chef/screens/custom_form/custom_form_screen_vm.dart';
import 'package:chef/screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_v.dart';
import 'package:chef/screens/custom_form/widgets/exto_field_form.dart';
import 'package:chef/screens/custom_form/widgets/workflow_action_form.dart';

import 'package:chef/models/custom_forms/custom_form.dart';

class CustomFormScreen extends BaseView<CustomFormScreenViewModel> {
  CustomFormScreen({
    required String moduleName,
    required String? recordId,
    @PathParam(Strings.formIdParam) String? formId,
    bool? isInEditMode = false,
    bool hasEditPermission = true,
    String? recordNumber,
    String? recordRefId,
    Key? key,
  })  : _formId = formId,
        _isInEditMode = isInEditMode!,
        _moduleName = moduleName,
        _recordId = recordId,
        _hasEditPermission = hasEditPermission,
        _recordNumber = recordNumber,
        _recordRefId = recordRefId,
        super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _dialogKey = GlobalKey<FormState>();
  final String? _formId;
  final String _moduleName;
  final String? _recordId;
  final bool _isInEditMode;
  final bool _hasEditPermission;
  final String? _recordNumber;
  final String? _recordRefId;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final _appTheme = AppTheme.of(context).theme;

    viewModel.loadForm(
      context: context,
      formId: _formId,
      isInEditMode: _isInEditMode,
    );
    return BlocBuilder<CustomFormScreenViewModel, CustomFormScreenState>(
      bloc: viewModel,
      builder: (_, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _appbar(
              context: context,
              appTheme: _appTheme,
            ),
            drawer: CustomFieldSideBar(
              moduleName: _moduleName,
              recordNumber: _recordNumber,
              isInEditMode: _isInEditMode,
              recordRefId: _recordRefId,
            ),
            body: state.when(
              loading: _loading,
              loaded: (fields, renderer) => _buildSuccess(fields),
            ),
          ),
        );
      },
    );
  }

  Widget _loading() => const SizedBox(height: 100, child: ExtoLoading());

  ExtoForm _buildSuccess(List<Fields> _fields) {
    return ExtoForm(
      renderer: viewModel.renderer,
      fields: _fields,
      recordId: _recordId,
      formKey: _formKey,
      isInEditMode: _isInEditMode,
      hasEditPermission: _hasEditPermission,
    );
  }

  AppBar _appbar({
    required BuildContext context,
    required IAppThemeData appTheme,
  }) {
    return AppBar(
      title: ExtoText(
        _moduleName,
        typography: TypographyFamily.headline4,
        color: appTheme.colors.secondaryBackground,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.save),
          tooltip: Strings.saveAsDraft,
          onPressed: () {
            final permissionToAction =
                viewModel.checkForPermissions(isInEditMode: _isInEditMode) &&
                    _hasEditPermission;
            if (permissionToAction) {
              viewModel.performWorkflowAction(
                context: context,
                isInEditMode: _isInEditMode,
                recordId: _recordId,
                isSaveAsDraft: true,
                moduleName: _moduleName,
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.attractions_sharp),
          tooltip: Strings.workflowActionTitle,
          onPressed: () {
            if (viewModel.isStateValid(_formKey.currentState!)) {
              _workflowActionDialog(context: context);
            } else {
              Toaster.errorToast(
                context: context,
                message: Strings.formInvalid,
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          tooltip: Strings.workflowCloseText,
          onPressed: () => viewModel.pop(value: !_isInEditMode),
        ),
      ],
    );
  }

  Future<void> _workflowActionDialog({
    required BuildContext context,
  }) async {
    final permissionToAction =
        viewModel.checkForPermissions(isInEditMode: _isInEditMode) &&
            _hasEditPermission;
    var actionData = {
      Strings.actionKey: '',
      Strings.commentKey: '',
    };

    if (permissionToAction) {
      DialogHelper.show(
        context: context,
        title: Strings.workflowActionTitle,
        body: WorkflowActionForm(
          onChange: (workflowActionData) {
            actionData = workflowActionData;
          },
          appService: viewModel.appService,
          formKey: _dialogKey,
          isInEditMode: _isInEditMode,
        ),
        isDismissible: false,
        maxHeight: 500,
        actions: [
          DialogAction(
            type: DialogActionType.ok,
            isBusy: false,
            title: Strings.workflowDoneText,
            onAction: () => viewModel.onDialogAction(
              context: context,
              state: _dialogKey.currentState,
              isInEditMode: _isInEditMode,
              recordId: _recordId,
              actionData: actionData,
            ),
            buttonKind: ButtonType.button,
            buttonStyleType: ButtonStyleType.fill,
          ),
          DialogAction.cancel(
            onAction: () => viewModel.pop(),
          ),
        ],
      );
    } else {
      Toaster.errorToast(
        context: context,
        message: Strings.noPermissionToAction,
      );
    }
  }
}
