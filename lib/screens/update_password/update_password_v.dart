import 'package:chef/helpers/helpers.dart';
import '../../helpers/color_helper.dart';
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


  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor.fromHex("#212129"),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.only(left: 12, top: 20, bottom: 20),
            child: GeneralNewAppBar(
                rightIcon: Resources.homeIconSvg,
                title: Strings.updatePassword,
                titleColor: Colors.white,
                callBack: (){
                  //_navigation.navigateTo(route:BottomBar(bottomBarType: bottom_bar.BottomBarType.home));
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                displayOldPassword(appTheme),
                const SizedBox(height: 15,),
                displayPassword(appTheme),
                const SizedBox(height: 15,),
                displayConfirmPassword(appTheme),
              ],
            ),
          ),

        ]),
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
            validator: (pass){
              if(pass!.length < 6){
                return 'Password must contain at least 6 characters';
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {

            }),
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
            validator: (pass){
              if(pass!.length < 6){
                return 'Password must contain at least 6 characters';
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {

            }),
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
            validator: (pass){
              if(pass!.length < 6){
                return 'Password must contain at least 6 characters';
              }else if(pass != newPasswordController.text)
              {
                return 'Password not same';
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {

            }),
      ],
    );
  }


}


