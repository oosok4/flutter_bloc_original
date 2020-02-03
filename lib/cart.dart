import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/bloc/cart_bloc.dart';
import 'package:flutter_cart_bloc/item.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('장바구니'),
      ),
      body: BlocProvider(
        bloc: _cartBloc,
        child: BlocBuilder(
          bloc: _cartBloc, builder: (BuildContext context, List state){
            var sum = 0;
            if(state.length > 0){
              sum = state.map((item) => item.price).reduce((acc, e)=> acc + e);//reduce(acc,e)라는 메소드는 둘이서 누적연산해서 앞에거에 누적되는 것이다.
              //이상태로 저장하면 에러가 난다 왜냐하면 acc.price와 e.price는 아이템인데 reduce하면서 아이템이 아니게 됬는데 item으로 return하려했기 때문이
              //map을 사용하여 item에서 price만 뺴와서 acc와 e에 적용시켰기떄문에 별도로 acc와 e에서 .price를 할 필요가 없다.
            }

           return Center(
             child: Text('합계 : ${sum}원'
                 ,style: TextStyle(fontSize: 30),
             ),
           );
        }
        )
      )

    );
  }
}
