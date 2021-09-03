import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiaobei/page/login/login.dart';
import 'package:xiaobei/utils/show.dart';

class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  var _headers = {
    'user-agent':
        'PCAM10(Android/10) (uni.UNIA68F45B/2.1.3) Weex/0.26.0 1080x2264',
    'Host': 'xiaobei.yinghuaonline.com',
    'Connection': 'Keep-Alive',
    'Accept-Encoding': 'gzip'
  };

  var _info;
  var _user = {};
  var _studentInfo = {};

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  void toLogin() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  @override
  void reassemble() {
    super.reassemble();
    getVersion();
  }

  void goOutLogin() async {
    SharedPreferences ps = await SharedPreferences.getInstance();
    ps.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  void getVersion() async {
    var dio = Dio();
    SharedPreferences ps = await SharedPreferences.getInstance();
    if (!ps.containsKey("token")) {
      toLogin();
      return;
    }
    setState(() {
      _headers["Authorization"] = "Bearer " + ps.getString("token").toString();
    });
    // 获取info信息
    Response response = await dio.get(
        "https://xiaobei.yinghuaonline.com/prod-api/getInfo",
        options: Options(headers: _headers));
    Map<String, dynamic> data = response.data;
    if (data["code"] != 200) {
      print(data["msg"]);
      SQToast.show(data["msg"]);
      goOutLogin();
      return;
    } else {
      SQToast.show(data["msg"]);
      setState(() {
        _info = data;
        _user = _info["user"];
      });
    }
    response = await dio.get(
        "https://xiaobei.yinghuaonline.com/prod-api/student/studentInfo",
        options: Options(headers: _headers));
    Map<String, dynamic> data1 = response.data;
    setState(() {
      _studentInfo = data1["data"];
    });

  }

  Widget getData(){
    if(_studentInfo.length <= 0){
      return new Text("正在加载中");
    }else{
      return new Positioned(
          top: 100,
          height: 400,
          left: 20,
          right: 20,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          new Text(_studentInfo["studentName"],
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          new Text("学生", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          new Text(_studentInfo["deptName"],
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          Spacer()
                        ],
                      ),

                      Divider(),

                      Row(
                        children: [
                          new Text(
                            "手机",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          new Text(_user["phonenumber"].toString(),
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                      Row(
                        children: [
                          new Text(
                            "邮箱",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          new Text(_user["email"].toString(),
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                      Row(
                        children: [
                          new Text(
                            "学号",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          new Text(_studentInfo["studentNumber"].toString(),
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                      Row(
                        children: [
                          new Text(
                            "入学时间",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          new Text(
                              _studentInfo["studentSchoolTime"].toString(),
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          InkWell(
                            child: Image.asset("static/my2/update.png",width: 60,height: 60),

                          ),
                          InkWell(
                            child: Image.asset("static/my2/editInfo.png",width: 60,height: 60),
                          ),
                          InkWell(
                            child: Image.asset("static/my2/editpw.png",width: 60,height: 60),
                          ),
                          InkWell(
                            child: Image.asset("static/my2/logout.png",width: 60,height: 60),
                            onTap: goOutLogin,
                          ),




                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                      Row(
                        children: [
                          new Text("检查更新",style: TextStyle(fontSize: 15),),
                          new Text("个人资料",style: TextStyle(fontSize: 15)),
                          new Text("修改密码",style: TextStyle(fontSize: 15)),
                          new Text("退出账户",style: TextStyle(fontSize: 15)),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                    ],
                  ))));
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "static/bg.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          getData()
        ],
      ),
    );
  }
}
