import 'package:cryptocoinapp/models/coinmodels.dart';
import 'package:cryptocoinapp/repo/cryptorepo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cryptoRepo = CrytoRepo();
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Coins'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Theme.of(context).primaryColor, Colors.grey]),
        ),
        child: FutureBuilder(
            future: _cryptoRepo.getTopCoins(page: _page),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                ));
              }
              final List<Coin> coins = snapshot.data;
              return RefreshIndicator(
                color: Theme.of(context).accentColor,
                onRefresh: () async{
                  setState(() {
                    _page = 0;
                  });
                },
                child: ListView.builder(
                    itemCount: coins.length,
                    itemBuilder: (BuildContext context, int index) {
                      final coin = coins[index];
                      return ListTile(
                        leading: Text(
                          '${++index}',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                        title: Text(
                          coin.fullName,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          coin.name,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: Text(
                          '\$${coin.price.toStringAsFixed(4)}',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
