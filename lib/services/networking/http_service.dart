import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class HttpService {
  Future<Map<String, dynamic>> get(Uri uri) async {
    Map<String, dynamic> decodedResponseJson;
    try {
      final response = await http.get(uri);
      decodedResponseJson = _decodeResponse(response, uri);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return decodedResponseJson;
  }

  Future<Map<String, dynamic>> post(Uri uri, Map<String, dynamic> body) async {
    Map<String, dynamic> decodedResponseJson;
    try {
      final response = await http.post(
          uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      );
      decodedResponseJson = _decodeResponse(response, uri);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return decodedResponseJson;
  }

  Future<Map<String, dynamic>> delete(Uri uri) async {
    Map<String, dynamic> decodedResponseJson;
    try {
      final response = await http.delete(uri);
      decodedResponseJson = _decodeResponse(response, uri);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return decodedResponseJson;
  }

  Future<Map<String, dynamic>> put(Uri uri, Map<String, dynamic> body) async {
    Map<String, dynamic> decodedResponseJson;
    try {
      final response = await http.put(
          uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      );
      decodedResponseJson = _decodeResponse(response, uri);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return decodedResponseJson;
  }

  dynamic _decodeResponse(http.Response response, Uri uri) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        //print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        //print(responseJson);
        return responseJson;
      case 400:
        print('Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        print('Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        print('Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}