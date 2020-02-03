import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_cart_bloc/item.dart';

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
class CartBloc extends Bloc<CartEvent,List<Item>>{
  //bloc을 사용하기 위해서는 반드시 지금과 같은 형태로 블럭을 만들어 주어야 한다.
  List<Item> items = [];

  @override
  // TODO: implement initialState
  List<Item> get initialState => [];

  @override
  Stream<List<Item>> mapEventToState(CartEvent event) async* { //이부분은 카트블럭에 계속해서 이벤트를 부여하면 어떤식으로 코드를 수행할지를 정하는 메서드이다.
    // 때문에 많은 케이스 들이 나오고 그것을 해결하기 위해서 switch-case문을 자주 사용한다.
    switch(event.type){
      case CartEventType.add :
        items.add(event.item);
        //currentState
        break;

      case CartEventType.remove :
        items.remove(event.item);
        break;
    }

    // TODO: implement mapEvent ToState
    yield items;
    //async* 이렇게하면 stream으로 만든 List들을 계속해서 방출하는것을 선언하는것이다.
    //async* 은 yield와 함께 쓰이는데 yield는 stream으로 만든 List를  return할떄 사용된다. 중요한건 하나씩 하나씩이다.
    // 위 예제에서는 언제 yield를 통해 return을 하냐면 case되어있는 add와 remove할떄마다 return되는 형식이다.
  }

}

