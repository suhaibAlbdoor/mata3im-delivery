import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'dart:async';

import 'Languages/arabic.dart';
import 'Languages/english.dart';
import 'Languages/french.dart';
import 'Languages/indonesian.dart';
import 'Languages/portuguese.dart';
import 'Languages/spanish.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
    'pt': portuguese(),
    'fr': french(),
    'id': indonesian(),
    'es': spanish(),
  };

  String get orders {
    return _localizedValues[locale.languageCode]['orders'];
  }

  String get home {
    return _localizedValues[locale.languageCode]['home'];
  }

  String get items {
    return _localizedValues[locale.languageCode]['items'];
  }

  String get markAsDelivered {
    return _localizedValues[locale.languageCode]['markAsDelivered'];
  }

  String get markAsPickedUp {
    return _localizedValues[locale.languageCode]['markAsPickedUp'];
  }

  String get acceptDelivery {
    return _localizedValues[locale.languageCode]['acceptDelivery'];
  }

  String get newDeliveryTask {
    return _localizedValues[locale.languageCode]['newDeliveryTask'];
  }

  String get orderInfo {
    return _localizedValues[locale.languageCode]['orderInfo'];
  }

  String get viewMap {
    return _localizedValues[locale.languageCode]['viewMap'];
  }

  String get viewProfile {
    return _localizedValues[locale.languageCode]['viewProfile'];
  }

  String get heyWhereAreYou {
    return _localizedValues[locale.languageCode]['heyWhereAreYou'];
  }

  String get restaurant {
    return _localizedValues[locale.languageCode]['restaurant'];
  }

  String get deliveredSuccessfully {
    return _localizedValues[locale.languageCode]['deliveredSuccessfully'];
  }

  String get thankYou {
    return _localizedValues[locale.languageCode]['thankYou'];
  }

  String get youDrived {
    return _localizedValues[locale.languageCode]['youDrived'];
  }

  String get yourEarnings {
    return _localizedValues[locale.languageCode]['yourEarnings'];
  }

  String get viewOrderInfo {
    return _localizedValues[locale.languageCode]['viewOrderInfo'];
  }

  String get viewEarnings {
    return _localizedValues[locale.languageCode]['viewEarnings'];
  }

  String get backToHome {
    return _localizedValues[locale.languageCode]['backToHome'];
  }

  String get englishh {
    return _localizedValues[locale.languageCode]['englishh'];
  }

  String get arabicc {
    return _localizedValues[locale.languageCode]['arabicc'];
  }

  String get frenchh {
    return _localizedValues[locale.languageCode]['frenchh'];
  }

  String get portuguesee {
    return _localizedValues[locale.languageCode]['portuguesee'];
  }

  String get indonesiann {
    return _localizedValues[locale.languageCode]['indonesiann'];
  }

  String get spanishh {
    return _localizedValues[locale.languageCode]['spanishh'];
  }

  String get language {
    return _localizedValues[locale.languageCode]['language'];
  }

  String get selectLanguage {
    return _localizedValues[locale.languageCode]['selectLanguage'];
  }

  String get save {
    return _localizedValues[locale.languageCode]['save'];
  }

  String get myProfile {
    return _localizedValues[locale.languageCode]['myProfile'];
  }

  String get personalDetails {
    return _localizedValues[locale.languageCode]['personalDetails'];
  }

  String get yourDeliveryTaskWillAppearHere {
    return _localizedValues[locale.languageCode]
        ['yourDeliveryTaskWillAppearHere'];
  }

  String get goOnline {
    return _localizedValues[locale.languageCode]['goOnline'];
  }

  String get goOffline {
    return _localizedValues[locale.languageCode]['goOffline'];
  }

  String get account {
    return _localizedValues[locale.languageCode]['account'];
  }

  String get youAreOffline {
    return _localizedValues[locale.languageCode]['youAreOffline'];
  }

  String get restro {
    return _localizedValues[locale.languageCode]['restro'];
  }

  String get emailAddress {
    return _localizedValues[locale.languageCode]['emailAddress'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get forgot {
    return _localizedValues[locale.languageCode]['forgot'];
  }

  String get signIn {
    return _localizedValues[locale.languageCode]['signIn'];
  }

  String get notRegisteredYet {
    return _localizedValues[locale.languageCode]['notRegisteredYet'];
  }

  String get registerNow {
    return _localizedValues[locale.languageCode]['registerNow'];
  }

  String get indianFood {
    return _localizedValues[locale.languageCode]['indianFood'];
  }

  String get chineseFood {
    return _localizedValues[locale.languageCode]['chineseFood'];
  }

  String get italianFood {
    return _localizedValues[locale.languageCode]['italianFood'];
  }

  String get available {
    return _localizedValues[locale.languageCode]['available'];
  }

  String get pending {
    return _localizedValues[locale.languageCode]['pending'];
  }

  String get approved {
    return _localizedValues[locale.languageCode]['approved'];
  }

  String get allItems {
    return _localizedValues[locale.languageCode]['allItems'];
  }

  String get reviews {
    return _localizedValues[locale.languageCode]['reviews'];
  }

  String get readAllReviewsAboutRestro {
    return _localizedValues[locale.languageCode]['readAllReviewsAboutRestro'];
  }

  String get wallet {
    return _localizedValues[locale.languageCode]['wallet'];
  }

  String get viewOrderMoneyTransactions {
    return _localizedValues[locale.languageCode]['viewOrderMoneyTransactions'];
  }

  String get support {
    return _localizedValues[locale.languageCode]['support'];
  }

  String get letUsKnow {
    return _localizedValues[locale.languageCode]['letUsKnow'];
  }

  String get shareApp {
    return _localizedValues[locale.languageCode]['shareApp'];
  }

  String get shareStoreApp {
    return _localizedValues[locale.languageCode]['shareStoreApp'];
  }

  String get changeLanguage {
    return _localizedValues[locale.languageCode]['changeLanguage'];
  }

  String get changeTheLocationOfApp {
    return _localizedValues[locale.languageCode]['changeTheLocationOfApp'];
  }

  String get viewRestroProfile {
    return _localizedValues[locale.languageCode]['viewRestroProfile'];
  }

  String get rated {
    return _localizedValues[locale.languageCode]['rated'];
  }

  String get customerOrder {
    return _localizedValues[locale.languageCode]['customerOrder'];
  }

  String get viewOrder {
    return _localizedValues[locale.languageCode]['viewOrder'];
  }

  String get writeYourMessage {
    return _localizedValues[locale.languageCode]['writeYourMessage'];
  }

  String get heyHowMuchTimeIt {
    return _localizedValues[locale.languageCode]['heyHowMuchTimeIt'];
  }

  String get willTakeToDeliver {
    return _localizedValues[locale.languageCode]['willTakeToDeliver'];
  }

  String get helloSirItWillTake {
    return _localizedValues[locale.languageCode]['helloSirItWillTake'];
  }

  String get aroundTwentyMinutes {
    return _localizedValues[locale.languageCode]['aroundTwentyMinutes'];
  }

  String get deliverymanOrder {
    return _localizedValues[locale.languageCode]['deliverymanOrder'];
  }

  String get hiHarshu {
    return _localizedValues[locale.languageCode]['hiHarshu'];
  }

  String get almostThereSir {
    return _localizedValues[locale.languageCode]['almostThereSir'];
  }

  String get deliverman {
    return _localizedValues[locale.languageCode]['deliverman'];
  }

  String get arrivingIn {
    return _localizedValues[locale.languageCode]['arrivingIn'];
  }

  String get callNow {
    return _localizedValues[locale.languageCode]['callNow'];
  }

  String get message {
    return _localizedValues[locale.languageCode]['message'];
  }

  String get changeImage {
    return _localizedValues[locale.languageCode]['changeImage'];
  }

  String get restaurantDetails {
    return _localizedValues[locale.languageCode]['restaurantDetails'];
  }

  String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }

  String get restroName {
    return _localizedValues[locale.languageCode]['restroName'];
  }

  String get registeredEmailAddress {
    return _localizedValues[locale.languageCode]['registeredEmailAddress'];
  }

  String get phoneNumber {
    return _localizedValues[locale.languageCode]['phoneNumber'];
  }

  String get restroAddress {
    return _localizedValues[locale.languageCode]['restroAddress'];
  }

  String get change {
    return _localizedValues[locale.languageCode]['change'];
  }

  String get restaurantWorkingHours {
    return _localizedValues[locale.languageCode]['restaurantWorkingHours'];
  }

  String get openingTime {
    return _localizedValues[locale.languageCode]['openingTime'];
  }

  String get closingTime {
    return _localizedValues[locale.languageCode]['closingTime'];
  }

  String get preOrderAvailable {
    return _localizedValues[locale.languageCode]['preOrderAvailable'];
  }

  String get deliveryOptions {
    return _localizedValues[locale.languageCode]['deliveryOptions'];
  }

  String get approxDeliveryTiming {
    return _localizedValues[locale.languageCode]['approxDeliveryTiming'];
  }

  String get minimumOrderValue {
    return _localizedValues[locale.languageCode]['minimumOrderValue'];
  }

  String get deliveryCharges {
    return _localizedValues[locale.languageCode]['deliveryCharges'];
  }

  String get paymentMethods {
    return _localizedValues[locale.languageCode]['paymentMethods'];
  }

  String get updateRestroInfo {
    return _localizedValues[locale.languageCode]['updateRestroInfo'];
  }

  String get allReviews {
    return _localizedValues[locale.languageCode]['allReviews'];
  }

  String get governmentId {
    return _localizedValues[locale.languageCode]['governmentId'];
  }

  String get uploadNow {
    return _localizedValues[locale.languageCode]['uploadNow'];
  }

  String get drivingLicense {
    return _localizedValues[locale.languageCode]['drivingLicense'];
  }

  String get document {
    return _localizedValues[locale.languageCode]['document'];
  }

  String get weAreHappyTo {
    return _localizedValues[locale.languageCode]['weAreHappyTo'];
  }

  String get hearFromYou {
    return _localizedValues[locale.languageCode]['hearFromYou'];
  }

  String get callUs {
    return _localizedValues[locale.languageCode]['callUs'];
  }

  String get mailUs {
    return _localizedValues[locale.languageCode]['mailUs'];
  }

  String get sendYourMessage {
    return _localizedValues[locale.languageCode]['sendYourMessage'];
  }

  String get fullName {
    return _localizedValues[locale.languageCode]['fullName'];
  }

  String get contactNumber {
    return _localizedValues[locale.languageCode]['contactNumber'];
  }

  String get yourMessage {
    return _localizedValues[locale.languageCode]['yourMessage'];
  }

  String get submitNow {
    return _localizedValues[locale.languageCode]['submitNow'];
  }

  String get uploadItemImage {
    return _localizedValues[locale.languageCode]['uploadItemImage'];
  }

  String get ratioShouldBe {
    return _localizedValues[locale.languageCode]['ratioShouldBe'];
  }

  String get itemName {
    return _localizedValues[locale.languageCode]['itemName'];
  }

  String get chooseItemCategory {
    return _localizedValues[locale.languageCode]['chooseItemCategory'];
  }

  String get shortDescription {
    return _localizedValues[locale.languageCode]['shortDescription'];
  }

  String get priceInDollars {
    return _localizedValues[locale.languageCode]['priceInDollars'];
  }

  String get addSpecifications {
    return _localizedValues[locale.languageCode]['addSpecifications'];
  }

  String get addTitle {
    return _localizedValues[locale.languageCode]['addTitle'];
  }

  String get options {
    return _localizedValues[locale.languageCode]['options'];
  }

  String get moreOptions {
    return _localizedValues[locale.languageCode]['moreOptions'];
  }

  String get customerCanChoose {
    return _localizedValues[locale.languageCode]['customerCanChoose'];
  }

  String get onlyOneOption {
    return _localizedValues[locale.languageCode]['onlyOneOption'];
  }

  String get multipleOptions {
    return _localizedValues[locale.languageCode]['multipleOptions'];
  }

  String get addMoreSpecifications {
    return _localizedValues[locale.languageCode]['addMoreSpecifications'];
  }

  String get addItem {
    return _localizedValues[locale.languageCode]['addItem'];
  }

  String get order {
    return _localizedValues[locale.languageCode]['order'];
  }

  String get orderedItems {
    return _localizedValues[locale.languageCode]['orderedItems'];
  }

  String get amount {
    return _localizedValues[locale.languageCode]['amount'];
  }

  String get totalAmount {
    return _localizedValues[locale.languageCode]['totalAmount'];
  }

  String get taxes {
    return _localizedValues[locale.languageCode]['taxes'];
  }

  String get payViaCreditCard {
    return _localizedValues[locale.languageCode]['payViaCreditCard'];
  }

  String get orderedBy {
    return _localizedValues[locale.languageCode]['orderedBy'];
  }

  String get messageNow {
    return _localizedValues[locale.languageCode]['messageNow'];
  }

  String get deliverymanAssigned {
    return _localizedValues[locale.languageCode]['deliverymanAssigned'];
  }

  String get notAssignedYet {
    return _localizedValues[locale.languageCode]['notAssignedYet'];
  }

  String get acceptOrderToAssign {
    return _localizedValues[locale.languageCode]['acceptOrderToAssign'];
  }

  String get acceptOrder {
    return _localizedValues[locale.languageCode]['acceptOrder'];
  }

  String get viewInfo {
    return _localizedValues[locale.languageCode]['viewInfo'];
  }

  String get orderReadyToDelivered {
    return _localizedValues[locale.languageCode]['orderReadyToDelivered'];
  }

  String get pastOrders {
    return _localizedValues[locale.languageCode]['pastOrders'];
  }

  String get cod {
    return _localizedValues[locale.languageCode]['cod'];
  }

  String get delivered {
    return _localizedValues[locale.languageCode]['delivered'];
  }

  String get accepted {
    return _localizedValues[locale.languageCode]['accepted'];
  }

  String get online {
    return _localizedValues[locale.languageCode]['online'];
  }

  String get newOrders {
    return _localizedValues[locale.languageCode]['newOrders'];
  }

  String get addMoney {
    return _localizedValues[locale.languageCode]['addMoney'];
  }

  String get availableBalance {
    return _localizedValues[locale.languageCode]['availableBalance'];
  }

  String get cardNumber {
    return _localizedValues[locale.languageCode]['cardNumber'];
  }

  String get cardName {
    return _localizedValues[locale.languageCode]['cardName'];
  }

  String get expireMonth {
    return _localizedValues[locale.languageCode]['expireMonth'];
  }

  String get resend {
    return _localizedValues[locale.languageCode]['resend'];
  }

  String get verifyNow {
    return _localizedValues[locale.languageCode]['verifyNow'];
  }

  String get addVerificationCode {
    return _localizedValues[locale.languageCode]['addVerificationCode'];
  }

  String get verification {
    return _localizedValues[locale.languageCode]['verification'];
  }

  String get expireYear {
    return _localizedValues[locale.languageCode]['expireYear'];
  }

  String get proceed {
    return _localizedValues[locale.languageCode]['proceed'];
  }

  String get enterAmountToAdd {
    return _localizedValues[locale.languageCode]['enterAmountToAdd'];
  }

  String get sendToBank {
    return _localizedValues[locale.languageCode]['sendToBank'];
  }

  String get accountHolderName {
    return _localizedValues[locale.languageCode]['accountHolderName'];
  }

  String get bankName {
    return _localizedValues[locale.languageCode]['bankName'];
  }

  String get branchCode {
    return _localizedValues[locale.languageCode]['branchCode'];
  }

  String get accountNumber {
    return _localizedValues[locale.languageCode]['accountNumber'];
  }

  String get enterAmountToTransfer {
    return _localizedValues[locale.languageCode]['enterAmountToTransfer'];
  }

  String get earnings {
    return _localizedValues[locale.languageCode]['earnings'];
  }

  String get recent {
    return _localizedValues[locale.languageCode]['recent'];
  }

  String get registerNowToContinue {
    return _localizedValues[locale.languageCode]['registerNowToContinue'];
  }

  String get weWillSendVerification {
    return _localizedValues[locale.languageCode]['weWillSendVerification'];
  }

  String get givenNumberToVerify {
    return _localizedValues[locale.languageCode]['givenNumberToVerify'];
  }

  String get delivery {
    return _localizedValues[locale.languageCode]['delivery'];
  }

  String get newUser {
    return _localizedValues[locale.languageCode]['newUser'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'id', 'pt', 'ar', 'fr', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
