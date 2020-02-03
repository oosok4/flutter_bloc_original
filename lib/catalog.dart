import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/cart.dart';

import 'bloc/cart_bloc.dart';
import 'item.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  //파일 이름은 대문자로 시작하더라도 flutter는 소문자로 시작하는것이 관례이다.
  List<Item> _itemList = itemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('카탈로그'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              // 클릭했을 때의 액션이 일어나는곳
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Cart()));
              
            },
          )
        ],
      ),
      body: BlocProvider(
          bloc: _cartBloc,
          child: BlocBuilder(
              bloc: _cartBloc,
              builder: (BuildContext context, List state) {
                return ListView(
                  children: _itemList.map((item) =>
                      _buildItem(item, state, _cartBloc))
                      .toList(),
                );
              }
          )
      ),
      /*
      Center(
        child: ListView(
            children: _itemList
                .map((item) => _buildItem(
                    item)) //map에 있는 아이템을 하나씩 꺼내서 _buildItem에있는 item으로 대체 시켜준다.
                .toList() //이런식으로 여러개의 각 맵들을 toList로 변환시켜준다.
            ),
      ),
       */

    );
  }

//체크가 됬는지 안됬는지 확인하는 변수나 그런것들이 필요한데 이번 프로젝트에서는 그걸 bloc으로 처리할거다.
  Widget _buildItem(Item item, List state, CartBloc cartBloc) {
    final isChecked = state.contains(item);

    return Padding(
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text('${item.price}'),
        trailing: IconButton(
          icon: isChecked
              ? Icon(
                Icons.check,
                color: Colors.red,
              )
              : Icon(Icons.check)
          ,
          onPressed: () {
            setState(() {
                if(isChecked) {
                  cartBloc.dispatch(CartEvent(CartEventType.remove, item)); //이 라이브러리에서만 제공하는 이벤트 메서드 dispatch()
                } else{
                  cartBloc.dispatch(CartEvent(CartEventType.add, item));
                }
            });
          },
        ),
      ),
      padding: const EdgeInsets.all(8.0),
    );
  }
}
//블럭에서 이미 별도로 상태를 저장해 두었기 떄문에 뒤로 갔다가 돌아와도 상태는 유지가 된다.