import 'dart:convert';

import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/table/component/table_m.dart';
import 'package:chef/constants/constants.dart';

import 'package:chef/models/custom_forms/table_record.dart';

@injectable
class TableViewModel extends BaseViewModel<TableState> {
  TableViewModel({
    required INetworkService network,
    required this.renderer,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _network = network,
        _storage = storage,
        _appService = appService,
        super(const Loading());

  final INetworkService _network;
  final IRendererService renderer;
  final IStorageService _storage;
  final ApplicationService _appService;

  void loadFormOfTable(context, String? recordId, isInEditMode) async {
    try {
      final projectId = _storage.readString(key: PreferencesKeys.projectId);
      final header = {Api.headerProjectKey: projectId};
      final moduleName = _appService.state.workflow!.moduleName;

      if (recordId != null && recordId.isNotEmpty) {
        var _urlPath = Api.records +
            '/' +
            recordId +
            '?moduleName=$moduleName' +
            '&projectID=' +
            projectId;

        final response = await _network.gaurdedGet(
          path: _urlPath,
          header: header,
        );

        final tabRecord = TableRecord.fromJson(json.decode(response.body));

        emit(Loaded(tabRecord.subtableData!));
      } else {
        var empty = {};
        emit(Loaded(empty));
      }
    } catch (error) {
      Toaster.errorToast(context: context, message: error.toString());
      emit(const Loading());
    }
  }
}
