import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/catalog.dart';

import 'bloc/cart_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //cart_bloc이라는 dart파일에서 우리는 bloc을 만들었다.

  final _cartBloc  = CartBloc();

  @override

  Widget build(BuildContext context) {
    // 최상위에 만들어둔 _cartBloc을 여기서 사용하기위해서는 방금 만든 블럭을 여기서  프로바이더 해주어야 한다.
    return BlocProvider(bloc: _cartBloc,
      child: BlocBuilder(bloc: _cartBloc,
          builder: (BuildContext context, List state){
            return MaterialApp(
              title: 'flutter_Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue
              ),
              home: LoginScreen()
            );
          }), // bloc을 파라미터로 사용하는 BlocProvider라던가 BlocBuilder를 사용하기 위해서는 flutter_bloc을 0.8.0 을 사용하여야 한다

      //bloc을 왜 이중으로 사용했냐면 blocProvider는 사실은 여러 화면을 제공하는 bloc이 올 수 있다.
      // 하지만 우리는 하나의 화면을 제공하는 블럭만 필요하기 떄문에 blocBuild에 동일한 _cartBloc를 넣어서 사용하는 것이다.
      
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


