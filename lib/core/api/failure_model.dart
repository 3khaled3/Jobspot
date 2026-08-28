part of 'http_helper.dart';

enum HttpResponseStatus {
  noInternet,
  success,
  unAuthorized,
  invalidData,
  failure,
}

Future<bool> isConnectedToInternet() async {
  try {
    if (!kIsWeb) {
      final result = await InternetAddress.lookup("google.com");
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    }
    return true;
  } on SocketException {
    return false;
  }
}

class FailureModel {
  final String? message;
  final HttpResponseStatus responseStatus;

  FailureModel({required this.responseStatus, this.message});

  @override
  String toString() =>
      'FailureModel(status: $responseStatus, message: $message)';
}
