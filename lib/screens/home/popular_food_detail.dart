import 'package:chef/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../ui_kit/widgets/general_text.dart';

class PopularFoodDetails extends StatefulWidget {
  const PopularFoodDetails({Key? key}) : super(key: key);

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  List<CustomModel> wowFactorsList = [];

  @override
  void initState() {
    // TODO: implement initState
    wowFactorsList.addAll([
      CustomModel(
          icon: Strings.productDetailWowFactorGarden,
          name: "assets/images/icons/garden.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorMusic,
          name: "assets/images/icons/music.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorFireworks,
          name: "assets/images/icons/fireworks.png"),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: HexColor.fromHex("#212129"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.only(start: 24, end: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 44,
              ),
              allPopularFoodItemList(appTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget allPopularFoodItemList(IAppThemeData appTheme) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.only(left: 33, bottom: 17),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#4b4b52"),
                borderRadius: BorderRadius.circular(20)),
            child: Stack(children: [
              Positioned(
                right: -50,
                top: -40,
                child: Container(
                  width: 173,
                  padding: const EdgeInsetsDirectional.all(20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/icons/food_product_ring.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/icons/food_product_experience.png',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32.2,
                  ),
                  GeneralText(
                    Strings.popularFoodDetailTitle,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 18,
                      color: HexColor.fromHex('#f1c452'),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  GeneralText(
                    Strings.popularFoodDetailSubTitle,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 14,
                      color: HexColor.fromHex('#909094'),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 13.9,
                        child: Image.asset('assets/images/icons/star.png',
                            fit: BoxFit.fill),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GeneralText(
                        Strings.popularFoodDetailReview,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                                fontSize: 14,
                                color: HexColor.fromHex('#8ea659')),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 11.7,
                  ),
                  GeneralText(
                    Strings.popularFoodDetailWowFactorTitle,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex(
                              '#ffffff',
                            ),
                            fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 11.7,
                  ),
                  wowFactors(appTheme),
                ],
              )
            ]),
          );
        });
  }

  Widget wowFactors(IAppThemeData appTheme) {
    return Wrap(
      children: [
        for (int i = 0; i < wowFactorsList.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8.1, bottom: 7.7),
            child: Container(
              width: 61,
              padding: const EdgeInsetsDirectional.all(22),
              decoration: const BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/icons/black_image_ring.png'),
                ),
              ),
              child: Container(
                child: Image.asset(
                  wowFactorsList[i].name != null
                      ? wowFactorsList[i].name ?? ""
                      : '',
                  color: HexColor.fromHex("#f1c452"),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomModel {
  String? name;
  String? icon;

  CustomModel({this.name, this.icon});
}
