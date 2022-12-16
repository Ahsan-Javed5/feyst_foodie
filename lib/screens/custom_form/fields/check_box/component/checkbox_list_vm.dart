import 'dart:convert';

import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/api.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/check_box/component/checkbox_list_m.dart';

@injectable
class CheckBoxListViewModel extends BaseViewModel<CheckBoxListState> {
  CheckBoxListViewModel({
    required INetworkService network,
    required ApplicationService appService,
  })  : _network = network,
        _appService = appService,
        super(const Loading());

  final INetworkService _network;
  final ApplicationService _appService;

  void loadCheckBoxes(context, datasetId) async {
    try {
      final response = await _network.gaurdedGet(
        path: Api.apiVersion +
            Api.apiDatasets +
            datasetId +
            '?parentKind=MODULE&parentRefId=' +
            _appService.state.module!.refId,
      );
      final checkBoxList = Selectable.fromJson(jsonDecode(response.body));

      emit(Loaded(checkBoxList));
    } catch (error) {
      Toaster.errorToast(context: context, message: error.toString());
      emit(const Loading());
    }
  }
}
