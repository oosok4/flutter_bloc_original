import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/catalog.dart';

import 'bloc/cart_bloc.dart';

void main() => runApp(MyApp());

final cartBloc  = CartBloc();
class MyApp extends StatelessWidget {
  //cart_bloc이라는 dart파일에서 우리는 bloc을 만들었다.



  @override

  Widget build(BuildContext context) {
    // 최상위에 만들어둔 _cartBloc을 여기서 사용하기위해서는 방금 만든 블럭을 여기서  프로바이더 해주어야 한다.
    return MaterialApp(
        title: 'flutter_Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: LoginScreen()
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WelCome'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('enter'),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Catalog()));
          },
        ),
      ),

    );
  }
}


