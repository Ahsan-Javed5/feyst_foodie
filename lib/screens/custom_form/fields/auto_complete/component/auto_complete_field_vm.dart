import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/api.dart';
import 'package:chef/models/custom_forms/external_fields/external_field.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/auto_complete/component/auto_complete_field_m.dart';
import 'package:chef/models/referencetable_response.dart';
import 'package:chef/constants/preferences.dart';
import 'package:chef/constants/strings.dart';

@injectable
class AutoCompleteFieldViewModel extends BaseViewModel<AutoCompleteFieldState> {
  AutoCompleteFieldViewModel({
    required INetworkService network,
    required INavigationService navigation,
    required IStorageService storage,
  })  : _network = network,
        _navigation = navigation,
        _storage = storage,
        super(const Loading());

  final INetworkService _network;
  final INavigationService _navigation;
  final IStorageService _storage;

  void loadFields({
    required BuildContext context,
    required String dataSourceId,
  }) async {
    try {
      final projectId = _storage.readString(key: PreferencesKeys.projectId);

      final _workspaceId =
          _storage.readString(key: PreferencesKeys.sWorkspaceId);

      final _header = {
        Api.headerProjectKey: projectId,
        Api.headerWorkspaceKey: _workspaceId,
      };

      var _pathUrl = Api.referenceTable +
          '/' +
          dataSourceId +
          '/' +
          Strings.referenceIDRecords +
          '?' +
          Strings.pageSizeKey +
          '=' +
          Strings.pageSizeValue;

      final refResponse = await _network.gaurdedGet(
        path: _pathUrl,
        header: _header,
      );

      final referenceTableRecord =
          ReferenceTableRecord.fromJson(jsonDecode(refResponse.body));

      final newState = Loaded(
        referenceTableRecord: referenceTableRecord,
      );

      emit(newState);
    } catch (error) {
      _onError(context, error);
    }
  }

  void _onError(BuildContext context, Object error) {
    Toaster.showToast(
      context: context,
      toastType: ToastType.error,
      message: error.toString(),
    );
    _navigation.pop();
    return;
  }

  void onExFieldSelection(ExtFieldSend field) {
    _navigation.pop(field);
  }

  List<String> getData(
    ReferenceTableRecord fields,
    String _labelValue,
  ) {
    var convertedToString = <String>[];
    for (var i = 0; i < (fields.rows?.length)!; i++) {
      convertedToString.add(fields.rows![i].customFields![_labelValue]);
    }
    return convertedToString;
  }
}
