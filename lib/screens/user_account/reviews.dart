import 'package:chef/helpers/color_helper.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/review_response.dart';
import 'package:chef/models/review_response.dart' as review;
import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../setup.dart';
import '/ui_kit/helpers/dialog_helper.dart';
import '/ui_kit/widgets/general_new_appbar.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final TextController _reviewController = TextController();
  bool isReviewLoading = false;
  late ReviewResponse reviews;

  @override
  void initState() {
    getReviews();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor.fromHex("#212129"),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(left: 12, top: 20, bottom: 30),
            child: const GeneralNewAppBar(
              rightIcon: Resources.homeIconSvg,
              title: Strings.labelTitleReviews,
              titleColor: Colors.white,
            ),
          ),
          isReviewLoading ? const Center(child: CircularProgressIndicator(),) : Expanded(
            child: ListView.separated(
              itemCount: reviews.t?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                review.T reviewItem = reviews.t![index];
                return InkWell(
                  onTap: () {
                    //_showRatingPopup(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GeneralText(
                        //   '11-04-2022',
                        //   style: appTheme
                        //       .typographies.interFontFamily.headline6
                        //       .copyWith(
                        //           fontSize: 12,
                        //           color: Colors.white.withOpacity(0.4),
                        //           fontWeight: FontWeight.w400),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    NetworkImage(Api.baseURLForImages+reviewItem.experienceImage.toString())),
                            const SizedBox(
                              width: 17,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      GeneralText(
                                        reviewItem.experienceTitle.toString(),
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10), // radius of 10
                                          color: const Color(0xfff1c452),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 3),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.red,
                                              size: 12,
                                            ),
                                            const SizedBox(width:3),
                                            GeneralText(
                                              reviewItem.stars.toString(),
                                              style: appTheme.typographies
                                                  .interFontFamily.headline6
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  GeneralText(
                                    reviewItem.chefBrandName.toString(),
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                            fontSize: 12,
                                            color: const Color(0xfff1c452),
                                            fontWeight: FontWeight.w400),
                                  ),
                                  GeneralText(
                                    reviewItem.comments.toString(),
                                    maxLines: 3,
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Color(0xfff1c452),
                  indent: 20,
                  thickness: 0.1,
                  endIndent: 20,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<dynamic> _showRatingPopup(BuildContext context) async {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.show(
      context: context,
      // dialogType: GeneralComponentStyle.success,
      isDismissible: true,
      barrierLabel: '',
      // title: 'Verification\nCode',
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              Resources.reviewCheckPNG,
              height: 63,
            ),
            const SizedBox(
              height: 16,
            ),
            GeneralText(
              Strings.ratingPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xff8ea659),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 19,
            ),
            GeneralText(
              Strings.ratingPopupSubTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 21,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color(0xfff1c452),
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(
              height: 28,
            ),
            GeneralTextInput(
                controller: _reviewController,
                inputType: InputType.text,
                isMultiline: true,
                backgroundColor: appTheme.colors.textFieldFilledColor,
                inputBorder: appTheme.focusedBorder,
                valueStyle: const TextStyle(color: Colors.white),
                hint: 'Write Something',
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4), fontSize: 14),
                // valueStyle: valueStyle,
                onChanged: (newValue) {}),
            const SizedBox(
              height: 22,
            ),
            GeneralButton.button(
              title: Strings.ratingPopupBtnTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
                //    viewModel.goToForgotPasswordScreen();
              },
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      // body: GBottomSheet<String>(
      //   bottomSheetTitle: Strings.chooseDateFormat,
      //   list: ['7878,87,876'],
      //   selectedItem: viewModel.getSelectedFormat(),
      //   bottomSheetType: BottomSheetType.dateFormat,
      // ),
    );
  }

  Future<void> getReviews() async {
    isReviewLoading = true;
    var _network = locateService<INetworkService>();
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + 'foodie-feedback/list');

    final _appService = locateService<ApplicationService>();

    try {
      final response = await _network.post(
        path: url,
        data: {
          "t": {
            "foodieId": _appService.state.userInfo?.t.id
          }
        },
        header: {
          'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
          'Content-Type': 'application/json'
        },
      );

      if (response != null) {
        reviews = reviewResponseFromJson(response.body);

      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    setState(() {
      isReviewLoading = false;
    });
  }

}
