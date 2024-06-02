import 'dart:ui';

import 'package:chef/helpers/function_helper.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/strings.dart';
import '../../../helpers/order_helper.dart';
import '../../../models/booking/booking_list_response_model.dart';
import '../../../models/home/home_response.dart' as home_data;

import '../../../helpers/color_helper.dart';
import '../../../setup.dart';
import '../../../theme/app_theme_widget.dart';
import '../../../ui_kit/widgets/general_new_appbar.dart';
import '../../../ui_kit/widgets/general_text.dart';
import '../../food_product_experience_details/food_product_details_screen_vm.dart';
import '../schedule_model.dart';

class ConfirmAndPayScreen extends StatefulWidget {
  const ConfirmAndPayScreen({
    super.key,
    required this.bookingItem,
  });

  final BookingItem bookingItem;

  @override
  State<ConfirmAndPayScreen> createState() => _ConfirmAndPayScreenState();
}

class _ConfirmAndPayScreenState extends State<ConfirmAndPayScreen> {
  final TextController nOfPersons = TextController();
  final _appService = locateService<ApplicationService>();
  final items = <String>[];
  final preferenceIds = <int>[];

  @override
  void initState() {
    // TODO: implement initState
    // widget.bookingItem?.experiencePreferences?.forEach((element) {
    //   items.add(element.preferenceName.toString());
    //   preferenceIds.add(int.parse(element.id.toString()));
    // });
    items.add(widget.bookingItem.preferenceName.toString());

    nOfPersons.text = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: HexColor.fromHex('#212129'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                child: const GeneralNewAppBar(
                  rightIcon: '',
                  titleColor: Colors.white,
                  title: 'Confirm & Pay',
                ),
              ),
              FunctionHelper().getDivider(),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        Resources.foodDetailsBg,
                        fit: BoxFit.cover,
                        height: 110,
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralText(
                          widget.bookingItem.experienceName ??
                              '', // Strings.labelSeaFood2Experience,
                          style: appTheme.typographies.interFontFamily.headline5
                              .copyWith(
                            fontSize: 21,
                            //ontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GeneralText(
                          "${Strings.byText} ${widget.bookingItem.brandName}", // Strings.labelSeaFood2Experience,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff909094),
                          ),
                        ),
                        GeneralText(
                          'DHA, Karachi', // Strings.labelSeaFood2Experience,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 13,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/star.svg',
                                  height: 13,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GeneralText(
                                  widget.bookingItem.experienceAverageRating
                                          ?.toString() ??
                                      '4.8', // Strings.labelSeaFood2Experience,
                                  style: appTheme
                                      .typographies.interFontFamily.headline2
                                      .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xfffbeccb),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 19.5, end: 19.5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#b0c18b"),
                                  borderRadius: BorderRadius.circular(20)),
                              child: GeneralText(
                                widget.bookingItem.bookingStatus!.toUpperCase(),
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                  fontSize: 12,
                                  color: HexColor.fromHex('#212129'),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FunctionHelper().getDivider(),
              GeneralText(
                'Your Experience', // Strings.labelSeaFood2Experience,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GeneralText('Sat, Mar 16',
                  style: appTheme.typographies.interFontFamily.headline6
                      .copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
              GeneralText('07:00 PM - 09:00 PM',
                  style: appTheme.typographies.interFontFamily.body1
                      .copyWith(color: Colors.white, fontSize: 16)),
              FunctionHelper().getDivider(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xff34343e),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralText(
                      'Guests', // Strings.labelSeaFood2Experience,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffeee0c1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///no of persons and preference
                    Row(
                      children: [
                        ///persons text-field
                        Container(
                          width: DeviceHelper.width * 0.16,
                          height: DeviceHelper.height * 0.065,
                          decoration: BoxDecoration(
                              color: HexColor.fromHex('#2b2b33'),
                              border: Border.all(
                                  color: HexColor.fromHex('#f1c452')),
                              borderRadius: BorderRadius.circular(10)),
                          // padding: EdgeInsetsDirectional.only(
                          //     top: 8, bottom: 8, start: 16, end: 16),
                          margin: const EdgeInsetsDirectional.only(bottom: 8),
                          child: noOfPersonsField(
                            appTheme: appTheme,
                            valueStyle: appTheme
                                .typographies.interFontFamily.body1
                                .copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            hintStyle: appTheme
                                .typographies.interFontFamily.body1
                                .copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: DeviceHelper.width * 0.05,
                        ),

                        ///preference dropdown
                        Container(
                          width: DeviceHelper.width * 0.55,
                          height: DeviceHelper.height * 0.07,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              color: HexColor.fromHex('#2b2b33'),
                              border: Border.all(
                                  color: HexColor.fromHex('#f1c452')),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsetsDirectional.only(bottom: 6),
                          // padding: const EdgeInsetsDirectional
                          //         .only(
                          //     top: 8,
                          //     bottom: 8,
                          //     start: 0,
                          //     end: 0),
                          child: Center(
                            child: GeneralDropdown(
                              selectedItemId: 1,
                              borderColor: Colors.transparent,
                              name: Strings.tableSelect,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                              // margin: 22.0,
                              items: items,
                              onChange: ({
                                required String key,
                                required dynamic value,
                              }) {
                                // _appService.state.orderHelper!
                                //     .selectedCategory = value;
                                // widget.data?.experiencePreferences
                                //     ?.forEach((element) {
                                //   if (element.preferenceName == value) {
                                //     _appService.state.orderHelper
                                //         ?.selectedPreferenceId =
                                //         int.parse(
                                //             element.preferenceId.toString());
                                //   }
                                // });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GeneralText(
                      'Optional Notes', // Strings.labelSeaFood2Experience,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffeee0c1),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              productPriceInfo(appTheme),
              const SizedBox(
                height: 30,
              ),
              widget.bookingItem.bookingStatus?.toUpperCase() == 'ACCEPTED'
                  ? SizedBox(
                      width: double.infinity,
                      child: GeneralButton.button(
                        title: 'Confirm & Pay',
                        styleType: ButtonStyleType.fill,
                        onTap: () {},
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productPriceInfo(IAppThemeData appTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
          top: 22, bottom: 22, start: 23, end: 23),
      decoration: BoxDecoration(
          color: const Color(0xff34343e),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GeneralText(
            Strings.priceDetails, // Strings.labelSeaFood2Experience,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xffeee0c1),
            ),
          ),
          const SizedBox(
            height: 13.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.totalAmount,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#ffffff'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${widget.bookingItem.totalPrice}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#ffffff'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.productDetailPriceTotal,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${widget.bookingItem.totalPrice}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.productDetailPriceTax,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${(widget.bookingItem.totalPrice)?.toStringAsFixed(0)}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.productDetailAdvancePayment,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
              GeneralText(
                // Strings.productDetailAdvancePaymentValue,
                '${Strings.rupeesLabel} ${(widget.bookingItem.totalPrice)?.toStringAsFixed(0)}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.amountDue,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${widget.bookingItem.totalPrice}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          // widget._advancePendingDetails.t.bookingStatus ==
          //     Strings.billGenerated
          //     ? Column(
          //   children: [
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Container(
          //       color: HexColor.fromHex("#ffffff").withOpacity(0.3),
          //       width: double.infinity,
          //       height: 1,
          //     ),
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         GeneralText(
          //           Strings.amountDue,
          //           style: appTheme
          //               .typographies.interFontFamily.headline6
          //               .copyWith(
          //             fontSize: 18,
          //             color: HexColor.fromHex('#f1c452'),
          //           ),
          //         ),
          //         GeneralText(
          //           //     Strings.productDetailPriceTaxValue,
          //           "${Strings.rupeesLabel} ${(widget._advancePendingDetails.t.totalAmount - widget._advancePendingDetails.t.advancePayment).toStringAsFixed(0)}",
          //           style: appTheme
          //               .typographies.interFontFamily.headline6
          //               .copyWith(
          //             fontSize: 22,
          //             fontWeight: FontWeight.bold,
          //             color: HexColor.fromHex('#f1c452'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // )
          //     : const SizedBox(),
        ],
      ),
    );
  }

  getHorizontalLine() {
    return Column(
      children: [
        const SizedBox(
          height: 7,
        ),
        Container(
          color: HexColor.fromHex("#4e4e5d").withOpacity(0.3),
          width: double.infinity,
          height: 1.3,
        ),
        const SizedBox(
          height: 7,
        ),
      ],
    );
  }

  Widget noOfPersonsField({
    required IAppThemeData appTheme,
    required TextStyle valueStyle,
    required TextStyle hintStyle,
  }) {
    return GeneralTextInput(
      contentPadding: const EdgeInsetsDirectional.only(
          top: 8, bottom: 8, start: 16, end: 16),
      controller: nOfPersons,
      hint: Strings.noOfPersonsHint,
      inputType: InputType.digit,
      valueStyle: valueStyle,
      hintStyle: hintStyle,
      validator: (_) {
        return null;
      },
      onChanged: (newValue) {
        if (newValue.isNotEmpty) {
          setState(() {
            //developer.log(' New Value of Persons $newValue');

            nOfPersons.text = newValue;
            _appService.state.orderHelper!.numberOfPerson =
                int.parse(nOfPersons.text);
          });
        }
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
                          child: Text(
                            Strings.loginSignup.toUpperCase(),
                          ),
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
                          child: Text(
                              Strings.filterCancelButtonText.toUpperCase()),
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
