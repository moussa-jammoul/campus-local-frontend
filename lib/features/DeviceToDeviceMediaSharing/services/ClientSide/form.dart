class QrCodePayLoad{
  final String fingerPrint;
  final String token;
  final int protocolVersion;
  final int port;
  final String ip;
  final String accountUid;

  const QrCodePayLoad({required this.fingerPrint ,
   required this.token ,
    required this.protocolVersion,
    required this.accountUid,
    required this.ip,
    required  this.port
    });

  factory QrCodePayLoad.fromJson(
    {
    required Map<String, dynamic> json,
    }
  )
  {
    return QrCodePayLoad(
  fingerPrint: json['fp'] as String,
  token: json['t'] as String,
  protocolVersion: json['v'] as int,
  accountUid: json['user'] as String,
  ip: json['ip'] as String,
  port: json['port'] as int ,
);
  }
  
}