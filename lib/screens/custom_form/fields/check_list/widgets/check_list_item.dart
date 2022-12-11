import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/enum_helper.dart';
import 'package:chef/models/models.dart' as modelchecklist;
import 'package:chef/models/check_list.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/custom_form/fields/check_list/widgets/inner_checklist_item.dart';
import 'package:chef/screens/custom_form/widgets/exto_field_option.dart';

enum ItemUiType {
  radio,
  text,
}

enum MandatoryType {
  always,
  never,
  whenValueIs,
}

typedef ItemAttachmentOnTap = Function(String id);

@injectable
class CheckListItem extends StatefulWidget {
  const CheckListItem({
    required String title,
    required String id,
    required FieldOnChange onChange,
    bool isInnerItem = false,
    List<Item>? items,
    String? subtitle,
    String? uiType,
    this.selectedIndex,
    List<Option>? options,
    List<ContextMenuAction>? actions,
    this.innerItem,
    this.parentItem,
    ItemAttachmentOnTap? itemAttachmentOnTap,
    Key? key,
  })  : _title = title,
        _id = id,
        _onChange = onChange,
        _subtitle = subtitle,
        _uiType = uiType,
        _options = options,
        _actions = actions,
        _items = items,
        _isInnerItem = isInnerItem,
        _itemAttachmentOnTap = itemAttachmentOnTap,
        super(key: key);

  final String _title;
  final String _id;
  final String? _subtitle;
  final String? _uiType;
  final List<Option>? _options;
  final List<ContextMenuAction>? _actions;
  final List<Item>? _items;
  final bool _isInnerItem;
  final FieldOnChange _onChange;
  final int? selectedIndex;
  final Item? innerItem;
  final modelchecklist.CheckListItem? parentItem;
  final ItemAttachmentOnTap? _itemAttachmentOnTap;

  @override
  State<CheckListItem> createState() => CheckListItemState();
}

class CheckListItemState extends State<CheckListItem> {
  static const _titleMaxLine = 1;
  static const _attachmentPadding = 8.0;
  static const _margin = 8.0;
  static const _emptyValue = '';
  static const _subtitleBottomMargin = 8.0;
  static const _cardBodyPadding =
      EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 8);
  static const _spacer = SizedBox(height: _subtitleBottomMargin);

  var _answerChangeLog = _emptyValue;
  var _changeLogIconVisibility = false;

  final _user = '';
  final _optionController = TextController();
  late int? _selectedIndex;
  late Item? _innerItem;
  late String? _selectedValue;
  late String? _displayDefaultSelectedValue;
  late modelchecklist.CheckListItem? _parentItem;

  @override
  void initState() {
    _parentItem = widget.parentItem;
    _innerItem = widget.innerItem;
    _selectedIndex = widget.selectedIndex;
    _selectedValue = widget.innerItem?.value?[0] ?? '';
    _displayDefaultSelectedValue = WarnWhenValueIs.notApplicable.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    const spacer = SizedBox(height: 30);
    return Padding(
      padding: _specifyPadding(),
      child: isItemEmpty() ? _buildItem(appTheme: appTheme) : spacer,
    );
  }

  bool isItemEmpty() =>
      widget._title.isNotEmpty ||
      (widget._subtitle != null && widget._subtitle!.isNotEmpty);

  EdgeInsetsGeometry _specifyPadding() => !widget._isInnerItem
      ? const EdgeInsets.symmetric(horizontal: _margin, vertical: _margin / 2)
      : const EdgeInsets.symmetric(vertical: _margin / 2);

  Widget _buildItem({
    required IAppThemeData appTheme,
  }) {
    final isParent = widget._items != null && widget._items!.isNotEmpty;
    return isParent
        ? _buildParent(
            appTheme: appTheme,
            isInnerItem: false,
          )
        : _buildBody(
            appTheme: appTheme,
            isInnerItem: !isParent,
          );
  }

  Widget _buildParent({
    required IAppThemeData appTheme,
    required bool isInnerItem,
  }) =>
      InkWell(
        onTap: () {
          if (!isInnerItem) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InnerCheckListItemScreen(
                  items: _buildInnerItems(),
                  title: widget._subtitle!,
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: appTheme.cardDecoration,
          child: ListTile(
            title: _buildBody(
              appTheme: appTheme,
              isInnerItem: isInnerItem,
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        ),
      );

  List<CheckListItem> _buildInnerItems() {
    final children = <CheckListItem>[];
    for (final item in widget._items!) {
      if (item.options != null && (item.options?.isNotEmpty)!) {
        children.add(
          CheckListItem(
            title: item.id ?? '',
            id: item.id ?? '',
            subtitle: item.description,
            options: item.options,
            uiType: item.uiType != null ? item.uiType!.name : UiType.text.name,
            actions: FieldRendererHelpers.specifyActions(item),
            isInnerItem: true,
            selectedIndex: _selectedIndex,
            onChange: widget._onChange,
            innerItem: item,
            itemAttachmentOnTap: widget._itemAttachmentOnTap,
          ),
        );
      }
    }
    return children;
  }

  Widget _buildBody({
    required IAppThemeData appTheme,
    required bool isInnerItem,
  }) {
    return Container(
      color: _specifyBackgroundColor(appTheme),
      child: Container(
        decoration: _specifyDecoration(
          appTheme: appTheme,
          isInnerItem: !isInnerItem,
        ),
        padding: _cardBodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget._title.isNotEmpty || widget._subtitle!.isNotEmpty)
              _buildTitle(
                appTheme: appTheme,
                isInnerItem: isInnerItem,
              ),
            if (widget._uiType != null)
              _buildOptions(
                appTheme: appTheme,
                isInnerItem: isInnerItem,
              ),
            const SizedBox(
              height: _attachmentPadding,
            ),
            if (isInnerItem)
              InkWell(
                onTap: () => widget._itemAttachmentOnTap
                    ?.call(widget.innerItem?.id ?? ''),
                child: const Icon(Icons.attach_file),
              )
          ],
        ),
      ),
    );
  }

  Color? _specifyBackgroundColor(IAppThemeData appTheme) =>
      !widget._isInnerItem ? null : appTheme.colors.divider.withOpacity(0.3);

  BoxDecoration? _specifyDecoration({
    required IAppThemeData appTheme,
    required bool isInnerItem,
  }) {
    return isInnerItem
        ? null
        : widget._isInnerItem
            ? null
            : appTheme.cardDecoration;
  }

  Widget _buildTitle({
    required IAppThemeData appTheme,
    required bool isInnerItem,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              isInnerItem && widget._title.isNotEmpty
                  ? widget._title + '.'
                  : widget._title,
              style: appTheme.typographies.interFontFamily.label4,
              maxLines: _titleMaxLine,
              overflow: TextOverflow.ellipsis,
            ),
            Flexible(
              flex: 10,
              child: Html(data: widget._subtitle ?? _emptyValue),
            ),
            const Spacer(),
            if (widget._actions != null && isInnerItem)
              ExtoContextMenu(actions: widget._actions!)
          ],
        ),
        _spacer,
      ],
    );
  }

  Widget _buildOptions({
    required IAppThemeData appTheme,
    required bool isInnerItem,
  }) {
    var itemsList = <ExtoFieldOption<String>>[];
    if (widget._uiType?.toUpperCase() ==
        EnumHelpers.humanize(ItemUiType.radio.name)) {
      if (widget._options != null) {
        itemsList = widget._options!
            .map(
              (option) => ExtoFieldOption<String>(
                optionData: FieldOptionModel(
                  id: (option.id)!,
                  label: option.label?.name.toUpperCase() ?? '',
                  value: option.value,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ExtoText(
                    option.label?.name.toUpperCase() ?? '',
                    style:
                        appTheme.typographies.interFontFamily.label2.copyWith(
                      color: option.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
            .toList(growable: false);
      }

      return Column(
        children: [
          _spacer,
          Container(
            color: widget.innerItem != null &&
                        widget.innerItem!.mandatory != null &&
                        widget.innerItem!.mandatory!.name.toUpperCase() ==
                            MandatoryType.always.name.toUpperCase() &&
                        _selectedValue != null &&
                        _selectedValue!.isEmpty ||
                    _selectedValue == null
                ? getMandatoryColor(appTheme)
                : null,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: ExtoRadioGroup<String>(
                    orientation: FieldOrientation.horizontal,
                    name: widget._id,
                    onChanged: (selectable) {
                      setState(() {
                        _changeLogIconVisibility = true;
                        _selectedValue = selectable;
                        _answerChangeLog =
                            '$_user filled at ${DateTime.now().toString()}';
                        _selectedIndex = itemsList.indexWhere(
                          (element) => element.optionData.value == selectable,
                        );
                        widget._onChange.call(
                          key: widget._id,
                          value: selectable,
                        );
                      });
                    },
                    initialValue: isInnerItem
                        ? (_innerItem?.value?[0] ?? getDefaultValue())
                        : _selectedIndex == null
                            ? _parentItem?.value?.keys.toList()[0]
                            : null,
                    validator: (value) => value == null || value.isEmpty
                        ? Strings.requiredField
                        : null,
                    items: itemsList,
                    controlAffinity: ControlAffinity.trailing,
                  ),
                ),
                Flexible(
                  child: Visibility(
                    visible: _changeLogIconVisibility,
                    child: ExtoTooltip(
                      message: _answerChangeLog,
                      child: ExtoHero.smallIcon(
                        icon: Icon(
                          Icons.info,
                          color: appTheme.colors.primaryBackground,
                        ),
                        backgroundColor: appTheme.colors.secondaryBackground,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _spacer,
        ],
      );
    } else if (widget._uiType!.toUpperCase() ==
        EnumHelpers.humanize(ItemUiType.text)) {
      return ExtoTextInput(
        controller: _optionController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget._onChange.call(
              key: widget._id,
              value: value,
            );
          }
        },
      );
    } else {
      return Container();
    }
  }

  Color getMandatoryColor(IAppThemeData appTheme) {
    _displayDefaultSelectedValue = '';
    return appTheme.colors.mandatoryItemBackground;
  }

  String getDefaultValue() {
    widget._onChange.call(
      key: widget._id,
      value: WarnWhenValueIs.notApplicable.name,
    );
    return _displayDefaultSelectedValue!;
  }
}
