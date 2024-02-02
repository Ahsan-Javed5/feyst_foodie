import 'dart:ui';

import 'package:chef/models/home/chef_data_response.dart';
import 'package:chef/models/home/home_response.dart' as home_data;
import 'package:chef/screens/food_product_experience_details/widget/food_product_details_summary.dart';
import 'package:chef/screens/home/food_details_menu_model.dart';
import 'package:chef/ui_kit/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../setup.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../../models/home/experience_list_response.dart' as experience_data;

import 'dart:developer' as developer;

import 'package:chef/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_view.dart';
import '../../../services/device/device_service.dart';

import '../../../models/home/experience_list_response.dart' as experience_data;
import 'food_product_details_screen_m.dart';
import 'food_product_details_screen_vm.dart';

class FoodProductExperienceDetailsScreenView
    extends BaseView<FoodProductExperienceDetailsViewModel> {
  FoodProductExperienceDetailsScreenView({
    required String selectedExperienceId,
    required home_data.Experiences experienceData,
    required FoodMenuModel foodMenuDetail,
    required ChefDataResponse chefData,
    Key? key,
  })  : _selectedExperienceId = selectedExperienceId,
        _experienceData = experienceData,
        _foodMenuDetail = foodMenuDetail,
        _chefData = chefData,
        super(key: key);

  final String _selectedExperienceId;
  final home_data.Experiences? _experienceData;
  final FoodMenuModel _foodMenuDetail;
  final ChefDataResponse _chefData;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    return BlocBuilder<FoodProductExperienceDetailsViewModel,
        FoodProductDetailScreenState>(
      bloc: viewModel..defaultState(),
      builder: (_, state) {
        return Scaffold(
            backgroundColor: HexColor.fromHex('#212129'),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: getStartedButtonTitle(context: context),
            body: state.when(
              loading: _loading,
              loaded: () => displayLoaded(),
            ));
      },
    );
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayLoaded() {
    final _appService = locateService<ApplicationService>();
    return FoodProductDetailsSummary(
      experienceData: _experienceData,
      selectedExperienceId: _selectedExperienceId,
      foodMenuDetail: _foodMenuDetail,
      chefData: _chefData,
      appService: _appService,
    );
  }

  Widget getStartedButtonTitle({required BuildContext context}) {
    final _storage = locateService<IStorageService>();

    return GeneralButton.button(
      width: 230,
      title: Strings.productDetailButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        _storage.readString(key: 'auth_token').isEmpty
            ? loginDialog(
                ctx: context,
                title: 'Login/Signup',
                titleColor: const Color(0xfff1c452),
                description: 'Please Login/Signup to book your food experience',
                iconUrl: Resources.infoDeletePNG,
                onTap: () {})
            : viewModel.submitBooking(context, _experienceData!);
      },
    );
  }

  loginDialog(
      {BuildContext? ctx,
      required String title,
      required String description,
      Color? titleColor,
      Color? descColor,
      String? highlightedName,
      required String iconUrl,
      required void Function()? onTap}) {
    final appTheme = AppTheme.of(ctx!).theme;
    final _navigation = locateService<INavigationService>();

    return showDialog(
        context: ctx,
        barrierColor: const Color(0xFF212129).withOpacity(0.1),
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AlertDialog(
              backgroundColor: const Color(0xFF212129),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    iconUrl,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GeneralText(
                    title,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? const Color(0xFF8ea659),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  highlightedName == null
                      ? Text(description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: descColor ?? Colors.white,
                          ))
                      : RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: description,
                            style: TextStyle(
                              color: descColor ?? Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: highlightedName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xfff1c452),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 135,
                        child: ElevatedButton(
                          onPressed: () {
                            _navigation.navigateTo(route: SignInRoute());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('LOGIN/SIGNUP'),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('CANCEL'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
