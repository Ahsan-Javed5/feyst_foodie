import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base_view.dart';
import 'package:chef/constants/strings.dart';
import 'package:chef/models/models.dart';
import 'package:chef/screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_m.dart';
import 'package:chef/screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_vm.dart';
import 'package:chef/services/services.dart';
import 'package:chef/setup.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/custom_forms/comment.dart';

class CustomFieldSideBar extends BaseView<CustomFieldSideBarViewModel> {
  CustomFieldSideBar({
    required this.moduleName,
    this.recordNumber,
    this.recordRefId,
    this.isInEditMode = false,
    Key? key,
  }) : super(key: key);

  final String moduleName;
  final String? recordNumber;
  final String? recordRefId;
  final bool isInEditMode;

  static const _smallPadding = 4.0;
  static const _padding = 8.0;
  static const _extraPadding = 10.0;
  static const _data = 'data';
  static const _stepInstances = 'stepInstances';
  static const _ballInCourt = 'ballInCourt';

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final appTheme = AppTheme.of(context).theme;
    final screenWidth = screenSizeData.size.width;
    if (!isInEditMode) {
      viewModel.loadNewRecordAttachedList(context);
    } else {
      viewModel.loadAttachmentList(
        context: context,
        moduleName: moduleName,
        linkedID: recordNumber!,
      );
    }
    return BlocBuilder<CustomFieldSideBarViewModel, CustomFieldSideBarState>(
      bloc: viewModel,
      builder: (_, state) {
        return DefaultTabController(
          length: 2,
          child: SizedBox(
            width: screenWidth * 0.80,
            child: Scaffold(
              backgroundColor: appTheme.colors.divider,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: appTheme.colors.focusedBorder,
                  padding: const EdgeInsets.all(_smallPadding),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: appTheme.colors.secondaryBackground,
                    tabs: const [
                      Tab(text: Strings.widgets),
                      Tab(text: Strings.wfComment),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(_padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(_padding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const ExtoText(Strings.generalAttachments),
                                    IconButton(
                                      onPressed: () {
                                        viewModel.uploadAttachment(
                                          context: context,
                                          moduleName: moduleName,
                                          linkedId: recordNumber,
                                          linkedRefId: recordRefId,
                                          isInEditMode: isInEditMode,
                                        );
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: _createAttachments(
                                          context,
                                          state.attachmentList,
                                        ),
                                      ),
                                    ),
                                    if (state is Loading) const ExtoLoading(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(_padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: _padding),
                                child: ExtoText(Strings.responsiblePerson),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: _createResponsibles(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(_extraPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              children: _createComments(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Comment> _getCommentList() {
    final renderer = locateService<IRendererService>();
    final commentList = <Map<String, dynamic>>[];
    final comments = <Comment>[];
    if (renderer.fieldInputData[_data] != null &&
        renderer.fieldInputData[_data][_stepInstances] != null) {
      commentList.addAll(renderer.fieldInputData[_data][_stepInstances]);
      for (var item in commentList) {
        comments.add(
          Comment.fromJson(item),
        );
      }
    }
    return comments;
  }

  List<CommentTile> _createComments() {
    final list = <CommentTile>[];
    final commentList = _getCommentList();
    for (var i = 0; i < commentList.length; i++) {
      final comment = commentList[i];
      list.add(
        CommentTile(
          responsibleName: comment.userId,
          dateTime: comment.updatedDate,
          step: comment.stepName,
          description: comment.comment,
          status: comment.status,
        ),
      );
    }
    return list;
  }

  List<Widget> _createAttachments(
    BuildContext context,
    List<Attachment> attachList,
  ) {
    final list = <Widget>[];
    for (var item in attachList) {
      final fileSize =
          FileHelper.getFileSizeString(bytes: item.size, decimals: 2);
      list.add(
        GestureDetector(
          onTap: () {
            viewModel.downloadAttachment(context, item.id);
          },
          child: AttachmentTile(
            attachment: item,
            fileSize: fileSize,
          ),
        ),
      );
    }
    return list;
  }

  List<String> _getResponsibleList() {
    final renderer = locateService<IRendererService>();
    final responsibleList = <String>[];
    if (renderer.fieldInputData[_data] != null &&
        renderer.fieldInputData[_data][_ballInCourt] != null) {
      responsibleList.addAll(renderer.fieldInputData[_data][_ballInCourt]);
    }
    return responsibleList;
  }

  List<ResponsibleTile> _createResponsibles() {
    final list = <ResponsibleTile>[];
    final responsibleList = _getResponsibleList();
    for (var i = 0; i < responsibleList.length; i++) {
      list.add(
        ResponsibleTile(
          title: responsibleList[i],
        ),
      );
    }
    return list;
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    required String responsibleName,
    required String dateTime,
    required String step,
    required String description,
    required String status,
    Key? key,
  })  : _responsibleName = responsibleName,
        _dateTime = dateTime,
        _step = step,
        _description = description,
        _status = status,
        super(key: key);

  final String _responsibleName;
  final String _dateTime;
  final String _step;
  final String _description;
  final String _status;

  static const _smallPadding = 4.0;
  static const _padding = 8.0;
  static const _extraPadding = 10.0;
  static const _borderRadius = 8.0;
  static const _smallBorderRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: _smallPadding),
      child: Padding(
        padding: const EdgeInsets.only(left: _padding, bottom: _padding),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(),
              title: ExtoText(_responsibleName),
              subtitle: ExtoText(_dateTime),
              leading: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(_smallBorderRadius),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(_padding),
                  child: ExtoText('M'),
                ),
              ),
              trailing: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: _smallPadding,
                    horizontal: _extraPadding,
                  ),
                  child: ExtoText(_step),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: _smallPadding),
                    child: ExtoText(_description),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadius),
                      bottomLeft: Radius.circular(_borderRadius),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: _smallPadding,
                      horizontal: _extraPadding,
                    ),
                    child: ExtoText(
                      _status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ResponsibleTile extends StatelessWidget {
  const ResponsibleTile({
    required String title,
    String? subTitle,
    Key? key,
  })  : _title = title,
        _subTitle = subTitle,
        super(key: key);

  final String _title;
  final String? _subTitle;
  static const _smallPadding = 2.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: _smallPadding),
      child: ListTile(
        title: ExtoText(_title),
        subtitle: _subTitle != null ? ExtoText(_subTitle!) : null,
      ),
    );
  }
}

class AttachmentTile extends StatelessWidget {
  const AttachmentTile({
    required Attachment attachment,
    required String fileSize,
    Key? key,
  })  : _attachment = attachment,
        _fileSize = fileSize,
        super(key: key);

  final Attachment _attachment;
  final String _fileSize;
  static const _smallPadding = 2.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: _smallPadding),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        leading: const Icon(CupertinoIcons.doc),
        title: ExtoText(_attachment.name),
        subtitle: ExtoText(
          _fileSize,
          typography: TypographyFamily.label4,
        ),
        trailing: ExtoText(
          _attachment.versions.isEmpty
              ? ''
              : _attachment.versions[0].name.split('_')[0],
          typography: TypographyFamily.caption4,
        ),
      ),
    );
  }
}
