import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/sign_up/sign_up_screen_vm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../models/signup/profession_response.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_gender.dart';
import '../sign_in/sign_in_screen_v.dart';
import 'get_started_screen_vm.dart';
import 'package:chef/screens/sign_up/sign_up_screen_m.dart';

import 'dart:developer' as developer;

class SignUpScreen extends BaseView<SignUpScreenViewModel> {
  SignUpScreen({Key? key}) : super(key: key);

  final baseURLs = [
    // Api.prodURL,
    Api.baseURL,
    Api.devBaseURL,
  ];

  late List<DropdownMenuItem<String>> items = [];
  final TextController _nameController = TextController();
  final TextController _mobileNumberController = TextController();
  final TextController _ageController = TextController(text: "0");
  final TextController _genderController = TextController(text: 'male');

  final dropdownItems = <String>[];
  Gender selectedGender = Gender.male;
  Map<dynamic, dynamic> dropdownDetails = {};
  final genderList = <String>[];
  int _professionID = 0;

  void loadProfessionList(
    List<ProfessionData> professionList,
  ) {
    genderList.add('Male');
    genderList.add('Female');
    for (int i = 0; i < professionList.length; i++) {
      developer.log(' ProfessionList id is ' + '${professionList[i].id}');
      dropdownDetails[professionList[i].name] = professionList[i].id;

      dropdownItems.add(professionList[i].name);
    }

    _professionID = dropdownDetails[dropdownItems[0]];
  }

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final appTheme = AppTheme.of(context).theme;

    viewModel.loadProfessions(baseUrl: baseURLs[0], context: context);
    return BlocBuilder<SignUpScreenViewModel, SignUpScreenState>(
        bloc: viewModel,
        builder: (_, state) => state.when(
            initialized:
                (fullName, mobileNumber, age, gender, profession, isBusy) =>
                    _initialized(),
            loading: _loading,
            loaded: (professionList) => _displayLoadedData(
                state: state,
                appTheme: appTheme,
                context: context,
                professionList: professionList,
                screenSizeData: screenSizeData)));
  }

  Widget _initialized() {
    return Container();
  }

  Widget _loading() => const GeneralLoading();

  Widget _displayLoadedData({
    state,
    appTheme,
    required BuildContext context,
    required List<ProfessionData> professionList,
    required ScreenSizeData screenSizeData,
  }) {
    final size = screenSizeData.size;
    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      bottomNavigationBar: displayAlreadySignIn(appTheme, context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  screenSizeData.screenType == ScreenType.small
                      ? _buildMobileView(
                          context: context,
                          state: state,
                          appTheme: appTheme,
                          size: size,
                          professionList: professionList,
                        )
                      : _buildTabletView(
                          context: context,
                          state: state,
                          appTheme: appTheme,
                          size: size,
                        ),
                ],
              )
              // child:
              ),
        ),
      ),
    );
  }

  Widget _buildMobileView({
    required BuildContext context,
    required SignUpScreenState state,
    required IAppThemeData appTheme,
    required Size size,
    required List<ProfessionData> professionList,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 41,
        ),
        _getStartedTitle(appTheme: appTheme),
        Center(
          child: GeneralText(
            Strings.signUpTitle,
            textAlign: TextAlign.center,
            style: appTheme.typographies.interFontFamily.headline4.copyWith(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 27,
        ),
        displayFullName(appTheme),
        const SizedBox(
          height: 27,
        ),
        displayMobileNumber(appTheme),
        const SizedBox(
          height: 27,
        ),
        displayAgeGender(appTheme),
        const SizedBox(
          height: 10,
        ),
        // state.when(initialized: initialized, loaded: loaded)
        displayProfession(appTheme, professionList),
        const SizedBox(
          height: 140,
        ),
      ],
    );
  }

  Widget _buildTabletView({
    required BuildContext context,
    required SignUpScreenState state,
    required IAppThemeData appTheme,
    required Size size,
  }) {
    return Container();
  }

  Widget displayFullName(IAppThemeData appTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.signFullNameLabel,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline4.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            controller: _nameController,
            inputType: InputType.text,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter name',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {
              // viewModel.onFormValuesChange(
              //     fullName: _nameController.text.trim());
            }),
      ],
    );
  }

  Widget displayMobileNumber(IAppThemeData appTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.signMobileNumberLabel,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            controller: _mobileNumberController,
            inputType: InputType.digit,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter Mobile Number',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (newValue) {
              // viewModel.onFormValuesChange(
              //     mobileNumber: _mobileNumberController.text.trim());
            }),
      ],
    );
  }

  Widget displayAgeGender(IAppThemeData appTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralText(
                Strings.signAgeLabel,
                textAlign: TextAlign.center,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: const Color(0xfffbeccb),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              GeneralTextInput(
                  height: 80,
                  textFieldWidth: 80,
                  controller: _ageController,
                  inputType: InputType.digit,
                  backgroundColor: appTheme.colors.textFieldFilledColor,
                  inputBorder: appTheme.focusedBorder,
                  valueStyle: const TextStyle(color: Colors.white),
                  hint: '18',
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4), fontSize: 14),
                  // valueStyle: valueStyle,
                  onChanged: (newValue) {
                    // viewModel.onFormValuesChange(
                    //     age: int.parse(_ageController.text.trim()));
                  }),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralText(
                Strings.signGenderLabel,
                textAlign: TextAlign.center,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: const Color(0xfffbeccb),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              _genderWidget(appTheme, Gender.male, Strings.signMaleLabel),
              // Row(
              //   children: [
              //     _genderWidget(appTheme, Gender.male, Strings.signMaleLabel),
              //     const SizedBox(
              //       width: 12,
              //     ),
              //     _genderWidget(
              //         appTheme, Gender.female, Strings.signFemaleLabel),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget displayProfession(
    IAppThemeData appTheme,
    List<ProfessionData> professionList,
  ) {
    loadProfessionList(professionList);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.signProfessionLabel,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline4.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        GeneralDropdown(
          name: 'Select',
          items: dropdownItems,
          borderColor: appTheme.colors.textFieldBorderColor,
          // selectedItem: dropdownItems.first,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
          onChange: ({
            required String key,
            required dynamic value,
          }) {
            developer.log(' Key data is drop down ' + key);
            developer.log(' value data is drop down ' + '$value');
            _professionID = dropdownDetails[value];
          },
        ),
      ],
    );
  }

  Widget displayAlreadySignIn(
    IAppThemeData appTheme,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: GeneralText(
              Strings.signAlreadyUserLabel,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfff7dc99),
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500),
            ),
          ),
          InkWell(
            onTap: () {
              proceedVerification(context);
              //  _showVerificationPopup(context);
            },
            child: SvgPicture.asset(
              Resources.getRightArrow,
            ),
          )
        ],
      ),
    );
  }

  void proceedVerification(context) {
    viewModel.saveFoodie(
      name: _nameController.text,
      mobileNumber: _mobileNumberController.text,
      age: int.parse(_ageController.text),
      professionId: _professionID,
      gender: _genderController.text,
      context: context,
      baseUrl: baseURLs[0],
    );
  }

  Widget _genderWidget(IAppThemeData appTheme, Gender gender, String text) {
    return GeneralGender(
      gender: gender,
      text: text,
      selectedItem: gender,
      items: genderList,
      onTap: (value) {
        _genderController.text = value;
        developer.log(' Here Gender clicked ' + '$value');
      },
    );
    // return Expanded(
    //   child: InkWell(
    //     onTap: () {
    //       changeGender(gender);
    //     },
    //     child: Container(
    //         padding: const EdgeInsets.symmetric(vertical: 15),
    //         child: GeneralText(
    //           text,
    //           textAlign: TextAlign.center,
    //           style: appTheme.typographies.interFontFamily.headline2.copyWith(
    //               color: selectedGender == gender ? Colors.black : Colors.white,
    //               fontSize: 15,
    //               fontWeight: FontWeight.bold),
    //         ),
    //         decoration: BoxDecoration(
    //             border: Border.all(
    //                 color: appTheme.colors
    //                     .textFieldBorderColor // green as background color
    //
    //                 ),
    //             borderRadius: BorderRadius.circular(10), // radius of 10
    //             color: selectedGender == gender
    //                 ? appTheme.colors.textFieldBorderColor
    //                 : appTheme.colors.primaryBackground)),
    //   ),
    // );
  }

  Widget _getStartedTitle({required IAppThemeData appTheme}) {
    return Center(
      child: GeneralText(
        Strings.letsGetTitle,
        textAlign: TextAlign.center,
        style: appTheme.typographies.interFontFamily.headline4.copyWith(
            color: const Color(0xfff1c452),
            fontSize: 28,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.getStartedButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SignUpScreen()),
        // );
        //    viewModel.goToForgotPasswordScreen();
      },
    );
  }

  Future<dynamic> _showVerificationPopup(BuildContext context) async {
    final appTheme = AppTheme.of(context).theme;
    final TextController _otpController = TextController();

    return DialogHelper.show(
      context: context,
      // dialogType: GeneralComponentStyle.success,
      isDismissible: true,
      barrierLabel: '',

      // title: 'Verification\nCode',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GeneralText(
              Strings.verificationPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  color: appTheme.colors.secondaryBackground,
                  fontSize: 24,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 14,
            ),
            GeneralText(
              Strings.verificationPopupSubtitle,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: appTheme.colors.secondaryBackground,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 34,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: PinCodeTextField(
                controller: _otpController,

                length: 4,
                cursorColor: appTheme.colors.secondaryBackground,

                textStyle: TextStyle(
                  color: appTheme.colors.secondaryBackground,
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  selectedColor: Color(0xfff1c452),
                  disabledColor: Color(0xfff1c452),
                  inactiveColor: Color(0xfff1c452),
                  inactiveFillColor: Color(0xff35353C),
                  activeColor: Color(0xff35353C),
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 58,
                  fieldWidth: 65,
                  selectedFillColor: Color(0xff35353C),
                  activeFillColor: Color(0xff35353C),
                ),
                obscureText: false,
                keyboardType: TextInputType.number,

                enableActiveFill: true,
                // validator: (value) {
                //   String? validationText =getIt<Localization>().mtLocalized("otp_enterOTP");
                //       "Fields cannot be empty";
                //   if (value!.length == AppConstants.otpLength) {
                //     validationText = null;
                //   }
                //   return validationText;
                // },
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                //errorAnimationController: errorController, // Pass it here
                onChanged: (value) {},
                onSubmitted: (value) {},
                appContext: context,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GeneralButton.button(
              title: Strings.verificationPopupButton.toUpperCase(),
              styleType: ButtonStyleType.fill,
              width: 170,
              onTap: () {
                developer.log(
                    ' Here Collected data is ' + '${_nameController.text}');
                developer.log(
                    'Mobile Controller  ' + '${_mobileNumberController.text}');

                developer.log(' Age Controller  ' + '${_ageController.text}');
                developer.log(' Profession ID   ' + '${_professionID}');

                developer
                    .log(' Gender selected is    ' + _genderController.text);
                viewModel.saveFoodie(
                  name: _nameController.text,
                  mobileNumber: _mobileNumberController.text,
                  age: int.parse(_ageController.text),
                  professionId: _professionID,
                  gender: _genderController.text,
                  context: context,
                  baseUrl: baseURLs[0],
                );
                // viewModel.v
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => SignUpQuestionireScreen()),
                // );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
                //    viewModel.goToForgotPasswordScreen();
              },
            ),
            SizedBox(
              height: 22,
            ),
            GeneralText(
              Strings.verificationPopupResendCode,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfff7dc99),
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
