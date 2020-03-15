import 'package:cryptocoinapp/models/coinmodels.dart';

abstract class BaseCryptoRepo{
  Future<List<Coin>> getTopCoins({int page});
  void dispose();
}