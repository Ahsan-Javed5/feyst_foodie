import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/select/component/dropdown_m.dart';

@injectable
class DropdownViewModel extends BaseViewModel<DropdownState> {
  DropdownViewModel({
    required INetworkService network,
    required ApplicationService appService,
  })  : _network = network,
        _appService = appService,
        super(const Loading());

  final INetworkService _network;
  final ApplicationService _appService;

  void loadDropdownDataSet({
    required BuildContext context,
    required FieldProperties properties,
  }) async {
    try {
      final response = await _network.gaurdedGet(
        path: Api.apiVersion +
            Api.apiDatasets +
            properties.dataSetId +
            '?parentKind=MODULE&parentRefId=' +
            _appService.state.module!.refId,
      );
      final dropdown = Dropdown.fromJson(jsonDecode(response.body));

      emit(
        Loaded(
          itemsData: dropdown.itemsData,
          properties: properties,
        ),
      );
    } catch (error) {
      Toaster.errorToast(context: context, message: error.toString());
      emit(const Loading());
    }
  }

  void updateSelectedInex(String index) {
    emit((state as Loaded).copyWith(selectedIndex: index));
  }
}
