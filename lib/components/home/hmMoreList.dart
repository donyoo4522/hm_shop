import 'package:flutter/material.dart';

class HmMoreList extends StatefulWidget {
  HmMoreList({Key? key}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 100,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(
            "商品${index + 1}",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      },
    );
  }
}
