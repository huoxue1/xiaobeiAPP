
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:r_calendar/r_calendar.dart';


class HealthPage extends StatefulWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  _HealthPageState createState() => _HealthPageState();
}




class _HealthPageState extends State<HealthPage> {

  RCalendarController controller =  RCalendarController.single(
    selectedDate: DateTime.now(),
    isAutoSelect: true,);

  var dio = Dio(BaseOptions(baseUrl: "https://xiaobei.yinghuaonline.com/prod-api"));

  @override
  void initState() {
    super.initState();
 
  }


  Future<String> _getData() async{
    dio.get("/student/health/list",queryParameters: {"params":json.encode({})});
    
    
    return  "";
  }

  @override
  void reassemble() {
    super.reassemble();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RCalendarWidget(
          controller: controller,
          customWidget: DefaultRCalendarCustomWidget(),
          firstDate: DateTime(1970, 1, 1),
          lastDate: DateTime(2055, 12, 31),
        ),
    );
  }
}
