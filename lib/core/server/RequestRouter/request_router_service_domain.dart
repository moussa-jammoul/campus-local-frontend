import 'dart:io';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class RequestRouterServiceDomain {
  Future<void> handleRequest(HttpRequest req , String token);//route a request to whatever function it need , validate the token
}
