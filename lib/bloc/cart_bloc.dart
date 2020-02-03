import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_cart_bloc/item.dart';
import 'package:rxdart/rxdart.dart'; // rxdart가 flutter_bloc 디펜던시에 들어있어서 임포트가 된다.

import '../item.dart'; //이 라이브러리는 이벤트에대한 액션을 보기위한 package(?)이다.
// 이벤트라 함은 카트에 넣고 빼고 하는 등의 행동을 말한다.

enum CartEventType{ // 이벤트 생성을 하는 메서드인가 보다.
  add, remove
}

class CartEvent{
  final CartEventType type; //이 type에는 add또는 remove만 들어갈 수 있다. enum은 이런식으로 상태를 제안할 때 사용하면 된다,
  final Item item;

  CartEvent(this.type,
      this.item); //이건 어떤 아이템을 add하고 remove할거냐를 묻기위해 존재하는 전역변수? 이다.
}

//이제 위에서 만든 데이터를 토대로 카트 블럭을 만들껀데
class CartBloc {
  final itemList = [
    Item('맥북',2000000),
    Item('생존코딩',32000),
    Item('스타벅스',6000),
    Item('아이폰',1300000),
    Item('에어팟프로',329000),
    Item('월급',1800000)
  ];

  final _cartList =  List<Item>(); //빈 리스트 생성

  final _cartListSubject = BehaviorSubject<List<Item>>.seeded([]);

  Stream<List<Item>> get cartList => _cartListSubject.stream;

  void add(CartEvent event){
    switch(event.type){
      case CartEventType.remove :
        _cartList.remove(event.item);
        break;
      case CartEventType.add :
        _cartList.add(event.item);
        break;
    }
    _cartListSubject.add(_cartList);
  }

}

