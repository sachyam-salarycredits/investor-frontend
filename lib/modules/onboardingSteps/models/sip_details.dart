import 'package:flutter/cupertino.dart';

class SipDetails {
  String? customerRecordId;
  String? type;
  String? customer;
  String? status;
  String? agent;
  String? bankAccount;
  String? mandate;
  String? id;
  String? object;
  int? created;
  bool? livemode;
  String? clientSecret;
  String? dateSubmitted;
  String? flow;
  SipNachDebit? nachDebit;
  SipRedirect? redirect;

  SipDetails(
      {this.customerRecordId,
      this.type,
      this.customer,
      this.status,
      this.agent,
      this.bankAccount,
      this.mandate,
      this.id,
      this.object,
      this.created,
      this.livemode,
      this.clientSecret,
      this.dateSubmitted,
      this.flow,
      this.nachDebit,
      this.redirect});

  SipDetails.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    type = json['type'] == null ? null : json['type'];
    customer = json['customer'] == null ? null : json['customer'];
    status = json['status'] == null ? null : json['status'];
    agent = json['agent'] == null ? null : json['agent'];
    bankAccount = json['bank_account'] == null ? null : json['bank_account'];
    mandate = json['mandate'] == null ? null : json['mandate'];
    id = json['id'] == null ? null : json['id'];
    object = json['object'] == null ? null : json['object'];
    created = json['created'] == null ? null : json['created'];
    livemode = json['livemode'] == null ? null : json['livemode'];
    clientSecret = json['client_secret'] == null ? null : json['client_secret'];
    dateSubmitted =
        json['date_submitted'] == null ? null : json['date_submitted'];
    flow = json['flow'] == null ? null : json['flow'];
    nachDebit = json['nach_debit'] != null
        ? new SipNachDebit.fromJson(json['nach_debit'])
        : null;
    redirect = json['redirect'] != null
        ? new SipRedirect.fromJson(json['redirect'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    data['type'] = this.type;
    data['customer'] = this.customer;
    data['status'] = this.status;
    data['agent'] = this.agent;
    data['bank_account'] = this.bankAccount;
    data['mandate'] = this.mandate;
    data['id'] = this.id;
    data['object'] = this.object;
    data['created'] = this.created;
    data['livemode'] = this.livemode;
    data['client_secret'] = this.clientSecret;
    data['date_submitted'] = this.dateSubmitted;
    data['flow'] = this.flow;
    if (this.nachDebit != null) {
      data['nach_debit'] = this.nachDebit!.toJson();
    }
    if (this.redirect != null) {
      data['redirect'] = this.redirect!.toJson();
    }
    return data;
  }
}

class SipNachDebit {
  String? customerRecordId;
  int? amountMaximum;
  String? dateFirstCollection;
  String? debtorAgentCode;
  String? debtorAccountName;
  String? debtorAccountNumber;
  String? debtorAccountType;
  String? frequency;
  String? categoryCode;
  String? creditorAgentCode;
  String? creditorUtilityCode;
  String? dateFinalCollection;
  String? debtorAgentMmbid;
  String? debtorEmail;
  String? reference1;
  String? reference2;
  String? variant;

  SipNachDebit({
    this.customerRecordId,
    this.amountMaximum,
    this.dateFirstCollection,
    this.debtorAgentCode,
    this.debtorAccountName,
    this.debtorAccountNumber,
    this.debtorAccountType,
    this.frequency,
    this.categoryCode,
    this.creditorAgentCode,
    this.creditorUtilityCode,
    this.dateFinalCollection,
    this.debtorAgentMmbid,
    this.debtorEmail,
    this.reference1,
    this.reference2,
    this.variant,
  });

  SipNachDebit.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    amountMaximum =
        json['amount_maximum'] == null ? null : json['amount_maximum'];
    dateFirstCollection = json['date_first_collection'] == null
        ? null
        : json['date_first_collection'];
    debtorAgentCode =
        json['debtor_agent_code'] == null ? null : json['debtor_agent_code'];
    debtorAccountName = json['debtor_account_name'] == null
        ? null
        : json['debtor_account_name'];
    debtorAccountNumber = json['debtor_account_number'] == null
        ? null
        : json['debtor_account_number'];
    debtorAccountType = json['debtor_account_type'] == null
        ? null
        : json['debtor_account_type'];
    frequency = json['frequency'] == null ? null : json['frequency'];
    categoryCode = json['category_code'] == null ? null : json['category_code'];
    creditorAgentCode = json['creditor_agent_code'] == null
        ? null
        : json['creditor_agent_code'];
    creditorUtilityCode = json['creditor_utility_code'] == null
        ? null
        : json['creditor_utility_code'];
    dateFinalCollection = json['date_final_collection'] == null
        ? null
        : json['date_final_collection'];
    debtorAgentMmbid =
        json['debtor_agent_mmbid'] == null ? null : json['debtor_agent_mmbid'];
    debtorEmail = json['debtor_email'] == null ? null : json['debtor_email'];
    reference1 = json['reference1'] == null ? null : json['reference1'];
    reference2 = json['reference2'] == null ? null : json['reference2'];
    variant = json['variant'] == null ? null : json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    data['amount_maximum'] = this.amountMaximum;
    data['date_first_collection'] = this.dateFirstCollection;
    data['debtor_agent_code'] = this.debtorAgentCode;
    data['debtor_account_name'] = this.debtorAccountName;
    data['debtor_account_number'] = this.debtorAccountNumber;
    data['debtor_account_type'] = this.debtorAccountType;
    data['frequency'] = this.frequency;
    data['category_code'] = this.categoryCode;
    data['creditor_agent_code'] = this.creditorAgentCode;
    data['creditor_utility_code'] = this.creditorUtilityCode;
    data['date_final_collection'] = this.dateFinalCollection;
    data['debtor_agent_mmbid'] = this.debtorAgentMmbid;
    data['debtor_email'] = this.debtorEmail;
    data['reference1'] = this.reference1;
    data['reference2'] = this.reference2;
    data['variant'] = this.variant;
    return data;
  }
}

class SipRedirect {
  String? customerRecordId;
  String? url;
  String? authMode;
  String? returnUrl;
  String? authAttempts;
  String? responseCode;
  String? shortUrl;
  SipResponse? response;

  SipRedirect(
      {this.customerRecordId,
      this.url,
      this.authMode,
      this.returnUrl,
      this.authAttempts,
      this.responseCode,
      this.shortUrl,
      this.response});

  SipRedirect.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    url = json['url'] == null ? null : json['url'];
    authMode = json['auth_mode'] == null ? null : json['auth_mode'];
    returnUrl = json['return_url'] == null ? null : json['return_url'];
    authAttempts = json['auth_attempts'] == null ? null : json['auth_attempts'];
    responseCode = json['response_code'] == null ? null : json['response_code'];
    shortUrl = json['short_url'] == null ? null : json['short_url'];
    response = json['response'] != null
        ? new SipResponse.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    data['url'] = this.url;
    data['auth_mode'] = this.authMode;
    data['return_url'] = this.returnUrl;
    data['auth_attempts'] = this.authAttempts;
    data['response_code'] = this.responseCode;
    data['short_url'] = this.shortUrl;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class SipResponse {
  String? customerRecordId;
  MandateResponse? mndtAccptResp;

  SipResponse({this.customerRecordId, this.mndtAccptResp});

  SipResponse.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    mndtAccptResp = json['mndtAccptResp'] != null
        ? new MandateResponse.fromJson(json['mndtAccptResp'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    data['mndtAccptResp'] = this.mndtAccptResp;
    return data;
  }
}

class MandateResponse {
  String? customerRecordId;
  UndrlygAccptncDtls? undrlygAccptncDtls;

  MandateResponse({
    this.customerRecordId,
    this.undrlygAccptncDtls,
  });

  MandateResponse.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    undrlygAccptncDtls = json['undrlygAccptncDtls'] != null
        ? new UndrlygAccptncDtls.fromJson(json['undrlygAccptncDtls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    if (this.undrlygAccptncDtls != null) {
      data['undrlygAccptncDtls'] = this.undrlygAccptncDtls!.toJson();
    }
    return data;
  }
}

class UndrlygAccptncDtls {
  String? customerRecordId;
  AccptncRslt? accptncRslt;

  UndrlygAccptncDtls({
    this.customerRecordId,
    this.accptncRslt,
  });

  UndrlygAccptncDtls.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    accptncRslt = json['accptncRslt'] != null
        ? new AccptncRslt.fromJson(json['accptncRslt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    if (this.accptncRslt != null) {
      data['accptncRslt'] = this.accptncRslt!.toJson();
    }
    return data;
  }
}

class AccptncRslt {
  String? customerRecordId;
  RjctRsn? rjctRsn;

  AccptncRslt({
    this.customerRecordId,
    this.rjctRsn,
  });

  AccptncRslt.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    rjctRsn =
        json['rjctRsn'] != null ? new RjctRsn.fromJson(json['rjctRsn']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    if (this.rjctRsn != null) {
      data['rjctRsn'] = this.rjctRsn!.toJson();
    }
    return data;
  }
}

class RjctRsn {
  String? customerRecordId;
  String? reasonCode;
  String? reasonDesc;
  String? rejectBy;

  RjctRsn(
      {this.customerRecordId, this.reasonCode, this.reasonDesc, this.rejectBy});

  RjctRsn.fromJson(Map<String, dynamic> json) {
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    reasonCode = json['reasonCode'] == null ? null : json['reasonCode'];
    reasonDesc = json['reasonDesc'] == null ? null : json['reasonDesc'];
    rejectBy = json['rejectBy'] == null ? null : json['rejectBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerRecordId'] = this.customerRecordId;
    data['reasonCode'] = this.reasonCode;
    data['reasonDesc'] = this.reasonDesc;
    data['rejectBy'] = this.rejectBy;
    return data;
  }
}

class OldSipDetail {
  int? amountMaximum;
  String? debtorAgentCode;
  String? debtorAccountName;
  String? debtorAccountNumber;
  String? debtorEmail;
  String? customerRecordId;
  String? monthDuration;
  String? authMode;
  String? presdatevalue;
  bool? sipEnable;

  OldSipDetail(
      {this.amountMaximum,
      this.debtorAgentCode,
      this.debtorAccountName,
      this.debtorAccountNumber,
      this.debtorEmail,
      this.customerRecordId,
      this.monthDuration,
      this.authMode,
      this.presdatevalue,
      this.sipEnable});

  OldSipDetail.fromJson(Map<String, dynamic> json) {
    amountMaximum =
        json['amount_maximum'] == null ? null : json['amount_maximum'];
    debtorAgentCode =
        json['debtor_agent_code'] == null ? null : json['debtor_agent_code'];
    debtorAccountName = json['debtor_account_name'] == null
        ? null
        : json['debtor_account_name'];
    debtorAccountNumber = json['debtor_account_number'] == null
        ? null
        : json['debtor_account_number'];
    debtorEmail = json['debtor_email'] == null ? null : json['debtor_email'];
    customerRecordId =
        json['customerRecordId'] == null ? null : json['customerRecordId'];
    monthDuration =
        json['month_duration'] == null ? null : json['month_duration'];
    authMode = json['authMode'] == null ? null : json['authMode'];
    presdatevalue =
        json['presdatevalue'] == null ? null : json['presdatevalue'];
    sipEnable = json['sipFlag'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount_maximum'] = this.amountMaximum;
    data['debtor_agent_code'] = this.debtorAgentCode;
    data['debtor_account_name'] = this.debtorAccountName;
    data['debtor_account_number'] = this.debtorAccountNumber;
    data['debtor_email'] = this.debtorEmail;
    data['customerRecordId'] = this.customerRecordId;
    data['month_duration'] = this.monthDuration;
    data['authMode'] = this.authMode;
    data['presdatevalue'] = this.presdatevalue;
    data['sipFlag'] = this.sipEnable;
    return data;
  }
}

class SipCreateResult {
  final SipDetails? sip;
  final String? errorMessage;

  SipCreateResult({this.sip, this.errorMessage});
}
