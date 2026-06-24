import 'package:Monexo/modules/marketplace/models/secondary_market_loan_detail.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/responsive.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondaryLoanDetailsDialog extends StatefulWidget {
  final int index;

  const SecondaryLoanDetailsDialog({required this.index, Key? key})
      : super(key: key);

  @override
  State<SecondaryLoanDetailsDialog> createState() =>
      _SecondaryLoanDetailsDialogState();
}

class _SecondaryLoanDetailsDialogState
    extends State<SecondaryLoanDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<AppStateProvider>(context, listen: false);
    final isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    final spacing = isSmallScreen ? 6.0 : 12.0;
    final height = isSmallScreen
        ? MediaQuery.of(context).size.height * .80
        : MediaQuery.of(context).size.height * .70;
    final width = isSmallScreen
        ? MediaQuery.of(context).size.width * .60
        : MediaQuery.of(context).size.height * .90;

    return AlertDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 0.0),
      insetPadding: EdgeInsets.symmetric(horizontal: 15.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(width: 1, color: ColorsUtil.lighterGrey)),
      title: Container(
        height: MediaQuery.of(context).size.height / 1.3,
        width: isSmallScreen
            ? MediaQuery.of(context).size.width / 1.1
            : MediaQuery.of(context).size.width / 1.3,
        child: FutureBuilder<SecondaryMarketLoanDetail?>(
            future: context
                .read<AppStateProvider>()
                .getSecondaryMarketLoanDetail(widget.index),
            builder: (context, snapshot) {
              final loadingDialog = Container(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

              if (snapshot.hasError) {
                print(snapshot.error);
              }

              if (!snapshot.hasData) {
                return loadingDialog;
              }

              if (snapshot.data == null) {
                return AlertDialog(
                  title: Text("Something went wrong"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Close"),
                    )
                  ],
                );
              }

              final loanData = context
                  .read<AppStateProvider>()
                  .secondaryMarketLoans![widget.index];
              final loanInvestdata = snapshot.data!;

              final firstTableLayout = OutlinedTable(dataList: [
                TableRowData("Status", "${loanData.status}"),
                TableRowData("Rating", "${loanData.rating}"),

                TableRowData("Interest Rate", "${loanData.interestRate} %"),
                TableRowData("Tenor", "${loanData.tenorRemaining.toInt()}"),
                // TableRowData("Monexo Fees",
                //     "${loanInvestdata.aboutInvestmentOrder?.monexoFees ?? "-"}"),
              ]);

              final secondTableLayout = OutlinedTable(dataList: [
                TableRowData(
                    "Loan Amount", loanData.sellingPrice.toStringAsFixed(2)),
                TableRowData("Payment Received Till Date",
                    "${loanInvestdata.aboutInvestmentOrder?.paymentReceivedTillDate ?? "-"}"),
                TableRowData("Principal Received",
                    "${loanInvestdata.aboutInvestmentOrder?.principalReceived ?? "-"}"),
                TableRowData("Interest Received",
                    "${loanInvestdata.aboutInvestmentOrder?.interestReceived ?? "-"}"),
                TableRowData("Misc. Income",
                    "${loanInvestdata.aboutInvestmentOrder?.miscIncome ?? "-"}"),
                TableRowData("Balance Principal O/S",
                    "${loanInvestdata.aboutInvestmentOrder?.balancePrincipalOs ?? "-"}"),
              ]);
              return Container(
                //width: ,
                height: MediaQuery.of(context).size.height / 1.3,

                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 6 : 24,
                    vertical: isSmallScreen ? 4 : 4,
                  ),
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      dense: true,
                      title: Text(
                        "Loan Details",
                        style: TextStyle(
                          color: ColorsUtil.blueColorCart,
                          fontSize: 15.0,
                          fontFamily: CustomFonts.nunito,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: IconButton(
                        icon:
                            Icon(Icons.close, color: ColorsUtil.blueColorCart),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),

                    ListTile(
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      leading: Text(
                        "${loanData.customerName}",
                        style: TextStyle(
                          color: ColorsUtil.blueColorCart,
                          fontSize: 15.0,
                          fontFamily: CustomFonts.nunito,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Chip(
                        backgroundColor: ColorsUtil.marketCardContainer,
                        visualDensity: VisualDensity.compact,
                        label: Text(
                          "${loanData.rating}",
                          style: TextStyle(color: ColorsUtil.blueColorCart),
                        ),
                      ),
                    ),
                    //upper loayout
                    GridView.count(
                      childAspectRatio: isSmallScreen ? 1.5 : 2.3,
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      crossAxisCount: isSmallScreen ? 2 : 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        HeadingValueContainer(
                            heading: "Investment-Order ID",
                            value: "${loanData.investorId}"),
                        HeadingValueContainer(
                            heading: "Loan Disbursal Date",
                            value: loanData.startDate ?? ''),
                        HeadingValueContainer(
                            heading: "EMI Start Date",
                            value: loanData.startDate ?? ''),
                        HeadingValueContainer(
                            heading: "EMI End Date",
                            value: loanData.endDate ?? ''),
                      ],
                    ),

                    ListTile(
                      title: Text(
                        "Overview of Investment",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: ColorsUtil.blueColorCart,
                          fontFamily: CustomFonts.nunito,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    //lowerTableLayour
                    isSmallScreen
                        ? Column(
                            children: [
                              firstTableLayout,
                              SizedBox(
                                height: 8,
                              ),
                              secondTableLayout,
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Expanded(
                                  child: firstTableLayout,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: secondTableLayout,
                                ),
                              ]),

                    SizedBox(
                      height: 12,
                    ),

                    Divider(
                      height: 1,
                    ),

                    // ListTile(
                    //   title: Text(
                    //     "Overview of Investment",
                    //     style: TextStyle(
                    //       fontSize: 15.0,
                    //       fontFamily: CustomFonts.nunito,
                    //       fontWeight: FontWeight.w800,
                    //     ),
                    //   ),
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: DataTable(
                    //       headingRowColor: MaterialStateProperty.all(
                    //           Colors.blueGrey.shade50),
                    //       columns: [
                    //         "Date",
                    //         "Investor Loan\nTransaction ID",
                    //         "Amount Paid by Borrower\n",
                    //         "Principal\nReceived",
                    //         "Intrest\nReceived",
                    //         "Misc\nIncome",
                    //         "Monexo\nFees",
                    //         "Net\nAmount"
                    //       ].map((e) => DataColumn(label: Text(e))).toList(),
                    //       rows: loanInvestdata.repayments
                    //           .map((repayment) => DataRow(
                    //                   cells: [
                    //                 "${Utils.getFormattedDate(repayment.repaymentDate)}",
                    //                 "${repayment.transationId}",
                    //                 "${repayment.paidByBorrower}",
                    //                 "${repayment.principalReceived}",
                    //                 "${repayment.interest}",
                    //                 "${repayment.miscIncome}",
                    //                 "${repayment.monexoFee}",
                    //                 "${repayment.netAmount}"
                    //               ].map((e) => DataCell(Text(e))).toList()))
                    //           .toList()),
                    // ),

                    SizedBox(
                      height: 12,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class HeadingValueContainer extends StatelessWidget {
  final String heading;
  final String value;

  const HeadingValueContainer(
      {required this.heading, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      // margin: EdgeInsets.symmetric(
      //   horizontal: 16,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 13.0,
              color: ColorsUtil.blueColorCart,
              fontFamily: CustomFonts.nunito,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              color: ColorsUtil.blueColorCart,
              fontFamily: CustomFonts.nunito,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: ColorsUtil.marketCardContainer1),
          color: ColorsUtil.marketCardContainer),
    );
  }
}

class OutlinedTable extends StatelessWidget {
  final List<TableRowData> dataList;

  const OutlinedTable({required this.dataList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveWidget.isSmallScreen(context) ? null : 170,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Table(
        children: List.generate(
            dataList.length,
            (index) => TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      "${dataList[index].heading} :",
                      style: TextStyle(
                        color: ColorsUtil.blueColorCart,
                        fontSize: 14.0,
                        fontFamily: CustomFonts.nunito,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    dataList[index].value,
                    style: TextStyle(
                      color: ColorsUtil.blueColorCart,
                      fontSize: 15.0,
                      fontFamily: CustomFonts.nunito,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ])),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: ColorsUtil.marketCardContainer1),
          color: ColorsUtil.marketCardContainer),
    );
  }
}

class TableRowData {
  String heading;
  String value;

  TableRowData(this.heading, this.value);
}
