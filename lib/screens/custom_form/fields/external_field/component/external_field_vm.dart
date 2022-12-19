import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/api.dart';
import 'package:chef/models/custom_forms/external_fields/external_field.dart';
import 'package:chef/screens/custom_form/fields/external_field/component/external_field_m.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';

@injectable
class ExternalFieldViewModel extends BaseViewModel<ExternalFieldState> {
  ExternalFieldViewModel({
    required INetworkService network,
    required INavigationService navigation,
  })  : _network = network,
        _navigation = navigation,
        super(const Loading());

  final INetworkService _network;
  final INavigationService _navigation;

  void loadFields({
    required BuildContext context,
    required String extId,
  }) async {
    try {
      final extFieldResponse = await _network.gaurdedGet(
        path: Api.externalFields + '/' + extId,
      );
      final externalField =
          ExternalField.fromJson(jsonDecode(extFieldResponse.body));
      final extFieldData = _createDisplayObject(externalField);
      final newState = Loaded(
        extFieldDisplay: ExtFieldDisplay.empty(),
        extFieldData: extFieldData,
      );
      emit(newState);
      await loadRecords(
        context: context,
        extId: extId,
        page: 1,
      );
    } catch (error) {
      _onError(context, error);
    }
  }

  Future<void> loadRecords({
    required BuildContext context,
    required int page,
    required String extId,
  }) async {
    try {
      final recordsResponse = await _network.gaurdedGet(
        path: Api.externalFields +
            '/' +
            extId +
            '/records?pageSize=10&page=$page',
      );
      final records = jsonDecode(recordsResponse.body)['rows'].toList();
      (state as Loaded).extFieldDisplay.title.addAll(
            getValues(records, (state as Loaded).extFieldData.names.first),
          );
      (state as Loaded)
          .extFieldDisplay
          .subtitle
          .addAll(getValues(records, (state as Loaded).extFieldData.names[1]));
      (state as Loaded).extFieldDisplay.value.addAll(
            getValues(
              records,
              (state as Loaded).extFieldData.valuePrimaryField,
            ),
          );
      final data = ExtFieldDisplay(
        title: (state as Loaded).extFieldDisplay.title,
        subtitle: (state as Loaded).extFieldDisplay.subtitle,
        value: (state as Loaded).extFieldDisplay.value,
        primaryFieldValue: (state as Loaded).extFieldData.valuePrimaryField,
      );
      final newState = (state as Loaded).copyWith(
        extFieldDisplay: data,
      );
      emit(newState);
    } catch (error) {
      _onError(context, error);
      emit(
        Loaded(
          extFieldDisplay: ExtFieldDisplay.empty(),
          extFieldData: DataFromExtField.empty(),
        ),
      );
    }
  }

  List<String> getValues(records, String key) {
    final valueList = <String>[];
    for (var index = 0; index < records.length; index++) {
      if (records[index].containsKey(key)) {
        final test = records[index][key];
        valueList.add(test ?? ' ');
      } else {
        valueList.add(' ');
      }
    }
    return valueList;
  }

  DataFromExtField _createDisplayObject(ExternalField externalField) {
    final columns = externalField.externalFieldExternal.display.columns;
    final columnNames = <String>[];
    for (var column in columns) {
      columnNames.add(column.name);
    }
    return DataFromExtField(
      names: columnNames,
      displayPrimaryField:
          externalField.externalFieldExternal.display.primaryField.name,
      valuePrimaryField:
          externalField.externalFieldExternal.value.primaryField.name,
    );
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
}
