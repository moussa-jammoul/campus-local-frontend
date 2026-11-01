import 'dart:io';

abstract class RequestRouterServiceDomain {
  Future<void> handleRequest(HttpRequest req , String token);//route a request to whatever function it need , validate the token
}
