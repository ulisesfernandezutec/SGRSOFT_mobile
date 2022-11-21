import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sgrsoft/data/const/netconsts.dart';

class PolylineMap extends StatefulWidget {
  static const routeName = '/polyline_map';

  const PolylineMap({super.key});
  @override
  _PolylineMapState createState() => _PolylineMapState();
}

class _PolylineMapState extends State<PolylineMap> {
  late GoogleMapController mapController;

  static const double _originLatitude = -34.738538,
      _originLongitude = -56.226759;
  static const double _destLatitude = -34.894089, _destLongitude = -56.186176;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late String googleAPiKey;

  LatLng origen = const LatLng(-34.734501, -56.229366);
  LatLng destino = const LatLng(-34.725260, -56.201385);

  @override
  void initState() {
    super.initState();
    log('initState()');
    if (kDebugMode) {
      print('initState()');
    }
    setState(() {
      googleAPiKey = NetConts.getGoogleAPIKey();
    });

    /// origin marker
    _addMarker(const LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(const LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();

    List<PointLatLng> result = polylinePoints.decodePolyline(
        "ja`oEhbbvI?@@??@?@?@?@?@@@?@GVGPOb@w@nAmBzC{GtKQZsAxBGJW`@oCpE_CzDaA|A[l@w@`BELg@xAUr@ERQp@CHS|@AHYdB[vCWxBGj@M`Be@tE[hDGh@MtAe@~EU|BCh@?`@APCV?FIdAMbAKv@If@E`@C`@Gt@IjAIl@O`AO|@On@Sr@Yv@Sd@KVKRS^W^[b@c@j@c@f@i@h@QNURo@d@u@b@k@V_@Ne@Ro@PSD[Du@J{Fp@sI`Ae@F_Iz@a@Fc@DiBR{Gx@c@DaD^u@J{Fn@s@H_Eb@a@FYBI@kN~ASBOBO@oH|@wEf@sC\\}Db@mCZ}C\\g@FG@yGv@oBRqBViD^cHv@oFn@c@DcFj@gFl@cD\\q@HqDb@M@mFn@e@Fu@HaBNo@Bq@BE@aA@}HLo@@iGHqDFsDFc@?sDF_EFuFH_HJ}DFwEHwHJc@@sDFwEFc@@wEHyDFuFH}DDcCDcCDU@sDHwFLmOT{CDK@oCDkB?M?k@Au@Ag@Co@E[CiAKuPaBgAKaAMqD[[EG?aMmAE?_Iw@qEc@gKaAc@EqEa@iGo@oHs@qCYE?oKcAa@E{AMyBUc@EyFi@c@CmCWiBSc@E{LkA}BUSAwAOcJ{@EA[CgMkAqBSgAK_Iw@uAOcDWc@Ec@Ec@Ea@Ec@Ec@Gc@EC?_@Ea@Ec@EYCIAc@Ec@Ea@Ec@Ec@EA?a@Ec@Ea@Gc@Ec@Ec@Ec@EIAWCc@EUCMAc@Ec@Ea@Ec@CWCKAc@Ec@GMAUCa@CKAWCE?M?O?G?[?K?W@Q@QBc@Bc@DO@SD_@DA@c@FK@UD]DE@C?aHdAKBa@DoSpCsC`@iG~@sBZI@q@JuAVUFgAPg@HE@MD{Bf@c@JcE`AuCp@yA^}EhAa@Jc@JaEbAQDQDcAVo@No@Nk@JqFpAWFcCn@s@PiCn@a@JmDx@aB`@aCj@yItBiMzC_OnDa@JgB`@i@L_FjAoEdA_@HyD`AWFk@Nc@JqFrAuCr@UFmDx@cAVmDz@WFIBoEbA}@RoAVmAR{@Lo@FmBd@{@N}Ch@cLlBc@HI@qHlA{F`Ak@J{HpAc@FuF~@a@Hc@H_BXuF~@yGhA{AVcGbAcAP_Df@iBZa@H}FbAcCb@cKbB{Dn@oDl@iBZeARc@Ha@FiMrBc@HsF`AiBXiBXc@HiBXeAPyGdAa@HaANA?WDcIzAeAPyGhA{HpAgBZcIlAkAR}@PsA\\YF]Li@VqF|BwB~@k@VaAb@cDvAiJ~DcCfA_@NeFzBa@P_@NqLfF}BbA_@PyB~@uAl@s@Z{IzDaAb@{Ap@oKvEaA`@_IlDGBcCdAkEjBu@`@o@\\OHgAt@uDvCs@j@mM|JaAt@mPnMqB|A_Av@uCxByAjAqAjAq@n@A?_E|DmBlB{AzAqGtGYZeBdBmDpDeGhG[ZsArAu@t@mFlFu@v@iChCCDeCfCYZw@v@uFzF[ZcDfDq@r@qEdFuBrBOL_JvI}DxDo@l@_@Xw@f@WNiAn@aAd@WHg@Ps@R_@Lm@N_Dd@yC`@sOpBuAPyC^kEj@wAPYBwGz@yG|@QBoDb@_D^qDb@gEj@c@DmC^a@DmMbBsEj@mDb@[DmBVYDsEl@aD`@sEj@cJfAcEf@oNfBQBI@]DyAPoIfAc@FaEh@kH~@cJfAoGx@c@FsEl@oANgANcCZeJhAc@FG@}JpAaGt@SBiIfAkALeALa@DA?aBPiM~@s@DmGb@sHh@cF^{In@cBLqBViAViHbBODeP~DqA\\eEfAuBj@cAT_@FuGbBgP`Ec@JuHlBiBd@kEfAoG`BiP~DaFnAc@Ja@JeAVwIvBiBf@sBf@}D`Aa@La@JmDz@a@JeAVqCr@aCl@a@Ja@L{JfCOD{@RmBb@[FwIxBiEfAqEfAy@Nk@HO@u@DaB?wCBm@?cE@Y?}B@mF?eE@wDDk@@mAAsE?C?qAA}GKgBAE?oEGiBEAAaDEgCC_DGqACu@AQ?cFEC?uDEoCGyBCcCE]AuACoBEe@Au@?GACAKAe@EYE]EGAE?GAS?A??AA?AAA?A?A?A?A?A@A?A@A@A??@A?E?I?M?S@A?oAB[?I@E@qBEs@?o@@qBJo@Fw@Jo@L_@HkAXy@TaA\\_A`@cAh@q@`@yAdAEB]TyBxAoHdF}@l@]V{AbA]V_@TgFnD_PxKkAx@_@TyBzAmAz@}EfDoCjBsA|@SL]VeD|BgD|BoAz@oA|@gD|BiAv@m@b@KHcCbBiBlA_@VC@A@yCnB{@d@y@`@eA`@KDu@Tu@RoAX[F[DUB[D]Bu@D}AHcIVc@BkBFuELmSp@iFNwFP{FPoADo@By@DI?}@BgCHuENiBHi@By@ByADeCHqGPuNd@qNb@W?_ENkBFmCJyMb@I@E?gK\\aBDqELO@kBD{ADs@Bc@BaADsCHgABC?mEPqBHkADyFT}DHqDNgDHM?c@@g@@kBHgEL_DHcCHsBJq@BoEJaFL_ADgBHoADw@Bs@Bc@B_BFaFNyDLaBFgFLqBH}BDcCJgAD_CLSBO@UBC@WBi@Hm@Nu@PqBh@kAZgAXSH_@Js@Tu@Ri@L_Dz@oA\\cCn@mCv@cAVA@aAXqA^kBf@mCr@MBeBf@a@Jy@T_Bd@sA`@A?a@L[JiAX[Hi@LC@kAXWF_AXC?kD|@c@J_Bb@g@NODmBf@sBh@aAV_FpA}I|BmG~AeFrAiEhAiCr@e@LiBf@iBb@aB`@{@Vi@NaAVC@]Hc@LE@_AXaAXeAVsBf@cDz@[JuBh@sBf@_ATg@Nu@RUFc@JSFq@N{Bl@eBb@o@PaHjBE@_AVe@LcBb@_B`@E@y@TKB}@TgA\\A?oAZ{Bl@qCr@wCx@o@Pw@ReDz@_Bb@}@TsIzB]HuL|CcOzDg@NoBh@eCn@cCl@q@Pg@Ni@NMBsA\\q@PqA^e@Lu@TmCr@s@P{Bl@qBd@w@T]Jg@No@Pc@JsEnAqU`Ga@Ja@LkD`Aa@L]JC?a@JgB`@eAVqFtAa@La@JeCr@gAVa@JoAZeFtAmBf@mFxAG@[HaB`@iAXA?kBd@]Je@N}@Zo@Ts@V{@\\_@P_@P{@^q@\\cAh@{@f@a@Vu@d@c@VkAx@yCtBe@\\y@j@qBtAA@]V}B~Ay@l@y@l@MHi@`@s@f@wA`A_Ar@i@^EBWRe@^iAx@w@j@i@^m@`@cExCMHeBpACBm@b@oAx@e@\\yCpBoBtAq@d@wDlCy@l@]T_@V]T]V]Tk@`@OL_@Vi@`@_@Z_@ZgAv@aAr@IFkCjByAbA}@l@]V_BdAuCrB[R_@Vy@l@{@n@_Ar@aC`Bo@d@YPiAv@yAdAWPq@h@{AfAmAx@WRk@`@KHIHs@j@mCfBg@^gCdBq@d@[Rc@\\wCzBwA`AiCfBqDdCiAx@_H~EqHlF]VkCjBcCdB}@l@mDbCsEdDeKlHuGpEiHlFkFpDmDfCaBjAu@h@uDjCiM~IyCvBuCrBoA|@eBpAWR_@R]TIFs@d@{@n@k@b@iA|@WRc@Z}@j@yAbAeAr@qBvA]TwCrBcGpEuDhC]VwCrBWREBuCtB]VOJiD|ByAbA]T]Vi@^_Ap@oBtA_EtCsDfC]VuBxAmCpBaDzBSLIHgAt@oA|@y@j@uA`Ae@ZyAbAmA~@{B|AuCrBwAhAuBdB[V]XUPOL]Vw@r@iFxFYZsC|CiJbKSR_IvI}BfCGFkFzFgDrDSR_ChCkCvCoArAyBbCKL[Zs@x@]^YZkCtC[\\uAxAsBzB[ZIHwC`Dy@|@i@l@YZkBrBaAdA_AdA[Zu@x@YZ_@`@aAdA}@bAw@x@YZCBmApAYZuBxByA~A}@`A_BdBSTSR[\\iBpB[\\QP}A`ByCfDUVo@v@ST_A`AiAlAsAzAc@f@w@x@e@d@UTo@r@ORY\\MLQROPWTq@j@}BvBmCdCiAdA_@^w@t@SPYVuBhBKJmBdBSRoAfAgC~BC@sChCw@r@aFtEeB|AoBdBUT]XwBpBwAnAk@h@y@x@MJML[ZMLiAdAqAjAu@n@}@r@{@t@qAlAy@t@A@YViAdAo@j@{BrB{@|@_@^[V[ZA@YV[XCBq@j@g@b@u@l@k@j@e@`@[X_@Ze@b@i@f@g@d@u@p@wClCwDjD_@\\GDq@l@q@n@}DlDgAbAYV]\\[XA?[ZGFs@n@e@d@yApAqAjAqAlA}@x@u@p@k@h@{ClCMJMLqBjBgEzDqAjAiC`CeA`AaBvAwBnBmD`D{DnD}AxAo@l@]ZYXGH[\\Y\\m@t@iB~BqBpCcApAuEnGg@r@_BvBaAnA_AnAk@x@Y\\UZQRk@p@GJUX[b@A@{@jAc@l@e@n@UZU^Yd@KNQVy@bAc@d@e@j@_AlAe@n@QVy@lA_BvB]f@c@j@i@p@gAtAgB`CY\\W^q@|@Y`@gAzA[`@Y^a@d@{@|@[Z_@\\qB~AyAfAqDpCoDrCuB`B{@p@oBzAiA~@qDpCy@n@cClBQLcCfBqAdA_Ax@eA|@c@^_@\\e@b@oAjAWV_@`@sAlA{BrB]\\]XmAjAeExDq@n@cA~@[XYVmAhAA@q@n@WVu@p@wBnBaA|@wApAuApA{AtAiAbAaCzB[Va@\\e@`@WRa@Zg@^k@`@kAz@_@Ve@\\e@XIHKHa@Xa@XoBtAeIvFaFhDeD|BkAx@yB|AyCtB}@n@yAbAc@ZkBpAo@d@uBxA_BdASLa@V]Rg@Vs@^e@Ri@Vc@Pa@PmAf@s@X_A`@q@Xo@XcBp@{@^eCdAC@oAh@uAj@uB|@_A`@q@Z");
    if (kDebugMode) {
      print(result);
    }
    void testDecodeEncodedPolyline(String encoded) {
      List<PointLatLng> poly = [];
      int index = 0, len = encoded.length;
      int lat = 0, lng = 0;

      while (index < len) {
        int b, shift = 0, result = 0;
        do {
          b = encoded.codeUnitAt(index++) - 63;
          result |= (b & 0x1f) << shift;
          shift += 5;
        } while (b >= 0x20);
        int aa = ~(result >> 1);
        int bb = (result >> 1);
        int cc = (result & 1);
        bool dd = (result & 1) != 0;

        int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
        lat += dlat;

        shift = 0;
        result = 0;
        do {
          b = encoded.codeUnitAt(index++) - 63;
          result |= (b & 0x1f) << shift;
          shift += 5;
        } while (b >= 0x20);
        int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        PointLatLng p =
            new PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
        poly.add(p);
      }
    }

    testDecodeEncodedPolyline(
        "ja`oEhbbvI?@@??@?@?@?@?@@@?@GVGPOb@w@nAmBzC{GtKQZsAxBGJW`@oCpE_CzDaA|A[l@w@`BELg@xAUr@ERQp@CHS|@AHYdB[vCWxBGj@M`Be@tE[hDGh@MtAe@~EU|BCh@?`@APCV?FIdAMbAKv@If@E`@C`@Gt@IjAIl@O`AO|@On@Sr@Yv@Sd@KVKRS^W^[b@c@j@c@f@i@h@QNURo@d@u@b@k@V_@Ne@Ro@PSD[Du@J{Fp@sI`Ae@F_Iz@a@Fc@DiBR{Gx@c@DaD^u@J{Fn@s@H_Eb@a@FYBI@kN~ASBOBO@oH|@wEf@sC\\}Db@mCZ}C\\g@FG@yGv@oBRqBViD^cHv@oFn@c@DcFj@gFl@cD\\q@HqDb@M@mFn@e@Fu@HaBNo@Bq@BE@aA@}HLo@@iGHqDFsDFc@?sDF_EFuFH_HJ}DFwEHwHJc@@sDFwEFc@@wEHyDFuFH}DDcCDcCDU@sDHwFLmOT{CDK@oCDkB?M?k@Au@Ag@Co@E[CiAKuPaBgAKaAMqD[[EG?aMmAE?_Iw@qEc@gKaAc@EqEa@iGo@oHs@qCYE?oKcAa@E{AMyBUc@EyFi@c@CmCWiBSc@E{LkA}BUSAwAOcJ{@EA[CgMkAqBSgAK_Iw@uAOcDWc@Ec@Ec@Ea@Ec@Ec@Gc@EC?_@Ea@Ec@EYCIAc@Ec@Ea@Ec@Ec@EA?a@Ec@Ea@Gc@Ec@Ec@Ec@EIAWCc@EUCMAc@Ec@Ea@Ec@CWCKAc@Ec@GMAUCa@CKAWCE?M?O?G?[?K?W@Q@QBc@Bc@DO@SD_@DA@c@FK@UD]DE@C?aHdAKBa@DoSpCsC`@iG~@sBZI@q@JuAVUFgAPg@HE@MD{Bf@c@JcE`AuCp@yA^}EhAa@Jc@JaEbAQDQDcAVo@No@Nk@JqFpAWFcCn@s@PiCn@a@JmDx@aB`@aCj@yItBiMzC_OnDa@JgB`@i@L_FjAoEdA_@HyD`AWFk@Nc@JqFrAuCr@UFmDx@cAVmDz@WFIBoEbA}@RoAVmAR{@Lo@FmBd@{@N}Ch@cLlBc@HI@qHlA{F`Ak@J{HpAc@FuF~@a@Hc@H_BXuF~@yGhA{AVcGbAcAP_Df@iBZa@H}FbAcCb@cKbB{Dn@oDl@iBZeARc@Ha@FiMrBc@HsF`AiBXiBXc@HiBXeAPyGdAa@HaANA?WDcIzAeAPyGhA{HpAgBZcIlAkAR}@PsA\\YF]Li@VqF|BwB~@k@VaAb@cDvAiJ~DcCfA_@NeFzBa@P_@NqLfF}BbA_@PyB~@uAl@s@Z{IzDaAb@{Ap@oKvEaA`@_IlDGBcCdAkEjBu@`@o@\\OHgAt@uDvCs@j@mM|JaAt@mPnMqB|A_Av@uCxByAjAqAjAq@n@A?_E|DmBlB{AzAqGtGYZeBdBmDpDeGhG[ZsArAu@t@mFlFu@v@iChCCDeCfCYZw@v@uFzF[ZcDfDq@r@qEdFuBrBOL_JvI}DxDo@l@_@Xw@f@WNiAn@aAd@WHg@Ps@R_@Lm@N_Dd@yC`@sOpBuAPyC^kEj@wAPYBwGz@yG|@QBoDb@_D^qDb@gEj@c@DmC^a@DmMbBsEj@mDb@[DmBVYDsEl@aD`@sEj@cJfAcEf@oNfBQBI@]DyAPoIfAc@FaEh@kH~@cJfAoGx@c@FsEl@oANgANcCZeJhAc@FG@}JpAaGt@SBiIfAkALeALa@DA?aBPiM~@s@DmGb@sHh@cF^{In@cBLqBViAViHbBODeP~DqA\\eEfAuBj@cAT_@FuGbBgP`Ec@JuHlBiBd@kEfAoG`BiP~DaFnAc@Ja@JeAVwIvBiBf@sBf@}D`Aa@La@JmDz@a@JeAVqCr@aCl@a@Ja@L{JfCOD{@RmBb@[FwIxBiEfAqEfAy@Nk@HO@u@DaB?wCBm@?cE@Y?}B@mF?eE@wDDk@@mAAsE?C?qAA}GKgBAE?oEGiBEAAaDEgCC_DGqACu@AQ?cFEC?uDEoCGyBCcCE]AuACoBEe@Au@?GACAKAe@EYE]EGAE?GAS?A??AA?AAA?A?A?A?A?A@A?A@A@A??@A?E?I?M?S@A?oAB[?I@E@qBEs@?o@@qBJo@Fw@Jo@L_@HkAXy@TaA\\_A`@cAh@q@`@yAdAEB]TyBxAoHdF}@l@]V{AbA]V_@TgFnD_PxKkAx@_@TyBzAmAz@}EfDoCjBsA|@SL]VeD|BgD|BoAz@oA|@gD|BiAv@m@b@KHcCbBiBlA_@VC@A@yCnB{@d@y@`@eA`@KDu@Tu@RoAX[F[DUB[D]Bu@D}AHcIVc@BkBFuELmSp@iFNwFP{FPoADo@By@DI?}@BgCHuENiBHi@By@ByADeCHqGPuNd@qNb@W?_ENkBFmCJyMb@I@E?gK\\aBDqELO@kBD{ADs@Bc@BaADsCHgABC?mEPqBHkADyFT}DHqDNgDHM?c@@g@@kBHgEL_DHcCHsBJq@BoEJaFL_ADgBHoADw@Bs@Bc@B_BFaFNyDLaBFgFLqBH}BDcCJgAD_CLSBO@UBC@WBi@Hm@Nu@PqBh@kAZgAXSH_@Js@Tu@Ri@L_Dz@oA\\cCn@mCv@cAVA@aAXqA^kBf@mCr@MBeBf@a@Jy@T_Bd@sA`@A?a@L[JiAX[Hi@LC@kAXWF_AXC?kD|@c@J_Bb@g@NODmBf@sBh@aAV_FpA}I|BmG~AeFrAiEhAiCr@e@LiBf@iBb@aB`@{@Vi@NaAVC@]Hc@LE@_AXaAXeAVsBf@cDz@[JuBh@sBf@_ATg@Nu@RUFc@JSFq@N{Bl@eBb@o@PaHjBE@_AVe@LcBb@_B`@E@y@TKB}@TgA\\A?oAZ{Bl@qCr@wCx@o@Pw@ReDz@_Bb@}@TsIzB]HuL|CcOzDg@NoBh@eCn@cCl@q@Pg@Ni@NMBsA\\q@PqA^e@Lu@TmCr@s@P{Bl@qBd@w@T]Jg@No@Pc@JsEnAqU`Ga@Ja@LkD`Aa@L]JC?a@JgB`@eAVqFtAa@La@JeCr@gAVa@JoAZeFtAmBf@mFxAG@[HaB`@iAXA?kBd@]Je@N}@Zo@Ts@V{@\\_@P_@P{@^q@\\cAh@{@f@a@Vu@d@c@VkAx@yCtBe@\\y@j@qBtAA@]V}B~Ay@l@y@l@MHi@`@s@f@wA`A_Ar@i@^EBWRe@^iAx@w@j@i@^m@`@cExCMHeBpACBm@b@oAx@e@\\yCpBoBtAq@d@wDlCy@l@]T_@V]T]V]Tk@`@OL_@Vi@`@_@Z_@ZgAv@aAr@IFkCjByAbA}@l@]V_BdAuCrB[R_@Vy@l@{@n@_Ar@aC`Bo@d@YPiAv@yAdAWPq@h@{AfAmAx@WRk@`@KHIHs@j@mCfBg@^gCdBq@d@[Rc@\\wCzBwA`AiCfBqDdCiAx@_H~EqHlF]VkCjBcCdB}@l@mDbCsEdDeKlHuGpEiHlFkFpDmDfCaBjAu@h@uDjCiM~IyCvBuCrBoA|@eBpAWR_@R]TIFs@d@{@n@k@b@iA|@WRc@Z}@j@yAbAeAr@qBvA]TwCrBcGpEuDhC]VwCrBWREBuCtB]VOJiD|ByAbA]T]Vi@^_Ap@oBtA_EtCsDfC]VuBxAmCpBaDzBSLIHgAt@oA|@y@j@uA`Ae@ZyAbAmA~@{B|AuCrBwAhAuBdB[V]XUPOL]Vw@r@iFxFYZsC|CiJbKSR_IvI}BfCGFkFzFgDrDSR_ChCkCvCoArAyBbCKL[Zs@x@]^YZkCtC[\\uAxAsBzB[ZIHwC`Dy@|@i@l@YZkBrBaAdA_AdA[Zu@x@YZ_@`@aAdA}@bAw@x@YZCBmApAYZuBxByA~A}@`A_BdBSTSR[\\iBpB[\\QP}A`ByCfDUVo@v@ST_A`AiAlAsAzAc@f@w@x@e@d@UTo@r@ORY\\MLQROPWTq@j@}BvBmCdCiAdA_@^w@t@SPYVuBhBKJmBdBSRoAfAgC~BC@sChCw@r@aFtEeB|AoBdBUT]XwBpBwAnAk@h@y@x@MJML[ZMLiAdAqAjAu@n@}@r@{@t@qAlAy@t@A@YViAdAo@j@{BrB{@|@_@^[V[ZA@YV[XCBq@j@g@b@u@l@k@j@e@`@[X_@Ze@b@i@f@g@d@u@p@wClCwDjD_@\\GDq@l@q@n@}DlDgAbAYV]\\[XA?[ZGFs@n@e@d@yApAqAjAqAlA}@x@u@p@k@h@{ClCMJMLqBjBgEzDqAjAiC`CeA`AaBvAwBnBmD`D{DnD}AxAo@l@]ZYXGH[\\Y\\m@t@iB~BqBpCcApAuEnGg@r@_BvBaAnA_AnAk@x@Y\\UZQRk@p@GJUX[b@A@{@jAc@l@e@n@UZU^Yd@KNQVy@bAc@d@e@j@_AlAe@n@QVy@lA_BvB]f@c@j@i@p@gAtAgB`CY\\W^q@|@Y`@gAzA[`@Y^a@d@{@|@[Z_@\\qB~AyAfAqDpCoDrCuB`B{@p@oBzAiA~@qDpCy@n@cClBQLcCfBqAdA_Ax@eA|@c@^_@\\e@b@oAjAWV_@`@sAlA{BrB]\\]XmAjAeExDq@n@cA~@[XYVmAhAA@q@n@WVu@p@wBnBaA|@wApAuApA{AtAiAbAaCzB[Va@\\e@`@WRa@Zg@^k@`@kAz@_@Ve@\\e@XIHKHa@Xa@XoBtAeIvFaFhDeD|BkAx@yB|AyCtB}@n@yAbAc@ZkBpAo@d@uBxA_BdASLa@V]Rg@Vs@^e@Ri@Vc@Pa@PmAf@s@X_A`@q@Xo@XcBp@{@^eCdAC@oAh@uAj@uB|@_A`@q@Z");

    log('( 1 & 2 ) > 0 ==> ${(1 & 2) > 0}');
    log('( 1 & 2 ) ==> ${(1 & 2)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(50.10, 14.25), zoom: 10),
        polylines: <Polyline>{
          Polyline(
              polylineId: const PolylineId("PolylineId"),
              points: <LatLng>[origen, destino],
              color: Colors.red,
              width: 5)
        },
        // polygons: {
        //   const Polygon(
        //     polygonId: PolygonId("polygon"),
        //     points: [
        //       LatLng(50.40, 14.10),
        //       LatLng(50.10, 14.10),
        //       LatLng(50.10, 14.50),
        //       LatLng(50.40, 14.50),
        //     ],
        //   )
        // },
        onTap: (latLng) {
          print("NOT fired when clicked on Polygon");
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    log('_getPolyline()');
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      NetConts.getGoogleAPIKey(),
      const PointLatLng(_originLatitude, _originLongitude),
      const PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    log(result.toString());
    if (result.points.isNotEmpty) {
      log('message: ${result.points.length.toString()}');
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }
}
