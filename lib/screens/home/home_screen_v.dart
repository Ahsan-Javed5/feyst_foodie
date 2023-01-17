import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/home/popular_food_detail.dart';
import 'package:flutter/material.dart';

import '../../helpers/color_helper.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: Color(0xff212129),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Image.asset(
                  Resources.homeScreenBG,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          Positioned.fill(
            top: 80,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 31),
                    child: GeneralText(
                      Strings.labelExplore,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 35,
                        // fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 31),
                    child: GeneralText(
                      Strings.labelFoodExperience,
                      style: appTheme.typographies.interFontFamily.headline4
                          .copyWith(
                        fontSize: 29,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.only(left: 31),
                    child: ListView.builder(
                        itemCount: 3,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _FoodContainer(appTheme: appTheme);
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 31, bottom: 0),
                    child: GeneralText(
                      Strings.labelPopularDishes,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfff1c452),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20, top: 4),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.61,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return _PopularDishes(appTheme: appTheme);
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PopularDishes extends StatelessWidget {
  const _PopularDishes({
    Key? key,
    required this.appTheme,
  }) : super(key: key);

  final IAppThemeData appTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PopularFoodDetails()),
        );
      },
      child: Container(
        // height: 170,
        width: 170,
        padding: const EdgeInsets.only(left: 13),
        decoration: BoxDecoration(
          color: HexColor.fromHex("#4b4b52"),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -20,
                child: Container(
                  height: 170,
                  width: 170,
                  padding: const EdgeInsetsDirectional.only(bottom: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/icons/ring_placeholder_dashboard.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/icons/food_product_experience.png',
                    // height: 130,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GeneralText(
                      'Sindhi\nBiryani',
                      textAlign: TextAlign.left,
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    GeneralText(
                      'by Zee Lounge',
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff909094),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FoodContainer extends StatelessWidget {
  const _FoodContainer({
    Key? key,
    required this.appTheme,
  }) : super(key: key);

  final IAppThemeData appTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => const FoodDetailScreen()),
          MaterialPageRoute(builder: (context) => const FoodDetailScreen()),
        );
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: [
              Container(
                height: 230,
                padding: EdgeInsets.all(12),
                child: Container(
                    height: 200,
                    child: Image.asset(
                      Resources.seafoodPNG,
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned.fill(
                top: 70,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 150,
                    height: 50,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: const Color(0xffbb3127),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12.0),
                          topRight: const Radius.circular(12.0),
                          bottomLeft: const Radius.circular(12.0),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralText(
                              Strings.labelSeaFoodExperience,
                              style: appTheme
                                  .typographies.interFontFamily.headline2
                                  .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            GeneralText(
                              Strings.labelSeaFood2Experience,
                              style: appTheme
                                  .typographies.interFontFamily.headline2
                                  .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        SvgPicture.asset(
                          Resources.arrowRT,
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
