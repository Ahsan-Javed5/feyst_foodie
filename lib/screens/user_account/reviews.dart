import 'package:chef/helpers/color_helper.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/review_response.dart';
import 'package:chef/models/review_response.dart' as review;
import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../setup.dart';
import '/ui_kit/helpers/dialog_helper.dart';
import '/ui_kit/widgets/general_new_appbar.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen(
      {Key? key, this.fromFoodDetailScreen = false, this.experienceId})
      : super(key: key);

  final bool fromFoodDetailScreen;
  final int? experienceId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final TextController _reviewController = TextController();
  bool isReviewLoading = false;
  late ReviewResponse reviews;
  final _storage = locateService<IStorageService>();

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
        body: isReviewLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.only(left: 12, top: 20, bottom: 30),
                  child: const GeneralNewAppBar(
                    rightIcon: Resources.homeIconSvg,
                    title: Strings.labelTitleReviews,
                    titleColor: Colors.white,
                  ),
                ),
                reviews.t!.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.35),
                        child: Center(
                          child: GeneralText(
                            Strings.noReviesYet,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: appTheme
                                .typographies.interFontFamily.headline4
                                .copyWith(
                                    color: const Color(0xff8ea659),
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Expanded(
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
                                    GeneralText(
                                      DateFormat('yyyy-MM-dd')
                                          .parse(
                                              reviewItem.dateCreated.toString())
                                          .toString()
                                          .replaceRange(11, 23, '')
                                          .trim(),
                                      // reviewItem.dateCreated.toString(),
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              fontSize: 12,
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        widget.fromFoodDetailScreen
                                            ? SizedBox()
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    Api.baseURLForImages +
                                                        reviewItem
                                                            .experienceImage
                                                            .toString())),
                                        const SizedBox(
                                          width: 17,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  GeneralText(
                                                    widget.fromFoodDetailScreen
                                                        ? reviewItem.foodieName
                                                            .toString()
                                                        : reviewItem
                                                            .experienceTitle
                                                            .toString(),
                                                    style: appTheme
                                                        .typographies
                                                        .interFontFamily
                                                        .headline6
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // radius of 10
                                                      color: const Color(
                                                          0xfff1c452),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 7,
                                                        vertical: 3),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.red,
                                                          size: 12,
                                                        ),
                                                        const SizedBox(
                                                            width: 3),
                                                        GeneralText(
                                                          reviewItem.stars
                                                              .toString(),
                                                          style: appTheme
                                                              .typographies
                                                              .interFontFamily
                                                              .headline6
                                                              .copyWith(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              widget.fromFoodDetailScreen
                                                  ? const SizedBox()
                                                  : GeneralText(
                                                      reviewItem.chefBrandName
                                                          .toString(),
                                                      style: appTheme
                                                          .typographies
                                                          .interFontFamily
                                                          .headline6
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color: const Color(
                                                                  0xfff1c452),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                              GeneralText(
                                                reviewItem.comments.toString(),
                                                maxLines: 3,
                                                style: appTheme.typographies
                                                    .interFontFamily.headline6
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                              thickness: 0.3,
                              endIndent: 20,
                            );
                          },
                        ),
                      ),
              ]),
      ),
    );
  }

  Future<void> getReviews() async {
    setState(() {
      isReviewLoading = true;
    });
    var _network = locateService<INetworkService>();
    final url = InfininURLHelpers.getRestApiURL(Api.baseURL +
        (widget.fromFoodDetailScreen
            ? 'foodie-feedback/find-by-experience-id'
            : 'chef-feedback/list'));

    final _appService = locateService<ApplicationService>();

    try {
      final response = await _network.post(
        path: url,
        data: {
          "t": widget.fromFoodDetailScreen
              ? widget.experienceId
              : {"foodieId": _appService.state.userInfo?.t.id}
        },
        header: {
          'Authorization':
              'Bearer ${_storage.readString(key: widget.fromFoodDetailScreen ? 'guest_token' : 'auth_token')}',
          'Content-Type': 'application/json'
        },
      );

      if (response != null) {
        reviews = reviewResponseFromJson(response.body);
        setState(() {
          isReviewLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
