
import 'dart:convert';
import 'package:http/http.dart' as http; 

class API {
  static const baseUrl = 'http://v.juhe.cn/todayOnhistory';
  static const String appKey = '358271d537e00d0086c5617348c5e73a';
  static const String eventList = baseUrl + '/queryEvent.php?key=' + appKey;
  static const String detailUrl = baseUrl + '/queryDetail.php?key=' + appKey;

  getEventsWithDate(DateTime date, Function callBack) async {
    String url = eventList + '&date=' + date.month.toString() + '/' + date.day.toString();
    try {
      var response = await http.get(url);
      if(response.body != null) {
        var data = jsonDecode(response.body);
        callBack(data);
      }
    } catch (e) {
      callBack(e);
    }
  }

  getEventDetail(id, Function callBack) async {
    String url = detailUrl + '&e_id=' + id;
    try {
      var response = await http.get(url);
      if(response.body != null) {
        var data = jsonDecode(response.body);
        callBack(data);
      }
    } catch (e) {
      callBack(e);
    }
  }
}