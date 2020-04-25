import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:today_in_history/api/API.dart';
import 'detail_page.dart';

class EventsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventsListPageState();
  }
}

class _EventsListPageState extends State<EventsListPage> {
  String date;
  var dataList = List();

  @override
    void initState() {
      super.initState();
      _updateTitle();
      _getData();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(date),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _getItem(index);
        }, 
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Colors.blue,
          );
        }, 
        itemCount: dataList.length,
      ),
    );
  }


  Widget _getItem(int idx) {
    Map map = dataList[idx];
    return Padding(
      padding: EdgeInsets.all(20), 
      child: GestureDetector(
        onTap: () {
          print(map['title']);
          Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return DetailPage(map['e_id']);
                }));
        },
        child: Text(map['title']),
      ),
    );
  }

  _getData() async {
    await API().getTodayEvents((result){
      setState(() {
        dataList = result['result'];
      });
    });
  }

  _updateTitle() {
    setState(() {
      date = formatDate(DateTime.now() ,['今天是  ',yyyy,'-',mm,'-',dd]);
    });
    
  }
}
  