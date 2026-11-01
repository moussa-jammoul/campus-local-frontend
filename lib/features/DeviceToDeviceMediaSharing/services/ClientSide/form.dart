class QrCodePayLoad{
  final String fingerPrint;
  final String token;
  final int protocolVersion;
  final String deviceId;

  const QrCodePayLoad({required this.fingerPrint , required this.token , required this.deviceId , required this.protocolVersion});
  
}