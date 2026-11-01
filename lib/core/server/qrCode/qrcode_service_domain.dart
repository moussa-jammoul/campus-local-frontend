abstract class QrcodeServiceDomain{
  String? generateOneTimeToken({required int length});//used for pairing , Server validate it from the request sender

  String generateQrCodePayLoad({ //transform data into json so we use them to generate qr code (we push the data to a provider)
    required String token,
    required String fingerPrint,
    required String deviceId,
  });

}