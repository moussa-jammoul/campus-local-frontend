// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class QrcodeServiceDomain{
  String? generateOneTimeToken({required int length});//used for pairing , Server validate it from the request sender
  
  String generateQrCodeBasePayLoad({ //transform data into json so we use them to generate qr code (we push the data to a provider)
    required String token,
    required String fingerPrint,
    required int port,
    required String ipLAN,
    required String userUid,
  });

  

}