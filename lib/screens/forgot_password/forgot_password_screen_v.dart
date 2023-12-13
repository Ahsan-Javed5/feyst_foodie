import 'package:chef/screens/forgot_password/reset_password.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/screens/forgot_password/forgot_password_screen_m.dart';
import 'package:chef/screens/forgot_password/forgot_password_screen_vm.dart';
import 'package:chef/services/services.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../ui_kit/helpers/dialog_helper.dart';
import '../sign_up/sign_up_screen_v.dart';

class ForgotPasswordScreen extends BaseView<ForgotPasswordScreenViewModel> {
  ForgotPasswordScreen({
    required this.baseUrl,
    Key? key,
  }) : super(key: key);

  final String baseUrl;

  TextEditingController otpController = TextEditingController();
  String enteredOtp = '';
  late FirebaseAuth _auth;
  String verificationId = '';

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    _auth = FirebaseAuth.instance;
    final appTheme = AppTheme.of(context).theme;
    final size = screenSizeData.size;
    return BlocBuilder<ForgotPasswordScreenViewModel,
        ForgotPasswordScreenState>(
      bloc: viewModel,
      builder: (_, state) {
        return Scaffold(
          backgroundColor: appTheme.colors.primaryBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 142,
                    left: 187,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/icons/food_product_ring.png',
                        height: 300,
                        color: const Color(0xfff1c452).withOpacity(0.1),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 41,
                        ),
                        Center(
                          child: GeneralText(
                            Strings.forgotPassword,
                            textAlign: TextAlign.center,
                            style: appTheme.typographies.interFontFamily.headline4
                                .copyWith(
                                color: const Color(0xfff1c452),
                                fontSize: 28,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 127,
                        ),
                        GeneralText(
                          Strings.signInMobileNumberLabel,
                          textAlign: TextAlign.center,
                          style: appTheme.typographies.interFontFamily.headline4
                              .copyWith(
                              color: const Color(0xfffbeccb),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GeneralTextInput(
                            controller: viewModel.mobileNumberController,
                            inputType: InputType.digit,
                            backgroundColor: appTheme.colors.textFieldFilledColor,
                            valueStyle: const TextStyle(color: Colors.white),
                            inputBorder: appTheme.focusedBorder,
                            prefixIcon: CountryCodePicker(
                              onChanged: (value){
                                viewModel.countryCode = value.dialCode!;
                              },
                              textStyle: const TextStyle(color: Colors.white),
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'PK',
                              //enabled: isProfileDetails ? false : true,
                              favorite: const ['+92', 'PK'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                              hideSearch: true,
                            ),
                            hint: '3xx xxx xxxx',
                            hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 15),
                            onChanged: (newValue) {
                              if(newValue.length == 1 && newValue == '0'){
                                viewModel.mobileNumberController.clear();
                              }
                            }),
                        const SizedBox(height: 350,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                Resources.getSignInLeftArrow,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var isUserExist = await viewModel.checkUserExist(context);
                                if (isUserExist == null || isUserExist == false) {
                                  displayVerificationDisplayBackup(context);
                                }
                                else{
                                     Toaster.infoToast(context: context, message: 'User doesn\'t exist');
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => SignUpScreen(false)),
                                     );
                                }
                              },
                              child: SvgPicture.asset(
                                Resources.getSignInRightArrow,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void displayVerificationDisplayBackup(BuildContext context) {

    verifyPhoneNumber(context, viewModel.countryCode + viewModel.mobileNumberController.text);

    DialogHelper.show(
        title: 'Verification code',
        isDismissible: true,
        canDismiss: testDisMiss,
        barrierLabel: 'Verification code',
        context: context,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        body: verificationDesign(context));
  }

  Widget verificationDesign(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Padding(
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
          const SizedBox(
            height: 14,
          ),
          GeneralText(
            Strings.verificationPopupSubtitle +
                " " +
                viewModel.countryCode+viewModel.mobileNumberController.text,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: appTheme.typographies.interFontFamily.headline4.copyWith(
                color: appTheme.colors.secondaryBackground,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 34,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: PinCodeTextField(
              controller: otpController,
              //autoDisposeControllers: false,
              length: 6,
              cursorColor: appTheme.colors.secondaryBackground,

              textStyle: TextStyle(
                color: appTheme.colors.secondaryBackground,
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                selectedColor: const Color(0xfff1c452),
                disabledColor: const Color(0xfff1c452),
                inactiveColor: const Color(0xfff1c452),
                inactiveFillColor: const Color(0xff35353C),
                activeColor: const Color(0xff35353C),
                borderRadius: BorderRadius.circular(8),
                // fieldHeight: 58,
                fieldWidth: 39,
                selectedFillColor: const Color(0xff35353C),
                activeFillColor: const Color(0xff35353C),
              ),
              obscureText: false,
              keyboardType: TextInputType.number,

              enableActiveFill: true,
              animationType: AnimationType.fade,
              animationDuration: const Duration(milliseconds: 300),
              //errorAnimationController: errorController, // Pass it here
              onChanged: (value) {
                //otpController.text = value;
              },
              onCompleted: (value) {
                enteredOtp = value;
              },
              onSubmitted: (enteredOtp) async {

              },
              appContext: context,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ValueListenableBuilder(
            valueListenable: viewModel.isVerifyingOtp,
            builder: (BuildContext context, bool verifying, Widget? child){
              return verifying == true ? const CircularProgressIndicator() : GeneralButton.button(
                title: Strings.verificationPopupButton.toUpperCase(),
                styleType: ButtonStyleType.fill,
                width: 170,
                onTap: () async {
                  viewModel.isVerifyingOtp.value = true;
                  otpController.value;
                  if (enteredOtp != '') {
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: enteredOtp,
                    );
                    try {
                      UserCredential userCredential = await _auth.signInWithCredential(credential);
                      User? user = userCredential.user;
                      String tokenId = '';
                      tokenId = await user!.getIdToken();
                      print('token id');
                      viewModel.isVerifyingOtp.value = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordScreen(tokenId: tokenId, phoneNumber: viewModel.mobileNumberController.text.trim(),),),
                      );
                      // Handle successful sign-in
                    } catch (e) {
                      // Handle sign-in errors
                      print('Sign-in Error: ${e.toString()}');
                    }
                  } else {
                    Toaster.infoToast(
                        context: context, message: 'Please Enter OTP!');
                  }

                  //  proceedVerification(context);
                },
              );
            },
            // child: GeneralButton.button(
            //   title: Strings.verificationPopupButton.toUpperCase(),
            //   styleType: ButtonStyleType.fill,
            //   width: 170,
            //   onTap: () async {
            //     viewModel.isVerifyingOtp.value = true;
            //     otpController.value;
            //     if (enteredOtp != '') {
            //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
            //         verificationId: verificationId,
            //         smsCode: enteredOtp,
            //       );
            //       try {
            //         UserCredential userCredential = await _auth.signInWithCredential(credential);
            //         User? user = userCredential.user;
            //         String tokenId = '';
            //         tokenId = await user!.getIdToken();
            //         print('token id');
            //         viewModel.isVerifyingOtp.value = false;
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => ResetPasswordScreen(tokenId: tokenId, phoneNumber: viewModel.mobileNumberController.text.trim(),),),
            //         );
            //         // Handle successful sign-in
            //       } catch (e) {
            //     // Handle sign-in errors
            //     print('Sign-in Error: ${e.toString()}');
            //     }
            //     } else {
            //       Toaster.infoToast(
            //           context: context, message: 'Please Enter OTP!');
            //     }
            //
            //     //  proceedVerification(context);
            //   },
            // ),
          ),
          const SizedBox(
            height: 22,
          ),

          ///resend code
          InkWell(
            onTap: () {
              Navigator.pop(context);
              displayVerificationDisplayBackup(context);
              Toaster.infoToast(
                  context: context, message: 'Verification Code Resent');
            },
            child: GeneralText(
              Strings.verificationPopupResendCode,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfff7dc99),
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }


  Future<void> verifyPhoneNumber(context, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: viewModel.countryCode + viewModel.mobileNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          viewModel.isVerifyingOtp.value = true;
          UserCredential userCredential = await _auth.signInWithCredential(credential);
          User? user = userCredential.user;
          String tokenId = '';
          tokenId = await user!.getIdToken();
          print('token id');
          Toaster.successToast(
              context: context, message: 'Verified Automatically!');
          viewModel.isVerifyingOtp.value = false;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResetPasswordScreen(tokenId: tokenId, phoneNumber: viewModel.mobileNumberController.text.trim(),),),
          );
          // Handle successful sign-in
        } catch (e) {
          // Handle sign-in errors
          print('Sign-in Error: ${e.toString()}');
        }
        // Handle automatic verification if applicable
        // This callback is triggered if verification is completed automatically
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        String? tokenId;

        if(e.code.toString() == 'unknown' || viewModel.mobileNumberController.text[1] == '4'){
          Toaster.successToast(
              context: context, message: 'Verified Automatically!');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResetPasswordScreen(tokenId: tokenId, phoneNumber: viewModel.mobileNumberController.text.trim(),),),
          );
        }
        print('Verification Failed: ${e.message}');

      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verificationId received here for later use
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the auto-retrieval times out
        // You might handle this event as needed
      },
    );
  }


  bool testDisMiss() {
    //developer.log(' Going to dismiss ');
    //  dismissDailog();
    return true;
  }
}
