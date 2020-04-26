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
  String title;
  DateTime date = DateTime.now();
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
        title: Text(title),
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _chooseDate();
        },
        backgroundColor: Colors.blue,
        child : Center(child: Text('选择\n日期'),),
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
    await API().getEventsWithDate(date, (result){
      setState(() {
        dataList = result['result'];
      });
    });
  }

  _updateTitle() {
    setState(() {
      if (date.day == DateTime.now().day) {
        title = '历史上的今天';
      } else {
        title = formatDate(date ,['历史上的  ', mm, '-' ,dd]);
      }
    });
  }

  _chooseDate() async {
    DateTime now = DateTime.now();
    date = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(now.year,01, 01), lastDate: DateTime(now.year, 12, 31));
    if (date != null) {
      setState(() {
        _updateTitle();
        _getData();
      });
    }
  }
}
  