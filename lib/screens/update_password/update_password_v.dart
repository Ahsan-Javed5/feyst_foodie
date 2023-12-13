import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/sign_up/sign_up_screen_vm.dart';
import '../../helpers/color_helper.dart';
import '../../setup.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextController oldPasswordController = TextController();
  TextController newPasswordController = TextController();
  TextController confirmNewPasswordController = TextController();
  bool isLoading = false;
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor.fromHex("#212129"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12, top: 20, bottom: 20),
                child: GeneralNewAppBar(
                  rightIcon: Resources.homeIconSvg,
                  title: 'Update Password',
                  titleColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    displayOldPassword(appTheme),
                    const SizedBox(
                      height: 25,
                    ),
                    displayPassword(appTheme),
                    const SizedBox(
                      height: 25,
                    ),
                    displayConfirmPassword(appTheme),
                    const SizedBox(
                      height: 50,
                    ),
                    _saveButtonTitle(appTheme: appTheme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayOldPassword(
      IAppThemeData appTheme,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          'Old Password',
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
            controller: oldPasswordController,
            inputType: InputType.password,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            isEnable: true,
            // disabledBorder: viewModel.isProfileDetails!
            //     ? const OutlineInputBorder(
            //     borderSide: BorderSide(width: 2, color: Colors.grey))
            //     : null,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter Old Password',
            validator: (pass) {
              if (pass!.length < 6) {
                return 'Password must contain at least 6 characters';
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {}),
      ],
    );
  }

  Widget displayPassword(
      IAppThemeData appTheme,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          'New Password',
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
            controller: newPasswordController,
            inputType: InputType.password,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            isEnable: true,
            // disabledBorder: viewModel.isProfileDetails!
            //     ? const OutlineInputBorder(
            //     borderSide: BorderSide(width: 2, color: Colors.grey))
            //     : null,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter New Password',
            validator: (pass) {
              if (pass!.length < 6) {
                return 'Password must contain at least 6 characters';
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {}),
      ],
    );
  }

  Widget displayConfirmPassword(
      IAppThemeData appTheme,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          'Confirm New Password',
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
            controller: confirmNewPasswordController,
            inputType: InputType.password,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            //isEnable: viewModel.isProfileDetails! ? false : true,
            // disabledBorder: viewModel.isProfileDetails!
            //     ? const OutlineInputBorder(
            //     borderSide: BorderSide(width: 2, color: Colors.grey))
            //     : null,
            inputBorder: appTheme.focusedBorder,
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Re enter New Password',
            validator: (pass) {
              if (pass!.length < 6) {
                return 'Password must contain at least 6 characters';
              } else if (pass != newPasswordController.text) {
                return 'Password not same';
              }
              else{
                if (oldPasswordController.text.isNotEmpty) {
                  setState(() {
                    isEnable = true;
                  });
                }
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {}),
      ],
    );
  }

  Widget _saveButtonTitle({required IAppThemeData appTheme}) {
    return Center(
      child: isLoading ? const CircularProgressIndicator():GeneralButton.button(
        width: 180,
        title: 'SAVE',
        styleType: ButtonStyleType.fill,
        isEnable: isEnable,
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          final _signUpScreenViewModel = locateService<SignUpScreenViewModel>();
          _signUpScreenViewModel.updatePassword(
            oldPassword: oldPasswordController.text.trim(),
            newPassword: newPasswordController.text.trim(),
            context: context,
          );
        },
      ),
    );
  }
}
