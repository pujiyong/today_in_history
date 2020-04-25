
import 'dart:convert';
import 'package:http/http.dart' as http; 

class API {
  final String eventList = 'http://v.juhe.cn/todayOnhistory/queryEvent.php?key=358271d537e00d0086c5617348c5e73a';
  final String detailUrl = 'http://v.juhe.cn/todayOnhistory/queryDetail.php?key=358271d537e00d0086c5617348c5e73a';

  getTodayEvents(Function callBack) async {
    DateTime date = DateTime.now();
    String url = eventList + '&date=' + date.month.toString() + '/' + date.day.toString();
    print(url);
    try {
      var response = await http.get(url);
      if(response.body != null) {
        var data = jsonDecode(response.body);
        callBack(data);
        print(data);
      }
    } catch (e) {
      callBack(e);
    }
  }

  getEventDetail(id, Function callBack) async {
    String url = detailUrl + '&e_id=' + id;
    print(url);
    try {
      var response = await http.get(url);
      if(response.body != null) {
        var data = jsonDecode(response.body);
        callBack(data);
        print(data);
      }
    } catch (e) {
      callBack(e);
    }
  }
}