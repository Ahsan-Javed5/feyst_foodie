import 'package:chef/models/models.dart';

class ChecklistHelper {
  CheckList updateChecklist({
    required CheckList checkList,
    required List<CheckListItem> itemList,
  }) {
    return CheckList(
      items: itemList,
      checklistId: checkList.id,
      id: checkList.id,
      createdAt: checkList.createdAt,
      createdBy: checkList.createdBy,
      name: checkList.name,
      tenantId: checkList.tenantId,
      updatedAt: checkList.updatedAt,
      updatedBy: checkList.updatedBy,
      version: checkList.version,
    );
  }

  CheckListItem updateChecklistItem({
    required CheckListItem checkListItem,
    required Map<String, dynamic> value,
  }) {
    return CheckListItem(
      value: value,
      attachments: checkListItem.attachments,
      description: checkListItem.description,
      id: checkListItem.id,
      items: checkListItem.items,
      linkedModules: checkListItem.linkedModules,
      mandatory: checkListItem.mandatory,
      mandatoryWhenValueIs: checkListItem.mandatoryWhenValueIs,
      notes: checkListItem.notes,
      options: checkListItem.options,
      showAudit: checkListItem.showAudit,
      uiType: checkListItem.uiType,
      filledAt: checkListItem.filledAt,
      filledBy: checkListItem.filledBy,
    );
  }

  CheckListItem updateChecklistInnerItem({
    required CheckListItem checkListItem,
    required String id,
    required String value,
  }) {
    var customChecklistItem = checkListItem;
    var selected = customChecklistItem.items
        ?.where((element) => element.id == id)
        .toList()[0];

    if (selected != null) {
      var selectedIndex = customChecklistItem.items?.indexOf(selected) ?? 0;
      customChecklistItem.items
          ?.replaceRange(selectedIndex, selectedIndex + 1, [
        Item(
          description: selected.description,
          attachments: selected.attachments,
          id: selected.id,
          items: selected.items,
          linkedModules: selected.linkedModules,
          mandatory: selected.mandatory,
          mandatoryWhenValueIs: selected.mandatoryWhenValueIs,
          notes: selected.notes,
          options: selected.options,
          showAudit: selected.showAudit,
          uiType: selected.uiType,
          warnWhenValueIs: selected.warnWhenValueIs,
          value: [value],
        ),
      ]);
    }

    return CheckListItem(
      items: customChecklistItem.items,
      attachments: checkListItem.attachments,
      description: checkListItem.description,
      id: checkListItem.id,
      linkedModules: checkListItem.linkedModules,
      mandatory: checkListItem.mandatory,
      mandatoryWhenValueIs: checkListItem.mandatoryWhenValueIs,
      notes: checkListItem.notes,
      options: checkListItem.options,
      showAudit: checkListItem.showAudit,
      uiType: checkListItem.uiType,
      value: checkListItem.value,
      filledAt: checkListItem.filledAt,
      filledBy: checkListItem.filledBy,
    );
  }
}
