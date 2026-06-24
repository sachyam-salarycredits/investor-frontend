import 'package:Monexo/language/language_en.dart';
import 'package:Monexo/modules/marketplace/models/primary_market_loan.dart';
import 'package:Monexo/modules/marketplace/widgets/secondary_loan_details_dialog.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/utils/extensions.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'custom_tooltip.dart';

import 'primary_loan_detail_dialog.dart';

//UI for mobile
class SecondaryMarketPlaceCard extends StatefulWidget {
  final int index;
  final Function? onUpdate;

  const SecondaryMarketPlaceCard({required this.index, this.onUpdate});

  @override
  _SecondaryMarketPlaceCardState createState() =>
      _SecondaryMarketPlaceCardState();
}

class _SecondaryMarketPlaceCardState extends State<SecondaryMarketPlaceCard> {
  GlobalKey<CustomTooltipState> _toolTipKey = GlobalKey<CustomTooltipState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final cardData = provider.secondaryMarketLoans![widget.index];

    var isAdded = cardData.isAddedToCart || cardData.alreadyFunded;
    var buttonText = "Buy Loan";
    if (cardData.isAddedToCart) {
      buttonText = "Added";
    }
    if (cardData.alreadyFunded) {
      buttonText = "Funded";
    }

    return Card(
      color: ColorsUtil.marketCardContainer,
      child: Column(
        children: [
          //top layout
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cardData.customerName}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          fontFamily: CustomFonts.nunito,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: ColorsUtil.lightBlack),
                    ),
                    Text(
                      '${cardData.status}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontFamily: CustomFonts.nunito,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 3),
                      child: Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: cardData.rating != null,
                          child: Container(
                            width: 90,
                            height: 20,
                            decoration: BoxDecoration(
                                color: cardData.rating == 'M'
                                    ? ColorsUtil.moderateRiskColor
                                    : cardData.rating == 'C'
                                        ? ColorsUtil.conservativeRiskColor
                                        : ColorsUtil.highRiskColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  cardData.rating == 'M'
                                      ? 'Moderate'
                                      : cardData.rating == 'C'
                                          ? 'Conservative'
                                          : 'High',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: CustomFonts.nunito,
                                    color: cardData.rating == 'M' ||
                                            cardData.rating == 'C'
                                        ? ColorsUtil.black
                                        : ColorsUtil.white,
                                  ),
                                ),
                              ),
                            ),
                          )

                          //     Container(
                          //   padding: EdgeInsets.all(10),
                          //   color: ColorsUtil.greenText,
                          //   child: Center(
                          //     child: Text(
                          //       '${cardData.rating}',
                          //       style: TextStyle(
                          //           fontFamily: CustomFonts.nunito,
                          //           fontWeight: FontWeight.w800,
                          //           fontSize: 14,
                          //           color: ColorsUtil.white),
                          //     ),
                          //   ),
                          // ),
                          ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${cardData.remainingDaysStr()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          fontFamily: CustomFonts.nunito,
                          fontSize: 10,
                          color: ColorsUtil.lightGrey),
                    )
                  ],
                )
              ],
            ),
          ),
          divider(),
          Expanded(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      "Tenor",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: CustomFonts.nunito,
                        color: ColorsUtil.lighterGrey,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Table(
                            children: [
                              TableRow(children: [
                                titleWidget('Completed'),
                                titleWidget('Remaining'),
                              ]),
                              TableRow(children: [
                                childWidget(
                                    "${cardData.tenorCompleted.round()} ${cardData.frequency.toFrequency()}"),
                                childWidget(
                                    "${cardData.tenorRemaining.round()} ${cardData.frequency.toFrequency()}"),
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Table(
                            children: [
                              TableRow(children: [
                                titleWidget('Start Date'),
                                titleWidget('End Date'),
                              ]),
                              TableRow(children: [
                                childWidget(cardData.startDate ?? ''),
                                childWidget(cardData.endDate ?? ''),
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Table(
                            children: [
                              TableRow(children: [
                                titleWidget('EMI'),
                                titleWidget('Last Payment Date'),
                              ]),
                              TableRow(children: [
                                childWidget(
                                    "₹ ${(cardData.emi ?? 0).toInt().commaAddedValue()}"),
                                childWidget(
                                    "${cardData.lastPaymentDate ?? ""}"),
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Table(
                            children: [
                              TableRow(children: [
                                titleWidget('Interest Rate'),
                                titleWidget('Buyer’s Yield'),
                              ]),
                              TableRow(children: [
                                Row(
                                  children: [
                                    childWidget(
                                        "${cardData.interestRate}% p.a"),
                                    // SizedBox(width: 5),
                                    // Text(
                                    //   "+ 1.18%",
                                    //   style: TextStyle(
                                    //       fontSize: 12,
                                    //       color: ColorsUtil.darkerRed,
                                    //       fontWeight: FontWeight.w700),
                                    // )
                                  ],
                                ),
                                childWidget("${cardData.buyersYield}%"),
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              ),
            ),
          ),

          ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Selling Price :',
                    style: TextStyle(
                        color: ColorsUtil.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: CustomFonts.nunito),
                  ),
                ),
                Expanded(
                  child: Text(
                    '₹ ${(cardData.sellingPrice).toInt().commaAddedValue()}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: ColorsUtil.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: CustomFonts.nunito),
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            tileColor: isAdded
                ? ColorsUtil.marketPlaceContainer2
                : ColorsUtil.blueColor,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          SecondaryLoanDetailsDialog(
                        index: widget.index,
                      ),
                    );
                  },
                  child: Text(
                    'View Loan Details',
                    style: TextStyle(
                        color: isAdded
                            ? ColorsUtil.blueColor
                            : ColorsUtil.viewLoanGreenColor,
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: CustomFonts.nunito),
                  ),
                ),
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ColorsUtil.white),
                  child: CustomTooltip(
                    message: "",
                    key: _toolTipKey,
                    child: TextButton.icon(
                      onPressed: () async {
                        if (cardData.alreadyFunded) {
                          return;
                        }

                        final isKycDone =
                            (provider.stepsData?.kyc ?? '0') == "1";
                        if (cardData.alreadyFunded) {
                          _toolTipKey.currentState!
                              .showMessage("You already funded to this loan");
                          return;
                        }

                        var availableBalance = provider.userFundTransferDetails
                                ?.totalAvailableBalance?.availableBalance ??
                            0;

                        if (availableBalance <
                            (provider.getTotalCartAmount() +
                                cardData.sellingPrice)) {
                          _toolTipKey.currentState!.showMessage(
                              "You do not have enough balance to fund this loan!");
                          return;
                        }

                        if (isKycDone) {
                          provider.addItemsToCard(widget.index);
                          if (widget.onUpdate != null) {
                            widget.onUpdate!();
                          }
                        } else {
                          _toolTipKey.currentState!.showMessage(
                              "KYC is missing! Please complete KYC to fund this loan");
                          return;
                        }
                        var existLoanLength = provider.secondaryCartList
                            .where((i) => cardData == i)
                            .toList()
                            .length;
                        if (provider.secondaryCartList.length >= 10 &&
                            existLoanLength == 0) {
                          _toolTipKey.currentState!.showMessage(
                              "You can't buy more than 20 loans at a time!");
                          return;
                        }
                      },
                      label: Text(
                        buttonText,
                        style: TextStyle(
                            fontFamily: CustomFonts.nunito,
                            fontWeight: FontWeight.w700,
                            color: ColorsUtil.blueColor),
                      ),
                      icon: Icon(
                        isAdded ? Icons.check : Icons.add,
                        color: ColorsUtil.blueColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )

          // Container(
          //
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          //   child:  ,
          // )
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      thickness: 1,
      height: 1,
      color: ColorsUtil.settingDivider,
    );
  }

  Widget titleWidget(title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: CustomFonts.nunito,
        color: ColorsUtil.lighterGrey,
      ),
    );
  }

  Widget childWidget(title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: CustomFonts.nunito,
      ),
    );
  }
}
