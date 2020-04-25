import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:today_in_history/api/API.dart';

class DetailPage extends StatefulWidget {
  final eventId;

  DetailPage(this.eventId);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(eventId);
  }
}

class _DetailPageState extends State<DetailPage> {
  final eventId;
  String title = '';
  String content = '';

  _DetailPageState(this.eventId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDetailData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Scrollbar(child: SingleChildScrollView(
        child: Padding(
                  padding: EdgeInsets.all(20), 
                  child: Text(content),
          )
      ),), 
    );
  }

  _getDetailData() async {
    await API().getEventDetail(eventId, (result) {
      if(result != null) {
        List list = result['result'];
        Map map = list[0];
        setState(() {
          content = map['content'];
          title = map['title'];
        });
      }
    });
  }
}