import 'dart:io';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/sign_up/questionire/sign_up_questionire_screen_m.dart';
import 'package:chef/screens/sign_up/questionire/sign_up_questionire_screen_vm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import '../../../models/signup/sign_up_questionnaire_response_model.dart';
import '../widget/question_view.dart';
import '../widget/sign_up_questionnaire.dart';

class SignUpQuestionireScreen
    extends BaseView<SignUpQuestionnaireScreenViewModel> {
  SignUpQuestionireScreen(this.isProfileUpdate, {Key? key,})
      : super(key: key);
  final bool isProfileUpdate;
  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    final appTheme = AppTheme.of(context).theme;
    viewModel.isProfileUpdate = isProfileUpdate;
    return BlocBuilder<SignUpQuestionnaireScreenViewModel,
            SignUpQuestionnaireState>(
        bloc: viewModel..getQuestionnaireData(userId: '0'),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.colors.primaryBackground,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 18.0, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //       const SignUpLetsStartScreen()),
                      // );
                      viewModel.addModelsFromQuestions(
                          context: context,
                          completion: () {
                            viewModel.saveFoodie(
                                baseUrl: Api.baseURL,
                                context: context,
                                completion: () {
                                  if (!isProfileUpdate) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpLetsStartScreen()),
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                });
                          });
                    },
                    child: SvgPicture.asset(
                      Resources.getSignInRightArrow,
                    ),
                  ),
                ],
              ),
            ),
            body: state.when(
                loading: _loading,
                loaded: (signUpQuestionsModel) => displayLoaded(
                    context, state, appTheme, signUpQuestionsModel)),
          );
        });
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Future<File?> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      // User cancelled the selection
      return null;
    }
  }

  Widget displayLoaded(context, state, IAppThemeData appTheme,
      SignUpQuestionsModel signUpQuestionsModel) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///header image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.asset(
              Resources.getSignUpQuestionireBgPng,
              fit: BoxFit.fill,
            ),
          ),

          ///only height
          const SizedBox(
            height: 20,
          ),

          ///question answers
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
            ),
            child: Center(
                child: Container(
              alignment: Alignment.center,
              //  padding: const EdgeInsets.only(left: 29),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GeneralText(
                    Strings.questionireLabel,
                    textAlign: TextAlign.center,
                    style: appTheme.typographies.interFontFamily.headline4
                        .copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                  ),

                  ///question answers list
                  getQuestionWidgetsList(
                      signUpQuestionsModel, appTheme, context),

                  const SizedBox(
                    height: 30,
                  ),

                  ///profile picture section
                  InkWell(
                    onTap: () async {
                      File? selectedImage = await getImageFromGallery();
                      // selectedImage != null
                      //     ? () async {
                      viewModel.updateSelectedImage(selectedImage);
                      //viewModel.uploadImage(selectedImage, Api.baseURL);
                      viewModel.uploadFoodieImage(file: selectedImage, baseUrl: Api.baseURL);
                      // var mimeType = lookupMimeType(selectedImage!.path);
                      //  List<int> bytes = await selectedImage!.readAsBytes();
                      // String binaryString = bytes
                      //     .map((byte) => byte.toRadixString(2).padLeft(8, '0'))
                      //     .join();
                      // // developer
                      // //     .log("this is converted image + $binaryString");
                      // binaryString.isNotEmpty
                      //     ?
                      // // viewModel.savePicture(
                      // //         baseUrl: Api.baseURL,
                      // //         context: context,
                      // //         image: binaryString,
                      // //         path: selectedImage.path,
                      // //         bytes: bytes,
                      // //         mimeType: mimeType,
                      // //       )
                      // viewModel.upload(selectedImage, Api.baseURL)
                      // //viewModel.uploadImage(selectedImage, Api.baseURL)
                      // //viewModel.uploadImg(selectedImage, Api.baseURL)
                      //     : null;
                      viewModel.isImageSelected = true;
                      //   }
                      // : Toaster.infoToast(
                      //     context: context,
                      //     message: "Please select picture");
                    },
                    child: Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GeneralText(
                            Strings.labelProfilePicture,
                            textAlign: TextAlign.center,
                            style: appTheme
                                .typographies.interFontFamily.headline4
                                .copyWith(
                                    color: appTheme.colors.primaryBackground,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                          ),
                          ValueListenableBuilder<File?>(
                            valueListenable: viewModel.selectedImageNotifier,
                            builder: (BuildContext context, File? selectedImage,
                                Widget? child) {
                              if (selectedImage != null) {
                                return CircleAvatar(
                                  radius: 25,
                                  backgroundImage: FileImage(selectedImage),
                                );
                              } else {
                                return Image.asset(
                                  Resources.userProfileImageIcon,
                                  height: 47,
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget getQuestionWidgetsList(SignUpQuestionsModel model,
      IAppThemeData appTheme, BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: model.t?.length,
      itemBuilder: (ctx, index) {
        var item = model.t![index];
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: QuestionView(
            appTheme: appTheme,
            questionObj: item,
            answerIdsCuisineTaste: viewModel.answerIdsCuisineTaste,
            answerIdsPerfectAmbience: viewModel.answerIdPerfectAmbience,
            answerIdsUniqueFood: viewModel.answerIdsUniqueFoodie,
            answerIdsYourInterests: viewModel.answerIdInterest,
          ),
        );
      },
    );
  }

  List<Widget> getChipsWidgetsList(SignUpQuestionsModel viewModel,
      IAppThemeData appTheme, List<Answers>? answers, BuildContext context) {
    return List.generate(answers?.length ?? 0, (index) {
      var item = answers![index];
      return InkWell(
        onTap: () {
          var currentItemSelectedStatus = item.isSelected;
          // for (var element in answers) {
          //   if(element.id==item.id){
          //     item.isSelected = !currentItemSelectedStatus!;
          //   }else{
          //     element.isSelected=false;}
          // }
          item.isSelected = !currentItemSelectedStatus!;
          // setState(() {});
        },
        child: ChipsWidget(
          appTheme: appTheme,
          title: item.name ?? '',
          selected: item.isSelected ?? false,
        ),
      );
    });
  }
}

class SignUpQuestionnaire extends StatefulWidget {
  const SignUpQuestionnaire({Key? key, required this.signUpQuestionsModel})
      : super(key: key);

  final SignUpQuestionsModel signUpQuestionsModel;

  @override
  State<SignUpQuestionnaire> createState() => _SignUpQuestionnaireState();
}

class _SignUpQuestionnaireState extends State<SignUpQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///header image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.asset(
              Resources.getSignUpQuestionireBgPng,
              fit: BoxFit.fill,
            ),
          ),

          ///only height
          const SizedBox(
            height: 20,
          ),

          ///question answers
          Center(
              child: Container(
            alignment: Alignment.center,
            //  padding: const EdgeInsets.only(left: 29),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GeneralText(
                  Strings.questionireLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4
                      .copyWith(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w500),
                ),

                ///question answers list
                getQuestionWidgetsList(
                    widget.signUpQuestionsModel, appTheme, context),
                const SizedBox(
                  height: 30,
                ),

                ///profile picture section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GeneralText(
                        Strings.labelProfilePicture,
                        textAlign: TextAlign.center,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                                color: appTheme.colors.primaryBackground,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                      ),
                      Image.asset(
                        Resources.userProfilePicPng,
                        height: 47,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  List<Widget> getChipsWidgetsList(SignUpQuestionsModel viewModel,
      IAppThemeData appTheme, List<Answers>? answers, BuildContext context) {
    return List.generate(answers?.length ?? 0, (index) {
      var item = answers![index];
      return InkWell(
        onTap: () {
          var currentItemSelectedStatus = item.isSelected;
          // for (var element in answers) {
          //   if(element.id==item.id){
          //     item.isSelected = !currentItemSelectedStatus!;
          //   }else{
          //     element.isSelected=false;}
          // }
          item.isSelected = !currentItemSelectedStatus!;
          setState(() {});
        },
        child: ChipsWidget(
          appTheme: appTheme,
          title: item.name ?? '',
          selected: item.isSelected ?? false,
        ),
      );
    });
  }

  Widget getQuestionWidgetsList(SignUpQuestionsModel model,
      IAppThemeData appTheme, BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: model.t?.length,
      itemBuilder: (ctx, index) {
        var item = model.t![index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralText(
              item.name ?? '',
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfffbeccb),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children:
                  getChipsWidgetsList(model, appTheme, item.answers, context),
            ),
          ],
        );
      },
    );
  }
}

class ChipsWidget extends StatelessWidget {
  const ChipsWidget({
    Key? key,
    required this.appTheme,
    required this.title,
    this.selected = false,
    this.widthContainer = 140,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final String title;
  final bool selected;
  final double widthContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        width: widthContainer,
        child: GeneralText(
          title.capitalize(),
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: selected ? Colors.black : Colors.white,
              fontSize: 13.5,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appTheme.colors.textFieldBorderColor,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          color: selected
              ? appTheme.colors.textFieldBorderColor
              : Colors.transparent,
        ));
  }
}

// class ChipsWidget extends StatelessWidget {
//   const ChipsWidget({
//     Key? key,
//     required this.appTheme,
//     required this.title,
//     this.selected = false,
//     this.widthContainer = 160,
//   }) : super(key: key);
//
//   final IAppThemeData appTheme;
//   final String title;
//   final bool selected;
//   final double widthContainer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//         width: widthContainer,
//         child: GeneralText(
//           title.capitalize(),
//           textAlign: TextAlign.center,
//           style: appTheme.typographies.interFontFamily.headline6.copyWith(
//               color: selected ? Colors.black : Colors.white,
//               fontSize: 15,
//               fontWeight: selected ? FontWeight.bold : FontWeight.w500),
//         ),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: appTheme.colors.textFieldBorderColor,
//             width: 2.5,
//           ),
//           borderRadius: BorderRadius.circular(
//             30,
//           ),
//           color: selected
//               ? appTheme.colors.textFieldBorderColor
//               : Colors.transparent,
//         ));
//   }
// }
