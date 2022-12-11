import 'package:flutter/material.dart';

import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/ui_kit/helpers/dialog_helper.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/custom_form/fields/table/widget/filter_widget.dart';
import 'package:chef/screens/custom_form/fields/table/widget/table_renderer_helpers.dart';
import 'package:chef/ui_kit/widgets/exto_text_dialog.dart';
import 'package:chef/constants/strings.dart';

enum SortOrder {
  asc,
  desc,
}

class ExtoTable extends StatefulWidget {
  const ExtoTable({
    required FieldProperties properties,
    required FieldOnChange onChange,
    required Map<dynamic, dynamic> fields,
    Key? key,
  })  : _properties = properties,
        _onChange = onChange,
        _fields = fields,
        super(key: key);
  final FieldProperties _properties;
  final Map<dynamic, dynamic> _fields;
  final FieldOnChange _onChange;

  @override
  _ExtoTableState createState() => _ExtoTableState();
}

class _ExtoTableState extends State<ExtoTable> {
  final List<TextEditingController> _textController = [];

  final _fieldInputDataList = <Map<String, dynamic>>[];
  final _existingFieldInputDataList = <Map<String, dynamic>>[];
  var _filteredInputDataList = <Map<String, dynamic>>[];
  final _searchedInputDataList = <Map<String, dynamic>>[];
  final filterList = <String, Map<List<FilterObject>, FilterCombination>>{};
  final sortOption = <String, SortOrder>{};
  final searchController = TextEditingController();
  final searchTextController = TextController();
  final _headerColumns = <DataColumn>[];
  final _rows = <DataRow>[];
  final _rowStatus = <bool>[];
  final _selectedIndexes = <int>[];
  var _isInFilterMode = false;
  var _isInSearchMode = false;
  int _rowsCount = 0;
  static const _buttonSize = 40.0;
  static const _spacer = SizedBox(height: 8);
  final _rowRecordTable = [];
  bool yesCheckBox = false;
  bool noCheckBox = false;
  final dropdownItems = <String>[];
  Map<dynamic, dynamic> payLoadSubTable = {};
  Map<dynamic, dynamic> rowWithPayLoad = {};
  final _requestedRowsToDelete = <int>[];
  final List<Map<dynamic, dynamic>> payLoadMapSubTable = [];
  final List<Map<dynamic, dynamic>> _rowWithDeletePayList = [];
  bool _displayDeleteOption = false;

  var tableDataDetails = {};
  var tableDataWithRecordsAndDeleteInfo = {};

  @override
  void dispose() {
    for (final controller in _textController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dropdownItems.add(Strings.yesString.toLowerCase());
    dropdownItems.add(Strings.noString.toLowerCase());
  }

  @override
  void didChangeDependencies() {
    widget._fields.forEach((key, value) {
      _createRowsForExistingData(value, key);
    });
    super.didChangeDependencies();
  }

  void _createRowsForExistingData(
    Map tableDetails,
    String tableKeyName,
  ) {
    if (tableDetails.isNotEmpty) {
      tableDetails.forEach((key, value) {
        Map<dynamic, dynamic> existingData = value;
        existingData.forEach((tableKey, tableValues) {
          if (tableKey == 'rows') {
            List tableEntries = tableValues;
            if (tableEntries.isEmpty) {
              updateFieldWithEmpty(tableKeyName);
            }
            for (var i = 0; i < tableEntries.length; i++) {
              addNewRow(
                fieldId: tableDetails.keys.last,
                tableInfo: tableEntries[i],
              );
            }
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildTableHeader();
    return SafeArea(
      child: Column(
        children: [
          _buildTableActionButtons(),
          _buildTableData(),
        ],
      ),
    );
  }

  void _buildTableHeader() {
    final cols = widget._properties.columns;
    final fields = widget._fields;
    final appTheme = AppTheme.of(context).theme;
    _headerColumns.clear();
    for (var index = 0; index < cols.length; index++) {
      final column = cols[index];
      _headerColumns.add(
        DataColumn(
          label: Row(
            children: [
              ExtoText(column.label),
              const SizedBox(width: 8),
              ExtoButton.icon(
                icon: Icons.sort_by_alpha_outlined,
                onTap: () {
                  var val = sortOption[fields[index].properties!.id];
                  val ??= SortOrder.asc;
                  sortOption[fields[index].properties!.id] =
                      val == SortOrder.asc ? SortOrder.desc : SortOrder.asc;
                  _sort(val, fields[index].properties!.id);
                },
              ),
              ExtoButton.icon(
                icon: Icons.filter_alt_sharp,
                onTap: () async {
                  _showFilterDialog(
                    appTheme: appTheme,
                    columnKey: fields[index].properties!.id,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  void _search(String phrase) {
    if (phrase.isNotEmpty) {
      _isInSearchMode = true;
    } else {
      _isInSearchMode = false;
    }
    final a = _fieldInputDataList.where((element) {
      var isFound = false;
      for (var i = 1; i <= element.keys.length - 1 && !isFound; i++) {
        element.values.toList().forEach((secondElement) {
          if (secondElement.runtimeType
              .toString()
              .contains('_InternalLinkedHashMap<String, dynamic>')) {
            if (isFound == false) {
              for (var i in secondElement.values) {
                isFound =
                    i.toString().toLowerCase().contains(phrase.toString());
                if (isFound) break;
              }
            }
          }
        });
      }
      return isFound;
    });

    _searchedInputDataList.clear();
    _searchedInputDataList.addAll(a.toList());

    setState(() {});
  }

  void _sort(SortOrder order, String columnKey) {
    if (filterList.isEmpty) {
      if (_isInSearchMode) {
        _searchedInputDataList.sort((a, b) {
          final first = a[columnKey] ?? '';
          final second = b[columnKey] ?? '';
          return first.compareTo(second);
        });
        if (order == SortOrder.desc) {
          final apfel = [];
          apfel.addAll(_searchedInputDataList);
          _searchedInputDataList.clear();
          _searchedInputDataList.addAll(List.from(apfel.reversed));
        }
      } else {
        _fieldInputDataList.sort((a, b) {
          final first = a[columnKey] ?? '';
          final second = b[columnKey] ?? '';
          return first.compareTo(second);
        });
        if (order == SortOrder.desc) {
          final apfel = [];
          apfel.addAll(_fieldInputDataList);
          _fieldInputDataList.clear();
          _fieldInputDataList.addAll(List.from(apfel.reversed));
        }
      }
    } else {
      if (_isInSearchMode) {
        _searchedInputDataList.sort((a, b) {
          final first = a[columnKey] ?? '';
          final second = b[columnKey] ?? '';
          return first.compareTo(second);
        });
        if (order == SortOrder.desc) {
          final apfel = [];
          apfel.addAll(_searchedInputDataList);
          _searchedInputDataList.clear();
          _searchedInputDataList.addAll(List.from(apfel.reversed));
        }
      } else {
        _filteredInputDataList.sort((a, b) {
          final first = a[columnKey] ?? '';
          final second = b[columnKey] ?? '';
          return first.compareTo(second);
        });
        if (order == SortOrder.desc) {
          final apfel = [];
          apfel.addAll(_filteredInputDataList);
          _filteredInputDataList.clear();
          _filteredInputDataList.addAll(List.from(apfel.reversed));
        }
      }
    }
    setState(() {});
  }

  Widget _buildTableActionButtons() {
    return Row(
      children: [
        _buildSizedContainer(
          FittedBox(
            child: ElevatedButton(
              child: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  addNewRow(newRow: true);
                });
              },
            ),
          ),
        ),
        _spacer,
        _displayDeleteOption
            ? _buildSizedContainer(
                FittedBox(
                  child: ElevatedButton(
                    child: const Icon(Icons.delete),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      _deleteTableRecord();
                    },
                  ),
                ),
              )
            : const SizedBox(),
        _spacer,
        _buildSizedContainer(
          FittedBox(
            child: ElevatedButton(
              child: const Icon(Icons.search),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () {},
            ),
          ),
        ),
        _spacer,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: ExtoTextInput(
              controller: searchTextController,
              height: 25,
              inputBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              onChanged: (value) {
                _search(value);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTableData() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
        columns: _headerColumns,
        rows: _buildRows(),
      ),
    );
  }

  List<DataRow> _buildRows() {
    return List<DataRow>.generate(
      _isInFilterMode
          ? _isInSearchMode
              ? _searchedInputDataList.length
              : _filteredInputDataList.length
          : _isInSearchMode
              ? _searchedInputDataList.length
              : _rows.length,
      (index) {
        return _getRow(
          index,
          fieldId:
              _isInSearchMode ? _searchedInputDataList[index].keys.first : null,
        );
      },
    );
  }

  DataRow _getRow(
    int index, {
    String? fieldValue,
    Map<dynamic, dynamic>? tableInfo,
    String? fieldId,
    bool newRow = false,
  }) {
    _rowRecordTable.clear();

    return DataRow(
      color: _buildRowColor(context, index),
      cells: _buildCellList(
        index,
        rowValue: fieldValue,
        tableInfo: tableInfo,
        fieldExistingId: fieldId,
        newRow: newRow,
      ),
      selected: _rowStatus.isEmpty ? _rowStatus.isNotEmpty : _rowStatus[index],
      onSelectChanged: (bool? value) {
        if (value != null) {
          if (value) {
            _selectedIndexes.add(index);
            _requestedRowsToDelete.add(index);
          } else {
            _selectedIndexes.removeWhere((element) => element == index);
            _requestedRowsToDelete.removeWhere((element) => element == index);
          }
          if (_selectedIndexes.isNotEmpty) {
            _displayDeleteOption = true;
          } else {
            _displayDeleteOption = false;
          }
          setState(() {
            _rowStatus[index] = value;
          });
        }
      },
    );
  }

  MaterialStateProperty<Color?> _buildRowColor(
    BuildContext context,
    int index,
  ) {
    final appTheme = AppTheme.of(context).theme;
    return MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return appTheme.colors.primaryBackground.withOpacity(0.08);
      }
      if (index.isEven) {
        return appTheme.colors.primaryBackground.withOpacity(0.08);
      }
      return null;
    });
  }

  List<DataCell> _buildCellList(
    int rowIndex, {
    String? rowValue,
    Map<dynamic, dynamic>? tableInfo,
    String? fieldExistingId,
    bool newRow = false,
  }) {
    return List<DataCell>.generate(
      _headerColumns.length,
      (index) {
        final String? fieldId;
        fieldId = widget._properties.columns[index].id;

        var fieldValue = _isInFilterMode
            ? _isInSearchMode
                ? _searchedInputDataList[rowIndex][fieldId]
                : _filteredInputDataList[rowIndex][fieldId]
            : _isInSearchMode
                ? _searchedInputDataList[rowIndex][fieldId]
                : _fieldInputDataList.isNotEmpty &&
                        _fieldInputDataList[rowIndex][fieldId] != null
                    ? _fieldInputDataList[rowIndex][fieldId]
                    : null;

        var _fieldData = '';

        if (fieldValue == null &&
            _existingFieldInputDataList.isNotEmpty &&
            rowIndex < _existingFieldInputDataList.length) {
          var existingTableDataParse = _existingFieldInputDataList[rowIndex];
          existingTableDataParse.forEach((key, value) {
            if (value != null && value != 'index') {
              if (value is Map) {
                tableInfo = value;
                _fieldData = getFieldValue(
                  tableInfo,
                  widget._properties.columns[index].name,
                  rowIndex,
                );
                _fieldInputDataList[rowIndex][fieldId!] = _fieldData;
                updateRecordWithDynamic(
                  fieldId,
                  rowIndex,
                  widget._properties.columns[index].name,
                  tableInfo: tableInfo,
                );
                updateFieldChanges();
              } else {
                _fieldData = value;
              }
            }
          });
        }
        if (_isInSearchMode) {
          var searchedInputDataParse = _searchedInputDataList[rowIndex];

          searchedInputDataParse.forEach((key, value) {
            if (value != null && value != 'index') {
              if (value is Map) {
                tableInfo = value;
                _fieldData = getFieldValue(
                  tableInfo,
                  widget._properties.columns[index].name,
                  rowIndex,
                );
              }
            }
          });
        }

        return widget._properties.columns[index].name != 'recordNumber'
            ? _buildDataList(
                index: index,
                value: fieldValue != null ? fieldValue.toString() : _fieldData,
                fieldId: fieldId,
                rowIndex: rowIndex,
                type: widget._properties.columns[index].type,
                columnName: widget._properties.columns[index].name,
                newRow: newRow,
                tableInfo: tableInfo,
              )
            : displayRecordNumber(
                fieldValue != null ? fieldValue.toString() : _fieldData,
              );
      },
    );
  }

  DataCell displayRecordNumber(String fieldData) {
    return DataCell(Text(fieldData));
  }

  String getFieldValue(
    Map<dynamic, dynamic>? tableInfo,
    String columnName,
    int rowIndex,
  ) {
    if (tableInfo != null) {
      if (tableInfo[columnName] == null) {
        return '';
      }
      return tableInfo[columnName].toString();
    } else {
      return '';
    }
  }

  DataCell _buildDataList({
    required int index,
    required dynamic value,
    required String fieldId,
    required int rowIndex,
    required String type,
    required String columnName,
    bool newRow = false,
    Map<dynamic, dynamic>? tableInfo,
  }) {
    final _showEditIcon = showEdit(type);

    final fieldType = TableFieldRendererHelpers.specifyFieldType(type);

    return DataCell(
      TableFieldRendererHelpers.specifyFieldType(type).name ==
              TableFieldType.checkbox.name
          ? getCheckBoxDisplay(
              fieldId,
              rowIndex,
              columnName,
              value,
              tableInfo,
              newRow: newRow,
            )
          : TableFieldRendererHelpers.specifyFieldType(type).name ==
                  TableFieldType.select.name
              ? getDropDown(
                  fieldId,
                  rowIndex,
                  columnName,
                  value,
                  tableInfo,
                )
              : Text(value),
      showEditIcon: _showEditIcon,
      placeholder: true,
      onTap: () async {
        switch (fieldType) {
          case TableFieldType.string:
            editText(
              value,
              fieldId,
              rowIndex,
              index,
              columnName,
              tableInfo,
            );
            break;
          case TableFieldType.date:
            getDateDisplay(
              value,
              fieldId,
              rowIndex,
              index,
              columnName,
              tableInfo,
            );
            break;
          case TableFieldType.number:
            editNumber(
              value,
              fieldId,
              rowIndex,
              index,
              columnName,
              tableInfo,
            );
            break;
          default:
            const SizedBox();
        }
        setState(() {});
      },
    );
  }

  bool showEdit(String type) {
    if (type.isEmpty ||
        TableFieldRendererHelpers.specifyFieldType(type) ==
            TableFieldType.checkbox ||
        TableFieldRendererHelpers.specifyFieldType(type) ==
            TableFieldType.select) {
      return false;
    }
    return true;
  }

  Future<void> editText(
    String value,
    String fieldId,
    int rowIndex,
    int columnIndex,
    String columnName,
    Map<dynamic, dynamic>? tableInfo,
  ) async {
    final firstName =
        await showTextDialog(context, title: Strings.editTitle, value: value);

    setState(() {
      _fieldInputDataList[rowIndex][fieldId] = firstName;

      updateRecordWithDynamic(
        fieldId,
        rowIndex,
        columnName,
        tableInfo: tableInfo,
      );

      updateFieldChanges();
    });
  }

  void updateFieldChanges() {
    if (!payLoadMapSubTable.contains(rowWithPayLoad)) {
      rowWithPayLoad.forEach((key, value) {
        if (!payLoadMapSubTable.contains(value)) {
          payLoadMapSubTable.add(value);
        }
      });
    }

    tableDataWithRecordsAndDeleteInfo[Strings.recordsData] = payLoadMapSubTable;
    tableDataDetails[widget._properties.name] =
        tableDataWithRecordsAndDeleteInfo;

    widget._onChange.call(
      key: Strings.tableData,
      value: tableDataDetails,
    );
  }

  void updateFieldWithEmpty(String tableKeyName) {
    tableDataDetails[tableKeyName] = {Strings.recordsData: []};
    widget._onChange.call(
      key: Strings.tableData,
      value: tableDataDetails,
    );
  }

  void updateDeletePayLoadChanges() {
    tableDataWithRecordsAndDeleteInfo[Strings.deleteData] =
        _rowWithDeletePayList;

    tableDataDetails[widget._properties.name] =
        tableDataWithRecordsAndDeleteInfo;
    widget._onChange.call(
      key: Strings.tableData,
      value: tableDataDetails,
    );
  }

  void updateRecordWithDynamic(
    String fieldId,
    int rowIndex,
    String columnName, {
    Map<dynamic, dynamic>? tableInfo,
  }) {
    if (tableInfo != null) {
      tableInfo.forEach((key, value) {
        payLoadSubTable[key] = value;
      });
    }
    payLoadSubTable[columnName] = _fieldInputDataList[rowIndex][fieldId];
    rowWithPayLoad[rowIndex] = payLoadSubTable;
  }

  Future<void> editNumber(
    String value,
    String fieldId,
    int rowIndex,
    int columnIndex,
    String columnName,
    Map<dynamic, dynamic>? tableInfo,
  ) async {
    final dataUpdated = await showTextDialog(
      context,
      title: Strings.editTitle,
      value: value,
      inputType: InputType.digit,
    );

    setState(() {
      _fieldInputDataList[rowIndex][fieldId] = dataUpdated;
      updateRecordWithDynamic(
        fieldId,
        rowIndex,
        columnName,
        tableInfo: tableInfo,
      );
      updateFieldChanges();
    });
  }

  void updateCheckBoxData(
    String fieldId,
    int rowIndex,
    String columnName,
    String? fieldValue, {
    bool newRow = false,
  }) {
    if (!newRow) {
      if (fieldValue != null && fieldValue.isNotEmpty) {
        _fieldInputDataList[rowIndex][fieldId] = fieldValue;
      }
      if (_fieldInputDataList[rowIndex][fieldId] == Strings.yesFieldValue) {
        yesCheckBox = true;
      } else if (_fieldInputDataList[rowIndex][fieldId] ==
          Strings.noFieldValue) {
        yesCheckBox = false;
        noCheckBox = true;
      }

      if (yesCheckBox) {
        noCheckBox = false;
      } else {
        noCheckBox = true;
      }
    }
  }

  String getValidCheckBoxData(String dataFilter) {
    var num = dataFilter;
    num = num.replaceAll(RegExp(r'\p{P}', unicode: true), '');
    return num;
  }

  Widget getCheckBoxDisplay(
    String fieldId,
    int rowIndex,
    String columnName,
    String? fieldValue,
    Map<dynamic, dynamic>? tableInfo, {
    bool newRow = false,
  }) {
    var _yes = false;
    var _noData = false;

    fieldValue = getValidCheckBoxData(fieldValue!);
    if (!newRow && fieldValue.isNotEmpty) {
      _fieldInputDataList[rowIndex][fieldId] = fieldValue;
      if (_fieldInputDataList[rowIndex][fieldId] == Strings.yesFieldValue) {
        _yes = true;
      } else if (_fieldInputDataList[rowIndex][fieldId] ==
          Strings.noFieldValue) {
        _yes = false;
        _noData = true;
      }
      if (_yes) {
        _noData = false;
      } else {
        _noData = true;
      }
    }

    return Row(
      children: [
        const ExtoText(Strings.yesString),
        Checkbox(
          value: _yes,
          onChanged: (value) {
            setState(() {
              _yes = value!;
              _fieldInputDataList[rowIndex][fieldId] =
                  _yes ? Strings.yesFieldValue : '';
              updateCheckBoxSelection(
                rowIndex,
                fieldId,
                columnName,
                tableInfo,
              );
              if (_yes) {
                _noData = false;
              }
            });
          },
        ),
        const ExtoText(Strings.noString),
        Checkbox(
          value: _noData,
          onChanged: (value) {
            setState(() {
              _noData = value!;
              _fieldInputDataList[rowIndex][fieldId] =
                  _noData ? Strings.noFieldValue : '';
              updateCheckBoxSelection(
                rowIndex,
                fieldId,
                columnName,
                tableInfo,
              );
            });
          },
        ),
      ],
    );
  }

  void updateCheckBoxSelection(
    int rowIndex,
    String fieldId,
    String columnName,
    Map<dynamic, dynamic>? tableInfo,
  ) {
    updateRecordWithDynamic(
      fieldId,
      rowIndex,
      columnName,
      tableInfo: tableInfo,
    );
    updateFieldChanges();
  }

  void updateDropDownSelection(
    int rowIndex,
    String fieldId,
    String columnName,
    Map<dynamic, dynamic>? tableInfo,
  ) {
    updateRecordWithDynamic(
      fieldId,
      rowIndex,
      columnName,
    );
    updateFieldChanges();
  }

  Widget getDropDown(
    String fieldId,
    int rowIndex,
    String columnName,
    String? fieldValue,
    Map<dynamic, dynamic>? tableInfo,
  ) {
    var _selectedItem = '';

    fieldValue != null && fieldValue.isNotEmpty
        ? _selectedItem = fieldValue == Strings.yesString.toLowerCase()
            ? Strings.yesString.toLowerCase()
            : Strings.noString.toLowerCase()
        : _selectedItem;

    return ExtoDropdown(
      items: dropdownItems,
      onChange: ({
        required String key,
        required dynamic value,
      }) {
        _fieldInputDataList[rowIndex][fieldId] = value;
        updateDropDownSelection(
          rowIndex,
          fieldId,
          columnName,
          tableInfo,
        );
      },
      name: widget._properties.name,
      selectedItem:
          dropdownItems.isNotEmpty && dropdownItems.contains(_selectedItem)
              ? _selectedItem
              : '',
    );
  }

  Future<void> getDateDisplay(
    String value,
    String fieldId,
    int rowIndex,
    int columnIndex,
    String columnName,
    Map<dynamic, dynamic>? tableInfo,
  ) async {
    _selectDate(
      context,
      value,
      fieldId,
      rowIndex,
      columnIndex,
      columnName,
      tableInfo,
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    String value,
    String fieldId,
    int rowIndex,
    int columnIndex,
    String columnName,
    Map<dynamic, dynamic>? tableInfo,
  ) async {
    late DateTime _selectedDate;
    _selectedDate = DateTime.now();
    final _firstDate = DateTime(2000);
    final _lastDate = DateTime(2100);
    final pickedDate = await DialogHelper.showDate(
      context,
      _selectedDate,
      _firstDate,
      _lastDate,
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _fieldInputDataList[rowIndex][fieldId] =
            getValidDate(_selectedDate.toString());

        updateRecordWithDynamic(
          fieldId,
          rowIndex,
          columnName,
          tableInfo: tableInfo,
        );
        updateFieldChanges();
      });
    }
  }

  String getValidDate(String _date) {
    return _date.split(' ').first.trim();
  }

  void addNewRow({
    String? fieldValue,
    String? fieldId,
    Map<dynamic, dynamic>? tableInfo,
    bool newRow = false,
  }) {
    _rowStatus.add(false);
    payLoadSubTable = {};

    final index = _rowsCount;

    if (fieldId != null && tableInfo != null) {
      _existingFieldInputDataList.add({index.toString(): tableInfo});
      _fieldInputDataList.add({index.toString(): tableInfo});
    } else {
      _fieldInputDataList.add({UniqueKey().toString(): 'index'});
    }
    _rows.add(
      _getRow(
        index,
        fieldValue: fieldValue,
        tableInfo: tableInfo,
        fieldId: fieldId,
        newRow: newRow,
      ),
    );
    _rowsCount++;
  }

  void _deleteTableRecord() {
    var isFound = true;
    if (_existingFieldInputDataList.isNotEmpty &&
        _existingFieldInputDataList.length >= _requestedRowsToDelete.length) {
      for (var i = 0; i < _requestedRowsToDelete.length; i++) {
        try {
          _existingFieldInputDataList[_requestedRowsToDelete[i]]
              .forEach((k, v) {
            if (_requestedRowsToDelete[i].toString() == k.toString()) {
              _rowWithDeletePayList.add(
                v,
              );
            }
          });
        } catch (exception) {
          isFound = false;
          _requestedRowsToDelete.clear();
        }
      }
      if (isFound) {
        _requestedRowsToDelete.clear();
        for (var element in _existingFieldInputDataList) {
          rowWithPayLoad.addAll(element);
        }
        updateDeletePayLoadChanges();
      }
    } else {
      _requestedRowsToDelete.clear();
    }
    _processExistingAndEmptyDataToDelete();
  }

  void _processExistingAndEmptyDataToDelete() {
    _selectedIndexes.sort((a, b) => a.compareTo(b));
    for (var i = _selectedIndexes.length - 1; i >= 0; i--) {
      _rows.removeAt(_selectedIndexes[i]);
      _rowsCount = _rows.length;
      _rowStatus.removeAt(_selectedIndexes[i]);
      _fieldInputDataList.removeAt(_selectedIndexes[i]);
      _selectedIndexes.removeAt(i);
    }
    widget._onChange.call(
      key: widget._properties.tableId,
      value: _fieldInputDataList,
    );
    setState(() {
      _displayDeleteOption = false;
    });
  }

  Widget _buildSizedContainer(Widget child) {
    return SizedBox(
      width: _buttonSize,
      child: child,
    );
  }

  Future<void> _showFilterDialog({
    required IAppThemeData appTheme,
    required String columnKey,
  }) async {
    DialogHelper.show(
      context: context,
      title: Strings.filerText,
      body: FitlerWidget(
        onApply: ({
          required FilterCombination combination,
          required List<FilterObject> filterObjects,
        }) {
          if (filterObjects.isEmpty) {
            filterList.remove(columnKey);
            _isInFilterMode = false;
            setState(() {});
          } else {
            filterList[columnKey] = {filterObjects: combination};
          }
          for (var key in filterList.keys) {
            final element = filterList[key];
            _filterInputData(
              combination: element![element.keys.first]!,
              filterObjects: element.keys.first,
              columnKey: key,
            );
          }
        },
      ),
      isDismissible: false,
      maxHeight: 600,
    );
  }

  void _filterInputData({
    required FilterCombination combination,
    required List<FilterObject> filterObjects,
    required String columnKey,
  }) {
    if (filterList.isNotEmpty) {
      if (!_isInFilterMode) {
        _filteredInputDataList.clear();
        _filteredInputDataList = [..._fieldInputDataList];
      }
      var outputList = <Map<String, dynamic>>[];
      final firstList = doFiltering(
        listToBeFiltered: [..._filteredInputDataList],
        filterObj: filterObjects[0],
        key: columnKey,
      );
      outputList.addAll(firstList);
      if (filterObjects.length > 1) {
        var secondList = <Map<String, dynamic>>[];
        if (combination == FilterCombination.or) {
          secondList = [
            ...doFiltering(
              listToBeFiltered: [..._filteredInputDataList],
              filterObj: filterObjects[1],
              key: columnKey,
            )
          ];
        } else {
          secondList = [
            ...doFiltering(
              listToBeFiltered: [...firstList],
              filterObj: filterObjects[1],
              key: columnKey,
            )
          ];
        }
        combineList(outputList, secondList);
      }
      _filteredInputDataList = [...outputList];
      setState(() {
        _isInFilterMode = true;
      });
    } else {
      setState(() {
        _isInFilterMode = false;
      });
    }
  }

  void combineList(
    List<Map<String, dynamic>> mainList,
    List<Map<String, dynamic>> listToAdd,
  ) {
    for (var item in listToAdd) {
      final isFound = mainList.any(
        (element) => item.keys.first == element.keys.first,
      );
      if (!isFound) mainList.add(item);
    }
  }

  List<Map<String, dynamic>> doFiltering({
    required List<Map<String, dynamic>> listToBeFiltered,
    required FilterObject filterObj,
    required String key,
  }) {
    switch (filterObj.type) {
      case FilterTypes.contains:
        return [
          ...listToBeFiltered
              .where(
                (element) => element[key].toString().contains(filterObj.value),
              )
              .toList()
        ];
      case FilterTypes.notContains:
        return [
          ...listToBeFiltered
              .where(
                (element) => !element[key].toString().contains(filterObj.value),
              )
              .toList()
        ];
      case FilterTypes.endsWith:
        return [
          ...listToBeFiltered
              .where(
                (element) => element[key].toString().endsWith(filterObj.value),
              )
              .toList()
        ];
      case FilterTypes.equal:
        return [
          ...listToBeFiltered
              .where((element) => element[key].toString() == filterObj.value)
              .toList()
        ];
      case FilterTypes.notEqual:
        return [
          ...listToBeFiltered
              .where((element) => element[key].toString() != filterObj.value)
              .toList()
        ];
      case FilterTypes.startsWith:
        return [
          ...listToBeFiltered
              .where(
                (element) =>
                    element[key].toString().startsWith(filterObj.value),
              )
              .toList()
        ];
      default:
        return [];
    }
  }
}
