import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/api.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/check_list/component/check_list_m.dart'
    as checklist;

@injectable
class CheckListViewModel extends BaseViewModel<checklist.CheckListState> {
  CheckListViewModel({
    required INetworkService network,
    required IRendererService renderer,
    required ApplicationService appService,
  })  : _network = network,
        _renderer = renderer,
        _appService = appService,
        super(const checklist.Loading());

  final INetworkService _network;
  final IRendererService _renderer;
  final ApplicationService _appService;
  late final CheckList _checkList;
  late dynamic response;

  void loadCheckList({
    required BuildContext context,
    required String checkListID,
    required String recordId,
    required bool isInEditMode,
    required List? existingCheckList,
  }) async {
    try {
      if (isInEditMode) {
        response = await _network.gaurdedGet(
          path: Api.records +
              '/' +
              recordId +
              '?moduleName=' +
              _appService.state.workflow!.moduleName,
        );
        try {
          _checkList = existingCheckListFromJson(response.body).checklist![0];
        } catch (error) {
          _checkList = existingCheckListFromJson(response.body)
              .customFields!
              .checkList![0];
        }
      } else {
        response = await _network.gaurdedGet(
          path: Api.apiVersion + Api.checkListById + '/' + checkListID,
        );
        _checkList = checkListFromJson(response.body);
      }
      emit(checklist.Loaded(_checkList));
    } catch (error) {
      Toaster.errorToast(context: context, message: error.toString());
      emit(const checklist.Error());
    }
  }

  void updateLoadedCheckList(CheckList _checkList) {
    emit(checklist.Loaded(_checkList));
  }

  void updateCheckList({
    required CheckList mainCheckList,
    required String key,
    required String value,
    required CheckListItem item,
    required FieldOnChange onChange,
  }) {
    const checkListKey = 'checklist';
    var customCheckList = CheckList();

    if (_renderer.fieldInputData[checkListKey] != null &&
        _renderer.fieldInputData[checkListKey].contains(mainCheckList)) {
      customCheckList = _renderer.fieldInputData[checkListKey]
          .firstWhere((element) => element.id == mainCheckList.id);
    } else {
      customCheckList = mainCheckList;
    }

    if (key.length >= 23) {
      var existedList = customCheckList.items?.toSet().toList() ?? [];

      var selectedItem =
          existedList.firstWhere((element) => element.id == item.id);

      var selectedIndex = existedList.indexOf(selectedItem);
      existedList.replaceRange(
        selectedIndex,
        selectedIndex + 1,
        [
          ChecklistHelper().updateChecklistItem(
            checkListItem: item,
            value: {value: true},
          ),
        ],
      );

      customCheckList = ChecklistHelper().updateChecklist(
        checkList: customCheckList,
        itemList: existedList,
      );
      var selectedCheckListItem =
          customCheckList.items!.firstWhere((element) => element.id == item.id);
      for (var element in selectedCheckListItem.items ?? []) {
        if (element.id != null) {
          updateInnerChecklist(
            item: selectedCheckListItem,
            id: element.id.toString(),
            value: value,
            checkList: customCheckList,
            customCheckList: customCheckList,
          );
        }
      }
    } else {
      updateInnerChecklist(
        item: item,
        id: key,
        value: value,
        checkList: customCheckList,
        customCheckList: customCheckList,
      );
    }
    updateLoadedCheckList(customCheckList);

    onChange.call(
      key: checkListKey,
      value: _renderer.fieldInputData[checkListKey]?.add(customCheckList) ??
          [customCheckList],
    );
  }

  void addChecklistToRenderer({
    required FieldOnChange onChange,
    required CheckList mainCheckList,
  }) {
    const checkListKey = 'checklist';
    final moduleData = _appService.state.workflow?.moduleRecord;

    if (moduleData != null) {
      if (moduleData.isEmpty) {
        onChange.call(
          key: checkListKey,
          value: _renderer.fieldInputData[checkListKey]?.add(mainCheckList) ??
              [mainCheckList],
        );
      }
    }
  }

  void updateInnerChecklist({
    required CheckListItem item,
    required String id,
    required String value,
    required CheckList checkList,
    required CheckList customCheckList,
  }) {
    var existedList = customCheckList.items?.toSet().toList() ?? [];
    var selectedItem =
        existedList.firstWhere((element) => element.id == item.id);

    var selectedIndex = existedList.indexOf(selectedItem);

    existedList.replaceRange(
      selectedIndex,
      selectedIndex + 1,
      [
        ChecklistHelper().updateChecklistInnerItem(
          checkListItem: item,
          id: id,
          value: value,
        ),
      ],
    );

    customCheckList = ChecklistHelper().updateChecklist(
      checkList: checkList,
      itemList: existedList,
    );
  }
}
