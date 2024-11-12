import 'dart:convert';

import 'package:http/http.dart' as https;

class ApiService{

  Future getData(String url) async{

    final response = await https.get(Uri.parse(url));
    
    if(response.statusCode == 200){
      final jsonBody = json.decode(response.body);
      return jsonBody;
    }else {
      throw Exception("Failed to load Event Category");
    }
  }


  Future postData(String url, Map<String,dynamic>data) async{

    final response = await https.post(Uri.parse(url),

  headers: {
  'Content-Type': 'application/json',
  },
  body: jsonEncode(data));

    if(response.statusCode == 200){
      final jsonBody = jsonDecode(response.body);
      return jsonBody;
    }

  }

}