import 'package:flutter/material.dart';

import 'package:chef/constants/constants.dart';
import 'package:chef/models/models.dart';
import 'package:chef/helpers/enum_helper.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';

class FitlerWidget extends StatefulWidget {
  const FitlerWidget({
    required void Function({
      required FilterCombination combination,
      required List<FilterObject> filterObjects,
    })
        onApply,
    FilterCombination? filterCombination,
    List<FilterObject>? filterObjects,
    Key? key,
  })  : _filterCombination = filterCombination,
        _filterObjects = filterObjects,
        _onApply = onApply,
        super(key: key);

  final FilterCombination? _filterCombination;
  final List<FilterObject>? _filterObjects;

  final void Function({
    required FilterCombination combination,
    required List<FilterObject> filterObjects,
  }) _onApply;

  @override
  _FitlerWidgetState createState() => _FitlerWidgetState();
}

class _FitlerWidgetState extends State<FitlerWidget> {
  late FilterCombination _selectedFilterCombination;
  var _firstFilter = FilterObject(
    type: FilterTypes.contains,
    value: '',
  );
  var _secondFilter = FilterObject(
    type: FilterTypes.contains,
    value: '',
  );
  late List<FilterObject> _filterObjects;

  @override
  void initState() {
    _filterObjects = widget._filterObjects ?? [_firstFilter];
    _selectedFilterCombination =
        widget._filterCombination ?? FilterCombination.and;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 200,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.only(bottom: 10),
                child: GeneralDropdownWithSearch(
                  name: '',
                  margin: 8.0,
                  items: filterCombinations
                      .map((e) => filterCombinationToString(e))
                      .toList(),
                  onChange: ({
                    required String key,
                    required dynamic value,
                  }) =>
                      _selectedFilterCombination =
                          specifyFilterCombination(value),
                ),
              ),
              ..._buildOneFilterRule(0),
              if (_filterObjects.length > 1) ..._buildOneFilterRule(1),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GeneralButton.button(
                      title: Strings.filterCancelButtonText,
                      styleType: ButtonStyleType.outline,
                      onTap: () => Navigator.maybePop(context),
                    ),
                    const Spacer(),
                    GeneralButton.button(
                      title: Strings.filterApplyButtonText,
                      styleType: ButtonStyleType.fill,
                      onTap: () {
                        final filtersList = <FilterObject>[];
                        if (_firstFilter.value.isNotEmpty) {
                          filtersList.add(_firstFilter);
                        }
                        if (_secondFilter.value.isNotEmpty) {
                          filtersList.add(_secondFilter);
                        }
                        widget._onApply.call(
                          combination: _selectedFilterCombination,
                          filterObjects: filtersList,
                        );
                        Navigator.maybePop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOneFilterRule(int index) {
    final _shouldRemove = _filterObjects.length > 1;
    final _buttonTitle = _shouldRemove
        ? Strings.filterRemoveRuleButtonText
        : Strings.filterAddRuleButtonText;
    late TextController _filterController;
    if (index == 0) {
      _filterController = TextController(text: _firstFilter.value);
    } else {
      _filterController = TextController(text: _secondFilter.value);
    }
    return [
      GeneralDropdownWithSearch(
        name: '',
        margin: 8.0,
        items:
            filterTypes.map((e) => EnumHelpers.humanize(e).toString()).toList(),
        onChange: ({
          required String key,
          required dynamic value,
        }) {
          switch (index) {
            case 0:
              _firstFilter =
                  _firstFilter.copyWith(type: specifyFilterType(value));
              break;
            case 1:
              _secondFilter =
                  _secondFilter.copyWith(type: specifyFilterType(value));
              break;
          }
        },
      ),
      GeneralTextInput(
        controller: _filterController,
        onChanged: (value) {
          _filterObjects.removeAt(index);
          switch (index) {
            case 0:
              _firstFilter = _firstFilter.copyWith(value: value);
              _filterObjects.insert(index, _firstFilter);
              break;
            case 1:
              _secondFilter = _secondFilter.copyWith(value: value);
              _filterObjects.insert(index, _secondFilter);
              break;
          }
        },
      ),
      GeneralButton.button(
        title: _buttonTitle,
        onTap: () {
          setState(() {
            if (_shouldRemove) {
              _filterObjects.removeAt(index);
            } else {
              if (index == 0) {
                _filterObjects.add(_firstFilter);
              } else {
                _filterObjects.add(_secondFilter);
              }
            }
          });
        },
        styleType: ButtonStyleType.plain,
      ),
      Visibility(
        visible: !(_filterObjects.length > 1),
        child: const GeneralDivider(),
      ),
    ];
  }
}
