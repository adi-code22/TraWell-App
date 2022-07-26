import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:trawell/models/constants.dart';
import 'package:trawell/models/market_model.dart';

class ApiServicePost {
  Future<void> post(String str) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpointPost);
      await http.post(url, body: {
        'name': "Aditya",
        'email': "adityakrishnanp007@gmail.com",
        'phone': "+917034480492",
        'itemID': str,
      });
      // if (response.statusCode == 200) {
      //   List<UserModel> _model = userModelFromJson(response.body);
      // }
    } catch (e) {
      log(e.toString());
    }
  }
}
