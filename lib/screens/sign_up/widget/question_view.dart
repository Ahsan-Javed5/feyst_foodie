import '../../../../helpers/helpers.dart';
import 'dart:developer' as developer;

import '../../../models/signup/questionire_response.dart';
import '../../../models/signup/sign_up_questionnaire_response_model.dart';

class QuestionView extends StatefulWidget {
  QuestionView({
    Key? key,
    required this.appTheme,
    required this.questionObj,
    required this.answerIdsCuisineTaste,
    required this.answerIdsPerfectAmbience,
    required this.answerIdsUniqueFood,
    required this.answerIdsYourInterests,
  }) : super(key: key);

  final IAppThemeData appTheme;

  var questionObj;
  List<int> answerIdsUniqueFood;
  List<int> answerIdsPerfectAmbience;
  List<int> answerIdsCuisineTaste;
  List<int> answerIdsYourInterests;

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(
        //   height: 27,
        // ),
        GeneralText(
          widget.questionObj.name,
          maxLines: 2,
          textAlign: TextAlign.left,
          style: widget.appTheme.typographies.interFontFamily.headline6
              .copyWith(
                  color: const Color(0xfffbeccb),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        MultiChipView(
          answerIdsInterests: widget.answerIdsYourInterests,
          appTheme: widget.appTheme,
          answerList: widget.questionObj.answers,
          answerIdsUniqueFoodie: widget.answerIdsUniqueFood,
          answerIdPerfectAmbience: widget.answerIdsPerfectAmbience,
          answerIdsCuisineTaste: widget.answerIdsCuisineTaste,
        ),
      ],
    );
  }
}

// class  extends StatefulWidget {
//   const ({Key? key}) : super(key: key);
//
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class MultiChipView extends StatefulWidget {
  // const multiChipView({Key? key}) : super(key: key);

  MultiChipView({
    Key? key,
    required this.appTheme,
    required this.answerList,
    required this.answerIdsInterests,
    required this.answerIdsUniqueFoodie,
    required this.answerIdPerfectAmbience,
    required this.answerIdsCuisineTaste,
  }) : super(key: key);

  final IAppThemeData appTheme;
  List<Answers> answerList;
  List<int> answerIdsUniqueFoodie;
  List<int> answerIdPerfectAmbience;
  List<int> answerIdsCuisineTaste;
  List<int> answerIdsInterests;

  @override
  _MultiChipViewState createState() => _MultiChipViewState();
}

class _MultiChipViewState extends State<MultiChipView> {
  Map<String, bool> selectedData = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.5,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemCount: widget.answerList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                setState(() {
                  if (selectedData.isEmpty) {
                    selectedData[widget.answerList[index].name.toString()] =
                        true;
                  } else {
                    if (selectedData
                        .containsKey(widget.answerList[index].name)) {
                      if (selectedData[widget.answerList[index].name]!) {
                        selectedData[widget.answerList[index].name.toString()] =
                            false;
                      } else {
                        selectedData[widget.answerList[index].name.toString()] =
                            true;
                      }
                    } else {
                      selectedData[widget.answerList[index].name.toString()] =
                          true;
                    }
                  }

                  if(widget.answerList[index].questionId == 1) {
                  ///unique food answers list
                  widget.answerIdsUniqueFoodie
                      .contains(widget.answerList[index].id)
                  ? widget.answerIdsUniqueFoodie
                      .remove(widget.answerList[index].id)
                      : widget.answerIdsUniqueFoodie
                      .add((widget.answerList[index].id)!.toInt());
                  }
                  else if(widget.answerList[index].questionId == 2) {
                  ///perfect ambience answers list
                  widget.answerIdPerfectAmbience
                      .contains(widget.answerList[index].id)
                  ? widget.answerIdPerfectAmbience
                      .remove(widget.answerList[index].id)
                      : widget.answerIdPerfectAmbience
                      .add((widget.answerList[index].id)!.toInt());
                  }
                  else if(widget.answerList[index].questionId == 12) {
                  ///cuisine food answers list
                  widget.answerIdsCuisineTaste
                      .contains(widget.answerList[index].id)
                  ? widget.answerIdsCuisineTaste
                      .remove(widget.answerList[index].id)
                      : widget.answerIdsCuisineTaste
                      .add((widget.answerList[index].id)!.toInt());
                  }
                  ///interest answers list
                  else if(widget.answerList[index].questionId == 13) {
                    widget.answerIdsInterests
                        .contains(widget.answerList[index].id)
                        ? widget.answerIdsInterests
                        .remove(widget.answerList[index].id)
                        : widget.answerIdsInterests
                        .add((widget.answerList[index].id)!.toInt());
                  }
                  //  _selectedInterests.value.addAll(selectedData);
                });
              },
              child: SizedBox(
                  height: 50,
                  child: ChipsWidget(
                    appTheme: widget.appTheme,
                    title: widget.answerList[index].name.toString(),
                    selected: selectedData != null &&
                            selectedData.isNotEmpty &
                                selectedData
                                    .containsKey(widget.answerList[index].name)
                        ? selectedData[widget.answerList[index].name]!
                        : false,
                  )));
        },
      ),
    );
  }
}

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.appTheme,
    required this.textValueController,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final TextController textValueController;

  @override
  Widget build(BuildContext context) {
    return GeneralTextInput(
        height: 80,
        controller: textValueController,
        inputType: InputType.text,
        isMultiline: true,
        backgroundColor: appTheme.colors.textFieldFilledColor,
        inputBorder: appTheme.focusedBorder,
        valueStyle: const TextStyle(color: Colors.white),
        hint: 'Please enter description here',
        hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
        onChanged: (newValue) {});
  }
}

class SingleOption extends StatefulWidget {
  SingleOption({
    Key? key,
    required this.appTheme,
    required this.answerList,
    required this.answersIds,
    this.title = '',
    this.selected = false,
    this.widthContainer = 130,
  }) : super(key: key);
  final IAppThemeData appTheme;
  List<Answer> answerList;
  List<int> answersIds;

  final String title;
  final bool selected;
  final double widthContainer;
  @override
  _SingleOptionState createState() => _SingleOptionState();
}

class _SingleOptionState extends State<SingleOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        child: ListView.builder(
            itemCount: widget.answerList.length,
            physics:
                const NeverScrollableScrollPhysics(), // BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(bottom: 9),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      color: widget.answersIds
                              .contains(widget.answerList[index].id)
                          ? const Color(0xfffee4a4)
                          : Colors.white),
                  padding: const EdgeInsets.all(12),
                  child: TextButton(
                      child: Row(
                        children: [
                          // Image.asset(
                          //   widget.answersIds
                          //           .contains(widget.answerList[index].id)
                          //       ? Resources.checkPNG
                          //       : Resources.ringPNG,
                          //   height: 22,
                          // ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: GeneralText(
                              widget.answerList[index].name,
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              style: widget.appTheme.typographies
                                  .interFontFamily.headline6
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      onPressed: () async {
                        setState(() {
                          widget.answersIds
                                  .contains(widget.answerList[index].id)
                              ? widget.answersIds
                                  .remove(widget.answerList[index].id)
                              : (widget.answersIds..clear())
                                  .add(widget.answerList[index].id);
                        });
                      }),
                ),
              );
            }));
  }
}
