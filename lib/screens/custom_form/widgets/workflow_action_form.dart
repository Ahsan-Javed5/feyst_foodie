import 'package:flutter/material.dart';

import 'package:chef/constants/constants.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';

class WorkflowActionForm extends StatelessWidget {
  WorkflowActionForm({
    required Function(Map<String, String>) onChange,
    required ApplicationService appService,
    required GlobalKey<FormState> formKey,
    required bool isInEditMode,
    Key? key,
  })  : _onChange = onChange,
        _appService = appService,
        _formKey = formKey,
        _isInEditMode = isInEditMode,
        super(key: key);

  final Function(Map<String, String>) _onChange;
  final ApplicationService _appService;
  final GlobalKey<FormState> _formKey;
  final bool _isInEditMode;

  final _wfActions = <String>[];
  final _commentController = TextController();

  final actionData = <String, String>{
    Strings.actionKey: '',
    Strings.commentKey: '',
  };

  void initActionDropdown({required bool isInEditMode}) {
    final isNonSubmittedDraft =
        _appService.state.workflow!.record?.workflowId != null &&
            _appService.state.workflow!.record!.workflowId!.isNotEmpty;
    if (isInEditMode && isNonSubmittedDraft) {
      final wfPermission = _appService.state.workflow!.editPermission;
      if (wfPermission!.submit || wfPermission.edit || wfPermission.withdraw) {
        final _actions = _appService.state.workflow!.actions;
        if (_actions != null) {
          _wfActions.addAll(_actions.map((e) => e.name));
        }
      }
    } else {
      final _actions = _appService.state.workflow!.actions;
      if (_actions != null) {
        _wfActions.addAll(_actions.map((e) => e.name));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initActionDropdown(isInEditMode: _isInEditMode);
    if (_wfActions.isEmpty) Navigator.of(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            GeneralLabelContainer(
              label: Strings.workflowActionTitle,
              hideLabel: false,
              isMandatory: false,
              isReadOnly: false,
              child: GeneralDropdownWithSearch(
                name: '',
                items: _wfActions,
                isMandatory: true,
                onChange: ({required key, value}) {
                  actionData[Strings.actionKey] = value;
                  _onChange(actionData);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GeneralLabelContainer(
              label: Strings.commentKey,
              hideLabel: false,
              isMandatory: true,
              isReadOnly: false,
              child: GeneralTextInput(
                controller: _commentController,
                validator: FieldRendererHelpers.validatorFunction,
                isMultiline: true,
                onChanged: (comment) {
                  actionData[Strings.commentKey] = comment;
                  _onChange(actionData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
