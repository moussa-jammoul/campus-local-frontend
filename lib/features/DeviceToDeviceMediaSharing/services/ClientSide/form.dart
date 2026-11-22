// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
class QrCodePayLoadDifferentAccounts{
  final String fingerPrint;
  final String token;
  final int protocolVersion;
  final int port;
  final String ip;
  final String accountUid;

  const QrCodePayLoadDifferentAccounts({required this.fingerPrint ,
   required this.token ,
    required this.protocolVersion,
    required this.accountUid,
    required this.ip,
    required  this.port
    });

  factory QrCodePayLoadDifferentAccounts.fromJson(
    {
    required Map<String, dynamic> json,
    }
  )
  {
    return QrCodePayLoadDifferentAccounts(
  fingerPrint: json['fp'] as String,
  token: json['t'] as String,
  protocolVersion: json['v'] as int,
  accountUid: json['user'] as String,
  ip: json['ip'] as String,
  port: json['port'] as int ,
);
  }
  
}