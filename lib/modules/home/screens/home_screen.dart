import 'dart:async';
import 'dart:io';

import 'package:Monexo/modules/home/models/YoutubeVediosModel.dart';
import 'package:Monexo/modules/home/screens/player_video_page.dart';
import 'package:Monexo/modules/home/screens/stories_page.dart';
import 'package:Monexo/modules/marketplace/screens/new_market_place_screen.dart';
import 'package:Monexo/modules/onboardingSteps/screens/mip_set_up.dart';
import 'package:Monexo/modules/onboardingSteps/screens/sip_mip_intro_screen.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/supporting_file/appsFlyerSdk.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/constants.dart';
import 'package:Monexo/utils/extensions.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:Monexo/widgets/custom_button.dart';
import 'package:Monexo/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyy_flutter_plugin/flyy_flutter_plugin.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes_management/routes_list.dart';
import '../../../utils/images.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/header.dart';
import '../../profile/widgets/logoWidget.dart';
import '../models/NewOfferModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> cardName = ['Go To \nMarketplace', 'My Portfolio \nAnalysis'];

var imageList = [
  LocalImages.marketplcae_icon,
  LocalImages.portfolioAnalysis_icon,
];

void onCardClick(BuildContext context, index) {
  final provider = Provider.of<AppStateProvider>(context, listen: false);

  switch (cardName[index]) {
    case 'Go To \nMarketplace':
      provider.isPrimaryMarketSelected = true;
      context.pushNamed(RoutesName.NewMarketPlace, queryParams: {
        "data": Utils.buildTokenJson(
            context.read<AppStateProvider>().token ?? "",
            context.read<AppStateProvider>().customerId)
      });
      break;
    case 'My Portfolio \nAnalysis':
      // Utils.showBasicDialog(context, 'Coming Soon');
      context.pushNamed(RoutesName.PortfolioAnalysis);
      break;
    default:
  }
}

class _HomeScreenState extends State<HomeScreen> {
  NewOfferModel? offerModelResponse;
  PageController? _controller;
  int currentIndex = 0;
  List<VideoData>? youtubevideos = [];

  Future<void> resetOnbaordingScreenStatus() async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool('show_onboarding', false);
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    Utils.isFirstDepositVideoValidate = false;
    resetOnbaordingScreenStatus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setLoader(true);
      await context.read<AppStateProvider>().getCustomerDetails();
      await context.read<AppStateProvider>().getStepsStatus();
      await context.read<AppStateProvider>().getStatement();
      context.read<AppStateProvider>().getFlyyWebToken();
      setLoader(false);
    });
    getFundDetails();
    setOsType();
    setAppsFlyId();
    getOfferData();
    getYoutubeVideosLocaly();
  }

  void getFundDetails() async {
    setState(() {
      loadingAmount = true;
    });
    await context.read<AppStateProvider>().getUserFundDetails();
    setState(() {
      loadingAmount = false;
    });
  }

  setOsType() async {
    setLoader(true);
    context
        .read<AppStateProvider>()
        .setOsType(Platform.isIOS ? 'IOS' : 'ANDROID');

    setLoader(false);
  }

  setAppsFlyId() async {
    setLoader(true);
    context.read<AppStateProvider>().setappsFlyIdUpdate(AFSdk.appFlyId);
    setLoader(false);
  }

  getOfferData() async {
    setLoader(true);
    offerModelResponse = (await context.read<AppStateProvider>().getOffer());
    setLoader(false);
  }

  getYoutubeVideosLocaly() async {
    final youtubeVideo = context.read<AppStateProvider>().youtubeVideos;
    youtubevideos = youtubeVideo?.data
        ?.where((element) => element.videoType == Constants.homeScreenKey)
        .toList();
  }

  bool loadingAmount = false;
  bool loading = false;
  setLoader(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final screenPadding = ResponsiveWidget.isLargeScreen(context)
        ? 40.0
        : ResponsiveWidget.isMediumScreen(context)
            ? 20.0
            : 8.0;
    var provider = Provider.of<AppStateProvider>(context);
    var userData = provider.userDetails;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MonexoLoader(
        isLoading: loading,
        child: Scaffold(
          backgroundColor: ColorsUtil.grey,
          appBar: ResponsiveWidget.isSmallScreen(context)
              ? AppBar(
                  centerTitle: false,
                  title: InkWell(
                    onTap: () {
                      context.pushNamed(RoutesName.ProfileScreen);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Utils.getCurrentGreetings()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: CustomFonts.nunito,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '${context.read<AppStateProvider>().userDetails?.panDetails?.fullName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: CustomFonts.nunito,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  toolbarHeight: 70,
                  backgroundColor: ColorsUtil.blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8),
                    ),
                  ),
                  leadingWidth: 70,
                  leading: InkWell(
                    onTap: () {
                      context.pushNamed(RoutesName.ProfileScreen);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: LogoWidget(
                        size: 45,
                        url: userData?.profileDetails?.profileUrl ?? '',
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      padding: EdgeInsets.only(right: 10),
                      onPressed: () {
                        context.pushNamed(RoutesName.SettingsScreen);
                      },
                      icon: Image.asset('images/menu.png'),
                      color: Colors.white,
                    )
                  ],
                )
              : null,
          body: SafeArea(
            child: MonexoLoader(
              child: ResponsiveWidget.isSmallScreen(context)
                  ? Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenPadding, vertical: 10),
                                child: mainWidget(context, screenPadding),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: Row(
                        children: [
                          Container(
                            width: screenSize.width * .56,
                            color: ColorsUtil.white,
                            child: Column(
                              children: [
                                // Header(
                                //   isBackBtnVisible: false,
                                //   isMenuVisible: true,
                                //   // menuOnPressed: () {},
                                // ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                      color: ColorsUtil.blueColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(14),
                                        bottomRight: Radius.circular(14),
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.pushNamed(
                                              RoutesName.ProfileScreen);
                                        },
                                        child: LogoWidget(
                                          size: 45,
                                          url: userData?.profileDetails
                                                  ?.profileUrl ??
                                              '',
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      InkWell(
                                        onTap: () {
                                          context.pushNamed(
                                              RoutesName.ProfileScreen);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${Utils.getCurrentGreetings()}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: CustomFonts.nunito,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w100,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              '${context.read<AppStateProvider>().userDetails?.panDetails?.fullName}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: CustomFonts.nunito,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        padding: EdgeInsets.only(right: 10),
                                        onPressed: () {
                                          context.pushNamed(
                                              RoutesName.SettingsScreen);
                                        },
                                        icon: Image.asset('images/menu.png'),
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      child: Center(
                                        child: Container(
                                          width: screenSize.width * .4,
                                          constraints:
                                              BoxConstraints(maxWidth: 500),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                width: screenSize.width * .4,
                                                constraints: BoxConstraints(
                                                    maxWidth: 500),
                                                child: mainWidget(
                                                    context, screenPadding),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenSize.width * .44,
                            color: ColorsUtil.blueColor,
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Column mainWidget(BuildContext context, double screenPadding) {
    final userDetails = context.read<AppStateProvider>().userDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        offerModelResponse?.data?.count == 0 || Utils.isWeb
            ? Container()
            : Container(
                height: 115,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: offerModelResponse?.data?.count ?? 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (offerModelResponse
                                          ?.data?.items?[index].fly_vedio_url !=
                                      '' &&
                                  offerModelResponse
                                          ?.data?.items?[index].fly_vedio_url !=
                                      null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerVideoPage(
                                      videoURL: offerModelResponse?.data
                                              ?.items?[index].fly_vedio_url ??
                                          '',
                                      validateWatchTime: false,
                                      id: offerModelResponse
                                          ?.data?.items?[index].id,
                                      showNextButton: true,
                                      type: offerModelResponse?.data
                                              ?.items?[index].screenCode ??
                                          '',
                                    ),
                                  ),
                                ).then((value) => {
                                      if (value == true)
                                        {
                                          Utils.getOfferOnTap(
                                              offerModelResponse
                                                      ?.data
                                                      ?.items?[index]
                                                      .screenCode ??
                                                  '',
                                              offerModelResponse
                                                  ?.data?.items?[index].id)
                                        }
                                    });
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          StoriesPage(
                                        storyUrl: offerModelResponse
                                                ?.data?.items?[index].gifUrl ??
                                            '',
                                        thumbNailUrl: offerModelResponse
                                                ?.data?.items?[index].iconUrl ??
                                            '',
                                        title: offerModelResponse
                                                ?.data?.items?[index].title ??
                                            '',
                                        type: offerModelResponse?.data
                                                ?.items?[index].screenCode ??
                                            '',
                                        id: offerModelResponse
                                            ?.data?.items?[index].id,
                                      ),
                                      fullscreenDialog: true,
                                    ));
                              }
                              // Utils.getOfferOnTap(
                              //     offerModelResponse
                              //             ?.data?.items?[index].screenCode ??
                              //         '',
                              //     offerModelResponse?.data?.items?[index].id);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: CircleAvatar(
                                radius: 34,
                                backgroundColor: ColorsUtil.lighterGrey,
                                child: CircleAvatar(
                                  radius: 33.5,
                                  backgroundColor: ColorsUtil.white,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: ColorsUtil.lighterGrey,
                                    child: CircleAvatar(
                                      radius: 29.5,
                                      backgroundColor: ColorsUtil.white,
                                      child: ClipOval(
                                          child: offerModelResponse?.data
                                                      ?.items?[index].iconUrl ==
                                                  null
                                              // offerModelResponse
                                              //             ?.data
                                              //             ?.items?[index]
                                              //             .showBanner ??
                                              //         false
                                              ? Image.asset(
                                                  LocalImages.offer_icon,
                                                  // fit: BoxFit.fitHeight,
                                                )
                                              : FadeInImage(
                                                  image: NetworkImage(
                                                      offerModelResponse
                                                              ?.data
                                                              ?.items?[index]
                                                              .iconUrl ??
                                                          ''
                                                      // 'https://ghc.theflyy.com/assets/flyy_offers/default_offer_banner3.png'
                                                      ),
                                                  placeholder: AssetImage(
                                                      LocalImages.offer_icon),
                                                )
                                          // : Image.asset(
                                          //     LocalImages.offer_icon,
                                          //     // fit: BoxFit.fitHeight,
                                          //   )
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            // height: 40,
                            width: 50,
                            child: Text(
                                offerModelResponse?.data?.items?[index].title ??
                                    '',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                // 'Offer 1',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: CustomFonts.nunito,
                                )),
                          )
                        ],
                      );
                    }),
              ),
        Card(
          color: Utils.availableAmount == 0.0
              ? ColorsUtil.redhomeCardColor
              : ColorsUtil.homeCardContainer,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('Balance Available To Invest',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: CustomFonts.nunito,
                          fontWeight: FontWeight.w700)),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loadingAmount
                          ? CircularProgressIndicator(
                              backgroundColor: ColorsUtil.blueColor,
                              strokeWidth: 2.0,
                            )
                          : Text(
                              Utils.availableAmount == 0.0
                                  ? '₹  Nil'
                                  : '₹  ${Utils.availableAmount.truncate().commaAddedValue()}',
                              // : '₹  ${double.parse(999.98.toStringAsFixed(0)).commaAddedValue(digit: 2)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: CustomFonts.nunito,
                                  fontWeight: FontWeight.w700),
                            ),
                      Container(
                          height: 40,
                          width: 120,
                          margin: EdgeInsets.all(8),
                          child: CustomButton(
                            horizontalMargin: 0,
                            titleStr: 'Add Money',
                            onPress: () {
                              context
                                  .pushNamed(RoutesName.NewFundTransferScreen);
                            },
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 9.0),
          height: Utils.isWeb ? 400.0 : MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: ColorsUtil.homeCardColor,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (Utils.isWeb) {
                    Utils.launchURL(youtubevideos?[currentIndex].videoUrl);
                  } else {
                    context.pushNamed(RoutesName.VideoPlayerPage, params: {
                      Constants.videoUrl:
                          youtubevideos?[currentIndex].videoUrl ?? '',
                      Constants.validateWatchTime: 'false'
                    });
                  }
                },
                child: Container(
                  child: PageView.builder(
                      controller: _controller,
                      itemCount: youtubevideos?.length,

                      /// Make it Dynamic with API of Viedos
                      onPageChanged: (int index) {
                        // PageView Value Changed
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (_, i) {
                        return Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(20.0),
                          //   // color: ColorsUtil.homeCardColor,
                          // ),
                          width: double.infinity,
                          child: Stack(
                            children: [
                              ClipRRect(
                                // borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  youtubevideos?[i].thumbnailUrl ?? '',
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  LocalImages.video_icon,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 18.0),

                  /// Make Page View with Page Indicator here
                  height: 20.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Make it Dynamic with API of Videos
                      for (int i = 0; i < (youtubevideos?.length ?? 0); i++)
                        if (i == currentIndex)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 5.0,
            ),
            InkWell(
              onTap: () {
                Utils.showSocialImpactLoans = true;
                onCardClick(context, 0);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: ColorsUtil.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Social Impact Loans',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: CustomFonts.nunito,
                                  fontSize: 18.0,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Invest to change lives and livelihoods ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: CustomFonts.nunito,
                                  fontSize: 12.0,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 110.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color(0xff405AA9),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Text(
                                'Invest Now',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: CustomFonts.nunito,
                                    fontSize: 12.0,
                                    color: ColorsUtil.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      // color: Colors.pink,
                      child: Image(
                        image: AssetImage(LocalImages.socialImpactLoan),
                        width: 170,
                        // height: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 12.0,
            // ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cardName.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.15,
              crossAxisSpacing: 12.0),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                onCardClick(context, index);
              },
              child: Container(
                margin: EdgeInsets.all(3),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: index == 0
                      ? ColorsUtil.homeCardColor
                      : ColorsUtil.homeCardColorGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, left: 10),
                            child: CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                // image,
                                imageList[index],
                                height: 35,
                                width: 35,
                              ),
                              backgroundColor: index == 0
                                  ? ColorsUtil.blueColor
                                  : ColorsUtil.greenIconColor,
                            ),
                          )
                          // Container(
                          //   margin: EdgeInsets.only(top: 12.0, left: 12.0),
                          //   decoration: BoxDecoration(
                          //       color: index == 0
                          //           ? ColorsUtil.blueColor
                          //           : ColorsUtil.greenIconColor,
                          //       shape: BoxShape.circle),
                          //   child: Image.asset(
                          //     // image,
                          //     imageList[index],
                          //     height: 60,
                          //     width: 60,
                          //   ),
                          // ),
                          ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10.0),
                          child: Text(cardName[index],
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: CustomFonts.nunito,
                                  color: ColorsUtil.blueColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Visibility(
            visible: userDetails?.enableDialogFiled == 'E-KYC',
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  onTap: () {
                    //KYC push
                    context.pushNamed(RoutesName.AadharVerification);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: ColorsUtil.blueColor,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Complete Your \nE-KYC',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: CustomFonts.nunito,
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 8.0,
                                // ),
                                // Text(
                                //   'Monthly Income Plan enables you to receive "Passive income" every month to manage expenses or sign up for Mutual fund SIP',
                                //   textAlign: TextAlign.left,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.w600,
                                //       fontFamily: CustomFonts.nunito,
                                //       fontSize: 12.0,
                                //       color: Colors.white),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white.withOpacity(0.2),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Enable Now',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: CustomFonts.nunito,
                                fontSize: 12.0,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
        Visibility(
            visible: userDetails?.enableDialogFiled == 'SIP',
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(RoutesName.IntroScreen,
                        params: {Constants.forSIP: 'true'});
                    // context.pushNamed(RoutesName.SIP);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: ColorsUtil.blueColor,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(LocalImages.calender),
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'Enable Your SIP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: CustomFonts.nunito,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white.withOpacity(0.2),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Enable Now',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: CustomFonts.nunito,
                                fontSize: 12.0,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
        Visibility(
            visible: userDetails?.enableDialogFiled == 'MIP',
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(RoutesName.MIPSetUp);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: ColorsUtil.blueColor,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enable Your MIP',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: CustomFonts.nunito,
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Monthly Income Plan enables you to receive "Passive income" every month to manage expenses or sign up for Mutual fund SIP',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: CustomFonts.nunito,
                                      fontSize: 12.0,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Text(
                                    'Enable Now',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: CustomFonts.nunito,
                                        fontSize: 12.0,
                                        color: ColorsUtil.blueColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Image(
                          image: AssetImage(LocalImages.coinDrop),
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 12.0,
                // ),
              ],
            )),
        Center(
          child: Visibility(
            visible: true,
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                InkWell(
                    onTap: () {
                      FlyyFlutterPlugin.openFlyyInviteAndEarnPage(0);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Image.asset(
                        LocalImages.referBanner,
                        fit: BoxFit.fill,
                        height: Utils.isWeb ? 150 : null,
                        width: MediaQuery.of(context).size.width,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Silde Dots for Home Video Corousal Container
class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? ColorsUtil.blueColor : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
