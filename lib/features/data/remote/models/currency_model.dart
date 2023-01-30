import 'package:chegg/features/domain/entities/currency_rate_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/provider_entity.dart';
import '../../../domain/entities/user_entity.dart';

   class CurrencyRateModel extends CurrencyRateEntity{
  Data? _data;

  CurrencyRateModel({Data? data}) {
  if (data != null) {
  this._data = data;
  }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  CurrencyRateModel.fromJson(Map<String, dynamic> json) {
  _data = json['data'] != null ?
  new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this._data != null) {
  data['data'] = this._data!.toJson();
  }
  return data;
  }
  }

  class Data {
    double? _aUD;
  double? _bGN;
  double? _bRL;
  double? _cAD;
  double? _cHF;
  double? _cNY;
  double? _cZK;
  double? _dKK;
  double? _eUR;
  double? _gBP;
  double? _hKD;
  double? _hRK;
  double? _hUF;
  double? _iDR;
  double? _iLS;
  double? _iNR;
  double? _iSK;
  double? _jPY;
  double? _kRW;
  double? _mXN;
  double? _mYR;
  double? _nOK;
  double? _nZD;
  double? _pHP;
  double? _pLN;
  double? _rON;
  double? _rUB;
  double? _sEK;
  double? _sGD;
  double? _tHB;
  double? _tRY;
  double? _uSD;
  double? _zAR;

  Data(
  {double? aUD,
  double? bGN,
  double? bRL,
  double? cAD,
  double? cHF,
  double? cNY,
  double? cZK,
  double? dKK,
  double? eUR,
  double? gBP,
  double? hKD,
  double? hRK,
  double? hUF,
  double? iDR,
  double? iLS,
  double? iNR,
  double? iSK,
  double? jPY,
  double? kRW,
  double? mXN,
  double? mYR,
  double? nOK,
  double? nZD,
  double? pHP,
  double? pLN,
  double? rON,
  double? rUB,
  double? sEK,
  double? sGD,
  double? tHB,
  double? tRY,
  double? uSD,
  double? zAR}) {
  if (aUD != null) {
  this._aUD = aUD;
  }
  if (bGN != null) {
  this._bGN = bGN;
  }
  if (bRL != null) {
  this._bRL = bRL;
  }
  if (cAD != null) {
  this._cAD = cAD;
  }
  if (cHF != null) {
  this._cHF = cHF;
  }
  if (cNY != null) {
  this._cNY = cNY;
  }
  if (cZK != null) {
  this._cZK = cZK;
  }
  if (dKK != null) {
  this._dKK = dKK;
  }
  if (eUR != null) {
  this._eUR = eUR;
  }
  if (gBP != null) {
  this._gBP = gBP;
  }
  if (hKD != null) {
  this._hKD = hKD;
  }
  if (hRK != null) {
  this._hRK = hRK;
  }
  if (hUF != null) {
  this._hUF = hUF;
  }
  if (iDR != null) {
  this._iDR = iDR;
  }
  if (iLS != null) {
  this._iLS = iLS;
  }
  if (iNR != null) {
  this._iNR = iNR;
  }
  if (iSK != null) {
  this._iSK = iSK;
  }
  if (jPY != null) {
  this._jPY = jPY;
  }
  if (kRW != null) {
  this._kRW = kRW;
  }
  if (mXN != null) {
  this._mXN = mXN;
  }
  if (mYR != null) {
  this._mYR = mYR;
  }
  if (nOK != null) {
  this._nOK = nOK;
  }
  if (nZD != null) {
  this._nZD = nZD;
  }
  if (pHP != null) {
  this._pHP = pHP;
  }
  if (pLN != null) {
  this._pLN = pLN;
  }
  if (rON != null) {
  this._rON = rON;
  }
  if (rUB != null) {
  this._rUB = rUB;
  }
  if (sEK != null) {
  this._sEK = sEK;
  }
  if (sGD != null) {
  this._sGD = sGD;
  }
  if (tHB != null) {
  this._tHB = tHB;
  }
  if (tRY != null) {
  this._tRY = tRY;
  }
  if (uSD != null) {
  this._uSD = uSD;
  }
  if (zAR != null) {
  this._zAR = zAR;
  }
  }

  double? get aUD => _aUD;
  set aUD(double? aUD) => _aUD = aUD;
  double? get bGN => _bGN;
  set bGN(double? bGN) => _bGN = bGN;
  double? get bRL => _bRL;
  set bRL(double? bRL) => _bRL = bRL;
  double? get cAD => _cAD;
  set cAD(double? cAD) => _cAD = cAD;
  double? get cHF => _cHF;
  set cHF(double? cHF) => _cHF = cHF;
  double? get cNY => _cNY;
  set cNY(double? cNY) => _cNY = cNY;
  double? get cZK => _cZK;
  set cZK(double? cZK) => _cZK = cZK;
  double? get dKK => _dKK;
  set dKK(double? dKK) => _dKK = dKK;
  double? get eUR => _eUR;
  set eUR(double? eUR) => _eUR = eUR;
  double? get gBP => _gBP;
  set gBP(double? gBP) => _gBP = gBP;
  double? get hKD => _hKD;
  set hKD(double? hKD) => _hKD = hKD;
  double? get hRK => _hRK;
  set hRK(double? hRK) => _hRK = hRK;
  double? get hUF => _hUF;
  set hUF(double? hUF) => _hUF = hUF;
  double? get iDR => _iDR;
  set iDR(double? iDR) => _iDR = iDR;
  double? get iLS => _iLS;
  set iLS(double? iLS) => _iLS = iLS;
  double? get iNR => _iNR;
  set iNR(double? iNR) => _iNR = iNR;
  double? get iSK => _iSK;
  set iSK(double? iSK) => _iSK = iSK;
  double? get jPY => _jPY;
  set jPY(double? jPY) => _jPY = jPY;
  double? get kRW => _kRW;
  set kRW(double? kRW) => _kRW = kRW;
  double? get mXN => _mXN;
  set mXN(double? mXN) => _mXN = mXN;
  double? get mYR => _mYR;
  set mYR(double? mYR) => _mYR = mYR;
  double? get nOK => _nOK;
  set nOK(double? nOK) => _nOK = nOK;
  double? get nZD => _nZD;
  set nZD(double? nZD) => _nZD = nZD;
  double? get pHP => _pHP;
  set pHP(double? pHP) => _pHP = pHP;
  double? get pLN => _pLN;
  set pLN(double? pLN) => _pLN = pLN;
  double? get rON => _rON;
  set rON(double? rON) => _rON = rON;
  double? get rUB => _rUB;
  set rUB(double? rUB) => _rUB = rUB;
  double? get sEK => _sEK;
  set sEK(double? sEK) => _sEK = sEK;
  double? get sGD => _sGD;
  set sGD(double? sGD) => _sGD = sGD;
  double? get tHB => _tHB;
  set tHB(double? tHB) => _tHB = tHB;
  double? get tRY => _tRY;
  set tRY(double? tRY) => _tRY = tRY;
  double? get uSD => _uSD;
  set uSD(double? uSD) => _uSD = uSD;
  double? get zAR => _zAR;
  set zAR(double? zAR) => _zAR = zAR;

  Data.fromJson(Map<String, dynamic> json) {
    _aUD = double.tryParse(json['AUD'].toString()) ;
    _bGN = double.tryParse(json['BGN'].toString());
    _bRL = double.tryParse( json['BRL'].toString());
    _cAD = double.tryParse( json['CAD'].toString());
    _cHF = double.tryParse( json['CHF'].toString());
    _cNY = double.tryParse( json['CNY'].toString());
    _cZK = double.tryParse( json['CZK'].toString());
    _dKK = double.tryParse( json['DKK'].toString());
    _eUR = double.tryParse( json['EUR'].toString());
    _gBP = double.tryParse( json['GBP'].toString());
    _hKD = double.tryParse( json['HKD'].toString());
    _hRK = double.tryParse( json['HRK'].toString());
    _hUF = double.tryParse( json['HUF'].toString());
    _iDR = double.tryParse( json['IDR'].toString());
    _iLS = double.tryParse( json['ILS'].toString());
    _iNR = double.tryParse( json['INR'].toString());
    _iSK = double.tryParse( json['ISK'].toString());
    _jPY = double.tryParse( json['JPY'].toString());
    _kRW = double.tryParse( json['KRW'].toString());
    _mXN = double.tryParse( json['MXN'].toString());
    _mYR = double.tryParse( json['MYR'].toString());
    _nOK = double.tryParse( json['NOK'].toString());
    _nZD = double.tryParse( json['NZD'].toString());
    _pHP = double.tryParse( json['PHP'].toString());
    _pLN = double.tryParse( json['PLN'].toString());
    _rON = double.tryParse( json['RON'].toString());
    _rUB = double.tryParse( json['RUB'].toString());
    _sEK = double.tryParse( json['SEK'].toString());
    _sGD = double.tryParse( json['SGD'].toString());
    _tHB = double.tryParse( json['THB'].toString());
    _tRY = double.tryParse( json['TRY'].toString());
    _uSD = double.tryParse( (json['USD']).toString());
    _zAR = double.tryParse( json['ZAR'].toString());
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['AUD'] = this._aUD;
  data['BGN'] = this._bGN;
  data['BRL'] = this._bRL;
  data['CAD'] = this._cAD;
  data['CHF'] = this._cHF;
  data['CNY'] = this._cNY;
  data['CZK'] = this._cZK;
  data['DKK'] = this._dKK;
  data['EUR'] = this._eUR;
  data['GBP'] = this._gBP;
  data['HKD'] = this._hKD;
  data['HRK'] = this._hRK;
  data['HUF'] = this._hUF;
  data['IDR'] = this._iDR;
  data['ILS'] = this._iLS;
  data['INR'] = this._iNR;
  data['ISK'] = this._iSK;
  data['JPY'] = this._jPY;
  data['KRW'] = this._kRW;
  data['MXN'] = this._mXN;
  data['MYR'] = this._mYR;
  data['NOK'] = this._nOK;
  data['NZD'] = this._nZD;
  data['PHP'] = this._pHP;
  data['PLN'] = this._pLN;
  data['RON'] = this._rON;
  data['RUB'] = this._rUB;
  data['SEK'] = this._sEK;
  data['SGD'] = this._sGD;
  data['THB'] = this._tHB;
  data['TRY'] = this._tRY;
  data['USD'] = this._uSD;
  data['ZAR'] = this._zAR;
  return data;
  }
  }
