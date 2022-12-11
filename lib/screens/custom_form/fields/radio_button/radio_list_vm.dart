import 'dart:convert';

import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/api.dart';
import 'package:chef/helpers/enum_helper.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/radio_button/radio_list_m.dart';

@injectable
class RadioListViewModel extends BaseViewModel<RadioListState> {
  RadioListViewModel({
    required INetworkService network,
    required ApplicationService appService,
  })  : _network = network,
        _appService = appService,
        super(const Loading());

  final INetworkService _network;
  final ApplicationService _appService;

  void loadRadioButtons(context, datasetId) async {
    try {
      final response = await _network.gaurdedGet(
        path: Api.apiVersion +
            Api.apiDatasets +
            datasetId +
            '?parentKind=MODULE&parentRefId=' +
            _appService.state.module!.refId,
      );
      final radioList = Selectable.fromJson(jsonDecode(response.body));

      emit(Loaded(data: radioList));
    } catch (error) {
      Toaster.errorToast(context: context, message: error.toString());
      emit(const Loading());
    }
  }

  void updateSelectedIndex({
    required int index,
    required String id,
    required FieldOnChange onChange,
  }) {
    if ((state as Loaded).selectedIndex == index) {
      onChange.call(
        key: id,
        value: EnumHelpers.humanize(SelectableStatus.checked),
      );
    } else {
      onChange.call(
        key: id,
        value: EnumHelpers.humanize(SelectableStatus.checked),
      );
    }
  }
}
