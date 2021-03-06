import 'dart:convert';

import 'package:cryptocoinapp/models/coinmodels.dart';
import 'package:cryptocoinapp/repo/basecrypto.dart';
import 'package:http/http.dart' as http;

class CrytoRepo extends BaseCryptoRepo {
  static const String _baseUrl = 'https://min-api.cryptocompare.com';
  static const int _perpage = 20;

  final http.Client _httpClient;
  //cryptorepo constructor
  CrytoRepo({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<Coin>> getTopCoins({int page})async {
    List<Coin> coins =[];
    String requestUrl = '$_baseUrl/data/top/totalvolfull?limit=$_perpage&tsym=USD&page=$page';
    //String requestUrl = 'https://min-api.cryptocompare.com/data/top/totalvolfull?limit=20&tsym=USD&page=1';
   // String requestUrl = 'https://min-api.cryptocompare.com/data/top/totalvolfull?limit=20&tsym=USD';
    try {
      final response = await _httpClient.get(requestUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> coinList = data['Data'];
        coinList.forEach((json) => coins.add(Coin.fromJson(json)));
        
      }
      return coins;
    } catch (e) {
      throw (e);
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
