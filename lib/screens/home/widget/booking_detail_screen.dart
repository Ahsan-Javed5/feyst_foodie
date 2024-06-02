import 'dart:ui';
import 'package:chef/helpers/function_helper.dart';
import 'package:chef/helpers/helpers.dart';
import '/models/booking/booking_list_response_model.dart';
import '/helpers/color_helper.dart';
import '/setup.dart';
import '/ui_kit/widgets/general_new_appbar.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({
    super.key,
    required this.bookingItem,
  });

  final BookingItem bookingItem;

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
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
                  title: 'Bookings',
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
              getBookingPart(
                  appTheme: appTheme,
                  title: 'Sat, Mar 16',
                  description: '07:00 PM - 09:00 PM'),
              getBookingPart(
                  appTheme: appTheme,
                  title: 'Guests',
                  description:
                      '${widget.bookingItem.persons!} | ${widget.bookingItem.preferenceName}'),
              widget.bookingItem.comments != ''
                  ? getBookingPart(
                      appTheme: appTheme,
                      title: 'Optional Notes',
                      description: '${widget.bookingItem.comments}')
                  : const SizedBox(),
              getBookingPart(
                  appTheme: appTheme,
                  title: 'Experience',
                  description:
                      'The sizzle and taste of authentic BBQ flavors in a cozy bistro setting. Savor slow-cooked meats, homemade sauces, and sides made with fresh ingredients.'),
              getBookingPart(
                  appTheme: appTheme,
                  title: 'Hosted By',
                  description: '${widget.bookingItem.brandName}'),
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

  Widget getBookingPart({
    required appTheme,
    String? title,
    String? description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(title ?? '',
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w700)),
        GeneralText(description ?? '',
            maxLines: 5,
            style: const TextStyle(color: Color(0xff909094), fontSize: 16.0)),
        FunctionHelper().getDivider(),
      ],
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
