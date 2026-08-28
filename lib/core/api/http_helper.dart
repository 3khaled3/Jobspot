import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:dartz/dartz.dart";
import "package:http/http.dart" as http;
import 'package:flutter/foundation.dart';
part "failure_model.dart";

abstract class HttpHelper {
  // todo: post
  // todo: get
  static Future<http.Response> getData({
    required String linkUrl,
    required String token,
  }) async {
    var headers = {
      "Content-Type": 'application/json',
      "x-rapidapi-host": 'active-jobs-db.p.rapidapi.com',
      'x-rapidapi-key': token,
    };
    try {
      await http.get(Uri.parse(linkUrl), headers: headers);
    } catch (e) {
      print("22222222222222??????????????????? ${e.toString()}");
    }
    var response = await http.get(Uri.parse(linkUrl), headers: headers);

    print("Response Status: ${response.statusCode}");
    log("Response Body: ${response.body}");

    return response;
  }

  // todo: handle request

  static Future<Either<FailureModel, Map<String, dynamic>>> handleRequest(
    Future<http.Response> Function(String? token) requestFunction,
  ) async {
    try {
      if (!await isConnectedToInternet()) {
        return Left(
          FailureModel(responseStatus: HttpResponseStatus.noInternet),
        );
      }

      final customToken = "dbf57f51bemsh5cf9133b4efce56p12c07fjsnac57637ce22f";
      final response = await requestFunction(customToken);

      final decoded = utf8.decode(response.bodyBytes);
      final body = decoded.isNotEmpty ? jsonDecode(decoded) : {};

      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          print("ssss body : $body");
          return Right(body is Map<String, dynamic> ? body : {"data": body});
        case 400:
        case 401:
          return Left(
            FailureModel(
              responseStatus: HttpResponseStatus.invalidData,
              message:
                  body['message'] ?? "please check your data and try again",
            ),
          );
        case 403:
          return Left(
            FailureModel(
              responseStatus: HttpResponseStatus.unAuthorized,
              message:
                  body['message'] ??
                  "you are not authorized to perform this action",
            ),
          );
        default:
          return Left(
            FailureModel(
              responseStatus: HttpResponseStatus.failure,
              message: body['message'] ?? "something went wrong",
            ),
          );
      }
    } catch (e, stack) {
      log("Exception in handleRequest", error: e, stackTrace: stack);
      return Left(FailureModel(responseStatus: HttpResponseStatus.failure));
    }
  }
}
