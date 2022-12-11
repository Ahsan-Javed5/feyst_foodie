import 'package:chef/helpers/enum_helper.dart';

import 'package:chef/constants/strings.dart';

enum TableFieldType {
  string,
  number,
  date,
  paragraph,
  checkbox,
  radioButton,
  select,
  section,
  column,
  twoColumn,
  threeColumn,
  checkList,
  table,
  externalField,
}

abstract class TableFieldRendererHelpers {
  static TableFieldType specifyFieldType(String type) {
    var fieldType = EnumHelpers.humanize(type);
    switch (fieldType) {
      case Strings.tableString:
        return TableFieldType.string;
      case Strings.tableDigit:
        return TableFieldType.number;
      case Strings.tableDate:
        return TableFieldType.date;
      case Strings.tableCheckBox:
        return TableFieldType.checkbox;
      case Strings.tableSelect:
        return TableFieldType.select;
      default:
        return TableFieldType.string;
    }
  }
}
