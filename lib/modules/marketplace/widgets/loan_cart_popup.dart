import 'package:Monexo/language/language_en.dart';
import 'package:Monexo/modules/marketplace/models/market_place_card_data.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/supporting_file/otp_auto_detect.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_button.dart';
import '../models/primary_market_loan.dart';
import 'custom_tooltip.dart';

class loanCartPopupDialog extends StatefulWidget {
  final Function? onUpdate;
  final Function? refreshData;
  const loanCartPopupDialog({Key? key, this.onUpdate, this.refreshData})
      : super(key: key);

  @override
  State<loanCartPopupDialog> createState() => _loanCartPopupDialogState();
}

class _loanCartPopupDialogState extends State<loanCartPopupDialog> {
  String otp = "";
  var loanReturn = [];
  var expectedReturn = 0.0;
  var isLoading = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initAutoDetectOtp();
    expectedReturn = addLoanReturned();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  double addLoanReturned() {
    final provider = Provider.of<AppStateProvider>(context, listen: false);
    final cartList = provider.isPrimaryMarketSelected
        ? provider.primaryCartList
        : provider.secondaryCartList;
    double sumLoanReturned = 0.0;

    for (int index = 0; index < cartList.length; index++) {
      loanReturn.add(cartList[index].fundedAmount +
          (((cartList[index].lenderXIRR / 100) * cartList[index].fundedAmount) /
                  12) *
              cartList[index].tenor);
      sumLoanReturned += loanReturn[index];
    }

    print('loanReturn List::${loanReturn} ${sumLoanReturned}');
    return sumLoanReturned;
  }

  late OTPTextEditController otpController;

  initAutoDetectOtp() {
    otpController = AutoDetectOtp().getOtpController();
  }

  verifyOtp() async {
    final state = context.read<AppStateProvider>();
    final availableBalance = state.userFundTransferDetails?.withdrawableBalance ??
        state
            .userFundTransferDetails?.totalAvailableBalance?.availableBalance ??
        0;
    final totalAmount = state.getTotalCartAmount();
    if (availableBalance < totalAmount) {
      Utils.showAlert(
          context: context,
          msg: "You do not have enough balance to fund this loan!");
      return;
    }

    if (otp.length != 6) {
      return;
    }
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      var result = await state.loginVerifyOTP(
          state.userDetails!.profileDetails!.phoneNumber, otp);
      isLoading.value = false;
      if (result) {
        await showDialog(
          context: context,
          builder: (BuildContext context) => ProceedPopUpDialog(
            refreshData: () {
              if (widget.refreshData != null) {
                widget.refreshData!();
              }
            },
          ),
        );
        Navigator.pop(context);
      } else {
        Utils.showToast(msg: LanguageHelper.textValidOtp);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final cartList = provider.isPrimaryMarketSelected
        ? provider.primaryCartList
        : provider.secondaryCartList;
    var _crossAxisSpacing = 0;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    var _crossAxisCount = 1;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = MediaQuery.of(context).size.height / 6;
    var _aspectRatio = _width / cellHeight;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final otpField = TextFormField(
      controller: otpController,
      autocorrect: false,
      enableSuggestions: false,
      maxLength: 6,
      validator: (val) =>
          val!.isEmpty || val.length != 6 ? "enter valid otp" : null,
      onChanged: (otpText) async {
        otp = otpText;
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter OTP',
        hintStyle: TextStyle(
            fontFamily: CustomFonts.nunito,
            fontWeight: FontWeight.w600,
            fontSize: 16),
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.green,
            )),
        counterText: '',
        counterStyle: TextStyle(fontSize: 0),
      ),
      style: TextStyle(
          fontSize: 16,
          fontFamily: CustomFonts.nunito,
          fontWeight: FontWeight.w600,
          color: ColorsUtil.blackish),
    );
    print(
        'height${keyboardHeight > 0 ? MediaQuery.of(context).size.height - (keyboardHeight * 0.5) : MediaQuery.of(context).size.height / 1.3}');
    return Form(
      key: formKey,
      child: Container(
          padding: EdgeInsets.fromLTRB(
              14, 14, 14, MediaQuery.of(context).viewInsets.bottom),
          // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          // height: keyboardHeight > 0
          //     ? MediaQuery.of(context).size.height - (keyboardHeight *1.2)
          //     : Utils.isWeb
          //     ? MediaQuery.of(context).size.height / 1.3
          //     : Media ,
          // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.6),
          width: ResponsiveWidget.isSmallScreen(context)
              ? MediaQuery.of(context).size.width
              : 400,
          child: Wrap(
            children: [
              ListTile(
                title: Text(
                  'Funding Summary',
                  style: TextStyle(
                      fontFamily: CustomFonts.nunito,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
                trailing: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30.0,
                  ),
                ),
              ),
              // Divider(
              //   thickness: 1,
              //   height: 1,
              //   color: ColorsUtil.lighterGrey,
              // ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: keyboardHeight > 0 ? 230 : _screenHeight / 2.8),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListView.builder(
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: cartList.length,
                    // gridDelegate:
                    //     SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: _crossAxisCount,
                    //         childAspectRatio: _aspectRatio),
                    itemBuilder: (context, index) {
                      return LoanCartCard(
                        cartIndex: index,
                        onUpdate: () {
                          setState(() {
                            if (widget.onUpdate != null) {
                              widget.onUpdate!();
                              loanReturn = [];
                              expectedReturn = addLoanReturned();
                            }
                          });
                        },
                      );
                    }),
              ),
              Divider(
                thickness: 1,
                height: 1,
                color: ColorsUtil.lighterGrey,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    loanReturn == null
                        ? CircularProgressIndicator()
                        : Text(
                            // 'Expected Returns : ₹${provider.getTotalCartAmount() }':
                            'Expected Returns : ₹${expectedReturn.round().toInt()}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: CustomFonts.nunito,
                                color: Color(0xff888888),
                                fontSize: 13),
                          ),
                    Text(
                      'Total : ₹ ${provider.getTotalCartAmount()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: CustomFonts.nunito,
                          color: ColorsUtil.blueColorCart,
                          fontSize: 18),
                    )
                  ],
                ),
              ),

              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          // margin: EdgeInsets.all(8),

                          // padding:
                          //     EdgeInsets.only(left: 16, top: 16, bottom: 16),
                          //
                          // decoration: BoxDecoration(
                          //   borderRadius:
                          //       BorderRadius.all(Radius.circular(8)),
                          //   border: Border.all(color: ColorsUtil.greenText),
                          // ),
                          child: otpField),
                    ),
                    Expanded(
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          verifyOtp();
                        },
                        child: Container(
                            margin: EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: ColorsUtil.blueColorCart,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border:
                                  Border.all(color: ColorsUtil.blueColorCart),
                            ),
                            child: Center(
                              child: ValueListenableBuilder<bool>(
                                valueListenable: isLoading,
                                builder: (context, loading, child) {
                                  if (loading) {
                                    return Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          ),
                                        ));
                                  } else {
                                    return Text(
                                      'Proceed',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: CustomFonts.nunito,
                                          fontWeight: FontWeight.w600,
                                          color: ColorsUtil.white),
                                    );
                                  }
                                },
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class LoanCartCard extends StatefulWidget {
  final int cartIndex;
  final Function onUpdate;
  const LoanCartCard({required this.cartIndex, required this.onUpdate});

  @override
  _LoanCartCardState createState() => _LoanCartCardState();
}

class _LoanCartCardState extends State<LoanCartCard> {
  GlobalKey<CustomTooltipState> _toolTipKey = GlobalKey<CustomTooltipState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);

    final cartList = provider.isPrimaryMarketSelected
        ? provider.primaryCartList
        : provider.secondaryCartList;
    final cardData = cartList[widget.cartIndex];
    final onUpdate = widget.onUpdate;
    return Card(
      color: ColorsUtil.marketCardContainer1,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          '${cardData.productName} (${cardData.customerName})',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14,
              color: ColorsUtil.blueColorCart,
              fontFamily: CustomFonts.nunito,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('Loan Amount',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: CustomFonts.nunito,
                        fontWeight: FontWeight.w500)),
                Text('₹${cardData.loanAmount.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorsUtil.blueColorCart,
                        fontFamily: CustomFonts.nunito,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            // Container(
            //   height: 42,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(6),
            //       color: ColorsUtil.white),
            //   child: Row(
            //     children: [
            //       IconButton(
            //           onPressed: () {
            //             if (cardData.fundedAmount.round() > 1000) {
            //               cardData.fundedAmount -= 1000;
            //               provider.updateMarketPlaceCardData();
            //             } else {
            //               provider
            //                   .removeItemFromCard(cardData.contract);
            //               onUpdate();
            //
            //               // _toolTipKey.currentState!.showMessage(
            //               //     "Amount Cannot be less than 1000");
            //             }
            //           },
            //           icon: Icon(
            //             Icons.remove,
            //             color: ColorsUtil.blueColorCart,
            //             size: 20,
            //           )),
            //       Container(
            //         height: 42,
            //         padding: EdgeInsets.symmetric(
            //             horizontal: 4, vertical: 0),
            //         decoration: BoxDecoration(
            //           border: Border.symmetric(
            //               vertical:
            //               BorderSide(color: ColorsUtil.circleGrey)),
            //           color: ColorsUtil.white,
            //         ),
            //         child: Center(
            //           child: Text(
            //             "${cardData.fundedAmount.round()}",
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 14,
            //                 fontFamily: CustomFonts.nunito),
            //           ),
            //         ),
            //       ),
            //       IconButton(
            //           onPressed: () {
            //             // addToCart(cardData, context);
            //             onUpdate();
            //             //   print(provider.getTotalCartAmount()+cardData.fundedAmount);
            //           },
            //           icon: Icon(
            //             Icons.add,
            //             color: ColorsUtil.blueColorCart,
            //             size: 20,
            //           )),
            //     ],
            //   ),
            // )

            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Chip(
                  backgroundColor: ColorsUtil.blueColorCart,
                  label: Text(
                    '₹ ${cardData.fundedAmount.round()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: ColorsUtil.white,
                        fontFamily: CustomFonts.nunito),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.removeItemFromCard(cardData.toString());
                    setState(() {
                      provider.getTotalCartAmount() == 0
                          ? Navigator.pop(context)
                          : onUpdate();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProceedPopUpDialog extends StatelessWidget {
  final Function refreshData;
  ProceedPopUpDialog({Key? key, required this.refreshData}) : super(key: key);

  final isLoading = ValueNotifier(false);

  Future<void> checkoutBtnTap(provider, context) async {
    isLoading.value = true;
    final loansIdList = provider.primaryCartList.map((a) => a.contract);
    var status = await provider.checkoutItems();
    isLoading.value = false;
    if (status) {
      Utils.showAlert(
          context: context,
          title: "Congratulations!",
          msg: LanguageHelper.textInvestedSuccessfully,
          onTap: () {
            Navigator.pop(context);
            refreshData();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final cartList = provider.isPrimaryMarketSelected
        ? provider.primaryCartList
        : provider.secondaryCartList;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      title: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  Icons.arrow_back,
                  color: ColorsUtil.lighterGrey,
                  size: 20,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Go Back",
                  style: TextStyle(
                    color: ColorsUtil.lighterGrey,
                    fontFamily: CustomFonts.nunito,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: "TOTAL ",
                      style: TextStyle(
                        fontFamily: CustomFonts.nunito,
                        color: ColorsUtil.blueColorCart,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ₹${provider.getTotalCartAmount()}',
                          style: TextStyle(
                            color: ColorsUtil.blueColorCart,
                            fontFamily: CustomFonts.nunito,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${cartList.length} Loans',
                  style: TextStyle(
                    color: ColorsUtil.lighterGrey,
                    fontFamily: CustomFonts.nunito,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, loading, child) {
            return CustomButton(
              isLoader: loading,
              titleStr: loading ? "wait" : 'Confirm',
              onPress: loading
                  ? () {}
                  : () {
                      checkoutBtnTap(provider, context);
                      //for checking out items
                    },
            );
          },
        )
      ],
    );
  }
}
