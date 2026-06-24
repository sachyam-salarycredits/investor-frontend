import 'package:Monexo/modules/marketplace/models/filter_data.dart';
import 'package:Monexo/modules/marketplace/models/primary_market_loan.dart';
import 'package:Monexo/supporting_file/api_calling.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class MarketPlaceProvider extends ChangeNotifier{

  final audioPlayer = AudioPlayer();
  late APICalling apiCalling;
  String _customerId = "";
  List<PrimaryMarketLoan>? primaryMarketLoans;

  List<PrimaryMarketLoan>? secondaryMarketLoans = [];

  List<PrimaryMarketLoan> primaryCartList = [];
  List<PrimaryMarketLoan> secondaryCartList = [];

  List<String> filterProducts = [];
  FilterDetails? filterData = FilterDetails();
  bool isPrimaryMarketSelected = true;
}