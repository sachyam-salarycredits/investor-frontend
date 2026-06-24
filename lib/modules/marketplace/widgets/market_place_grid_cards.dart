import 'package:Monexo/modules/marketplace/models/common_loan_cart.dart';
import 'package:Monexo/modules/marketplace/widgets/cartAnimDemo.dart';
import 'package:Monexo/modules/marketplace/models/primary_market_loan.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/utils/extensions.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../routes_management/routes_list.dart';
import '../../../utils/constants.dart';
import 'custom_tooltip.dart';

import 'primary_loan_detail_dialog.dart';

const rowSpacer = TableRow(children: [
  SizedBox(
    height: 5,
  ),
  SizedBox(
    height: 5,
  )
]);

//UI for web
class WebMarketPlaceCard extends StatefulWidget {
  int index;
  final Function? onUpdate;

  WebMarketPlaceCard({Key? key, required this.index, this.onUpdate})
      : super(key: key);

  @override
  _WebMarketPlaceCardState createState() => _WebMarketPlaceCardState();
}

class _WebMarketPlaceCardState extends State<WebMarketPlaceCard> {
  GlobalKey<CustomTooltipState> _toolTipKey = GlobalKey<CustomTooltipState>();

  final label = ['percent'];

  List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final cardData = provider.primaryMarketLoans![widget.index];

    return Container(
      color: ColorsUtil.marketCardContainer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cardData.customerName}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorsUtil.lighterGrey,
                        fontFamily: CustomFonts.nunito,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${cardData.productName}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: CustomFonts.nunito,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                if (cardData.category != '')
                  Container(
                    width: 90,
                    height: 20,
                    decoration: BoxDecoration(
                        color: cardData.category == 'M'
                            ? ColorsUtil.moderateRiskColor
                            : cardData.category == 'C'
                                ? ColorsUtil.conservativeRiskColor
                                : ColorsUtil.highRiskColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          cardData.category == 'M'
                              ? 'Moderate'
                              : cardData.category == 'C'
                                  ? 'Conservative'
                                  : 'High',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: CustomFonts.nunito,
                            color: ColorsUtil.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                // Row(
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(right: 15),
                //       height: 39,
                //       padding: EdgeInsets.only(right: 11, left: 11),
                //       color: ColorsUtil.greenText,
                //       child: Center(
                //         child: Text(
                //           '${cardData.category}',
                //           style: TextStyle(
                //               fontFamily: CustomFonts.nunito,
                //               fontWeight: FontWeight.w800,
                //               fontSize: 14,
                //               color: ColorsUtil.white),
                //         ),
                //       ),
                //     ),
                //     // Icon(
                //     //   Icons.info_outline_rounded,
                //     //   color: ColorsUtil.lighterGrey,
                //     // )
                //   ],
                // ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            height: 1,
            color: ColorsUtil.circleGrey,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Table(
                    children: [
                      TableRow(children: [
                        Text(
                          'Loan Amount',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: CustomFonts.nunito,
                              color: ColorsUtil.lighterGrey),
                        ),
                        Text(
                          'Duration',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: CustomFonts.nunito,
                              color: ColorsUtil.lighterGrey),
                        ),
                      ]),
                      rowSpacer,
                      TableRow(children: [
                        Text(
                          '₹ ${cardData.loanAmount.commaAddedValue()}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: CustomFonts.nunito,
                          ),
                        ),
                        Text(
                          '${cardData.tenor.round()} ${cardData.frequency.toFrequency()}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: CustomFonts.nunito,
                          ),
                        ),
                      ])
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        Text(
                          'Returns',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: CustomFonts.nunito,
                              color: ColorsUtil.lighterGrey),
                        ),
                        Text(
                          'Loan already claimed',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: CustomFonts.nunito,
                              color: ColorsUtil.lighterGrey),
                        ),
                      ]),
                      rowSpacer,
                      TableRow(children: [
                        Text(
                          '${cardData.lenderXIRR}% P.A.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: CustomFonts.nunito,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 104,
                              child: SliderTheme(
                                child: Slider(
                                  value: cardData.getAlreadyFunded(),
                                  max: 1,
                                  min: 0,
                                  activeColor: ColorsUtil.greenText,
                                  inactiveColor: ColorsUtil.lightGreen,
                                  onChanged: (double value) {},
                                ),
                                data: SliderTheme.of(context).copyWith(
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 0.0),
                                    trackHeight: 10,
                                    thumbColor: Colors.transparent,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 0.0)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Row(
                                  children: modelBuilder(label, (index, label) {
                                final isSelected =
                                    index <= cardData.getAlreadyFunded();
                                final color = isSelected
                                    ? ColorsUtil.lightGrey
                                    : ColorsUtil.lighterGrey;
                                return Container(
                                    //width: width,
                                    child: Text(
                                  '${(cardData.getAlreadyFunded() * 100).toStringAsFixed(2)} %',
                                  style: TextStyle(
                                          fontFamily: CustomFonts.nunito,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)
                                      .copyWith(color: color),
                                ));
                              })),
                            ),
                          ],
                        ),
                      ])
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //       width: double.maxFinite,
          //       // margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          //       // semanticContainer: true,
          //       // clipBehavior: Clip.antiAliasWithSaveLayer,
          //       color: ColorsUtil.lightGreen,
          //       // shape: RoundedRectangleBorder(
          //       //   borderRadius:
          //       //       BorderRadius.vertical(top: Radius.circular(5.0)),
          //       // ),
          //       // elevation: 1,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'for every ₹ 1000 Investment',
          //             style: TextStyle(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w600,
          //                 fontFamily: CustomFonts.nunito),
          //           ),
          //           Text(
          //             'Get ₹ 1020',
          //             style: TextStyle(
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.w700,
          //                 fontFamily: CustomFonts.nunito),
          //           ),
          //         ],
          //       )),
          // ),
          Divider(
            thickness: 2,
            height: 1,
            color: ColorsUtil.circleGrey,
          ),
          MarketPlaceBottomCard(
            index: widget.index,
            onUpdate: () {
              if (widget.onUpdate != null) {
                widget.onUpdate!();
              }
            },
          )
        ],
      ),
    );
  }
}

//UI for mobile
class MarketPlaceCard extends StatelessWidget {
  final int index;
  final Function? onUpdate;

  const MarketPlaceCard({required this.index, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final cardData = provider.primaryMarketLoans![index];

    return Card(
      color: ColorsUtil.marketCardContainer,
      child: Column(
        children: [
          //top layout
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.topLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        /// add name
                        // "${cardData.contract} - ${cardData.productName}",
                        "${cardData.productName} (${cardData.customerName})",
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: CustomFonts.nunito,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  if (cardData.category != '')
                    Container(
                      width: 90,
                      height: 20,
                      decoration: BoxDecoration(
                          color: cardData.category == 'M'
                              ? ColorsUtil.moderateRiskColor
                              : cardData.category == 'C'
                                  ? ColorsUtil.conservativeRiskColor
                                  : ColorsUtil.highRiskColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            cardData.category == 'M'
                                ? 'Moderate'
                                : cardData.category == 'C'
                                    ? 'Conservative'
                                    : 'High',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: CustomFonts.nunito,
                              color: ColorsUtil.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   color: ColorsUtil.greenText,
                  //   child: Center(
                  //     child: Text(
                  //       cardData.category,
                  //       style: TextStyle(
                  //           fontFamily: CustomFonts.nunito,
                  //           fontWeight: FontWeight.w800,
                  //           fontSize: 14,
                  //           color: ColorsUtil.white),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 6),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1,
            height: 1,
            color: ColorsUtil.settingDivider,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Table(
                      children: [
                        TableRow(children: [
                          Text(
                            'Loan Amount',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: CustomFonts.nunito,
                                color: ColorsUtil.marketCardGrey),
                          ),
                          Text(
                            'Duration',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: CustomFonts.nunito,
                                color: ColorsUtil.marketCardGrey),
                          ),
                          Text(
                            'Returns',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: CustomFonts.nunito,
                                color: ColorsUtil.marketCardGrey),
                          ),
                        ]),
                        TableRow(children: [
                          Text(
                            '₹ ${cardData.loanAmount.commaAddedValue()}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorsUtil.blueColorCart,
                              fontFamily: CustomFonts.nunito,
                            ),
                          ),
                          Text(
                            '${cardData.tenor.round()} ${cardData.frequency.toFrequency()}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorsUtil.blueColorCart,
                              fontFamily: CustomFonts.nunito,
                            ),
                          ),
                          Text(
                            '${cardData.lenderXIRR}% P.A.',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorsUtil.blueColorCart,
                              fontWeight: FontWeight.w700,
                              fontFamily: CustomFonts.nunito,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 46,
                    percent: cardData.getAlreadyFunded(),
                    circularStrokeCap: CircularStrokeCap.square,
                    progressColor: ColorsUtil.greenText,
                    backgroundColor: ColorsUtil.settingDivider,
                    center: Text(
                      '${(cardData.getAlreadyFunded() * 100).round()} %',
                      style: TextStyle(
                          color: ColorsUtil.greenText,
                          fontFamily: CustomFonts.nunito,
                          fontWeight: FontWeight.w800,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: MarketPlaceBottomCard(
              index: index,
              onUpdate: () {
                if (onUpdate != null) {
                  onUpdate!();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class MarketPlaceBottomCard extends StatelessWidget {
  int index;
  Function onUpdate;

  MarketPlaceBottomCard({Key? key, required this.index, required this.onUpdate})
      : super(key: key);

  GlobalKey<CustomTooltipState> _toolTipKey = GlobalKey<CustomTooltipState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final cardData = provider.primaryMarketLoans![index];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: !cardData.alreadyFunded()
          ? ColorsUtil.blueColor
          : ColorsUtil.marketPlaceContainer2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
      ),
      elevation: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              // visible: !cardData.productName
              //     .toString()
              //     .toLowerCase()
              //     .contains("social impact loan"),
              child: InkWell(
                onTap: () {
                  if (cardData.productName
                      .toString()
                      .toLowerCase()
                      .contains("social impact loan")) {
                    var loanVideo = context
                        .read<AppStateProvider>()
                        .youtubeVideos
                        ?.data
                        ?.where((element) =>
                            element.videoType == Constants.socialImpactKey)
                        .first;
                    if (Utils.isWeb) {
                      Utils.launchURL(loanVideo?.videoUrl ?? '');
                    } else {
                      context.pushNamed(RoutesName.VideoPlayerPage, params: {
                        Constants.videoUrl: loanVideo?.videoUrl ?? '',
                        Constants.validateWatchTime: 'false',
                      });
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          PrimaryLoanDetailsDialog(
                        index: index,
                      ),
                    );
                  }
                },
                child: Text(
                  !cardData.productName
                          .toString()
                          .toLowerCase()
                          .contains("social impact loan")
                      ? 'View Loan Details'
                      : 'Learn More',
                  style: TextStyle(
                      color: cardData.alreadyFunded()
                          ? ColorsUtil.blueColor
                          : ColorsUtil.viewLoanGreenColor,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: CustomFonts.nunito),
                ),
              ),
            ),
            Spacer(),
            CustomTooltip(
              key: _toolTipKey,
              message: "hello i am the error",
              child: cardData.isAddedToCart
                  ? Container(
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: ColorsUtil.white),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (cardData.fundedAmount.round() > 1000) {
                                  cardData.fundedAmount -= 1000;
                                  provider.updateMarketPlaceCardData();
                                } else {
                                  provider
                                      .removeItemFromCard(cardData.contract);
                                  onUpdate();

                                  // _toolTipKey.currentState!.showMessage(
                                  //     "Amount Cannot be less than 1000");
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                color: ColorsUtil.redColor,
                                size: 20,
                              )),
                          Container(
                            height: 42,
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 0),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                  vertical:
                                      BorderSide(color: ColorsUtil.circleGrey)),
                              color: ColorsUtil.white,
                            ),
                            child: Center(
                              child: Text(
                                "${cardData.fundedAmount.round()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: CustomFonts.nunito),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                addToCart(cardData, context);
                                onUpdate();
                                //   print(provider.getTotalCartAmount()+cardData.fundedAmount);
                              },
                              icon: Icon(
                                Icons.add,
                                color: Color(0xff2A9134),
                                size: 20,
                              )),
                        ],
                      ),
                    )
                  : Container(
                      height: 42,
                      // padding: widget.isFunded
                      //     ? EdgeInsets.symmetric(horizontal: 31)
                      //     : EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: ColorsUtil.white),
                      child: TextButton.icon(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        onPressed: () async {
                          addToCart(cardData, context);
                          onUpdate();
                        },
                        label: Text(
                          cardData.alreadyFunded() ? 'Funded' : 'Fund Now',
                          style: TextStyle(
                              fontFamily: CustomFonts.nunito,
                              fontWeight: FontWeight.w700,
                              color: ColorsUtil.blueColor),
                        ),
                        icon: Icon(
                          cardData.alreadyFunded()
                              ? Icons.check_sharp
                              : Icons.add,
                          color: ColorsUtil.blueColor,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  addToCart(PrimaryMarketLoan cardData, BuildContext context) {
    final provider = context.read<AppStateProvider>();
    final isKycDone = (provider.stepsData?.kyc ?? '0') == "1";
    if (!isKycDone) {
      _toolTipKey.currentState!
          .showMessage("KYC is missing! Please complete KYC to fund this loan");

      return;
    }

    var availableBalance = provider
            .userFundTransferDetails?.totalAvailableBalance?.availableBalance ??
        0;
    var newTotal = 1000 + provider.getTotalCartAmount();

    if (newTotal > availableBalance) {
      _toolTipKey.currentState!
          .showMessage("You do not have enough balance to fund this loan!");
      return;
    }

    if ((cardData.alreadyFundedAmount + cardData.fundedAmount + 1000) > 5000) {
      _toolTipKey.currentState!.showMessage(
          "Please do not lend more than ₹ 5,000 for a diversified portfolio.");
      return;
    }

    if (cardData.fundedAmount + 1000 > cardData.getRequiredFunding()) {
      _toolTipKey.currentState!.showMessage(
          "your funding amount can’t be greater than the required loan amount!");
      return;
    }

    var existLoanLength =
        provider.primaryCartList.where((i) => cardData == i).toList().length;
    if (provider.primaryCartList.length >= 20 && existLoanLength == 0) {
      _toolTipKey.currentState!
          .showMessage("You can't fund more than 20 loans at a time!");
      return;
    }

    cardData.isAddedToCart = true;
    cardData.fundedAmount += 1000;
    provider.playCartSound();
    provider.updateMarketPlaceCardData();
  }
}
