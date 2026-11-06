class QrCodePayLoad{
  final String fingerPrint;
  final String token;
  final int protocolVersion;
  final String port;
  final String ip;
  final String accountUid;

  const QrCodePayLoad({required this.fingerPrint ,
   required this.token ,
    required this.protocolVersion,
    required this.accountUid,
    required this.ip,
    required  this.port
    });
  
}