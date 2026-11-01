abstract class MulticastDnsServiceDomain {
   Future<void> sendMDNS({
    required String devicename,
    required String deviceID,
    required int port,
    //ip handled by mDNS , protocol version and service type hardcoded in the function itself
  });

  Future<void> unregisterMdns();

}