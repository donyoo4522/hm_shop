import 'package:flutter/material.dart';

class HmSuggention extends StatefulWidget {
  HmSuggention({Key? key}) : super(key: key);

  @override
  _HmSuggentionState createState() => _HmSuggentionState();
}

class _HmSuggentionState extends State<HmSuggention> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      color: Colors.blue,
      child: Text("推荐", style: TextStyle(color: Colors.white, fontSize: 30)),
    );
  }
}
