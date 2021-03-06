

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiaobei/page/app.dart';
import 'dart:convert';

import 'package:xiaobei/utils/Base64.dart';
import 'package:xiaobei/utils/show.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late  TextEditingController _userNameController,_passwordController;
  var _headers = {
    'user-agent': 'PCAM10(Android/10) (uni.UNIA68F45B/2.1.3) Weex/0.26.0 1080x2264',
    'Host': 'xiaobei.yinghuaonline.com',
    'Connection': 'Keep-Alive',
    'Accept-Encoding': 'gzip'
  };


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _getCapther() async {

    if(_userNameController.value.text==""||_passwordController.value.text==""){
      SQToast.show("请正确输入账号密码");
      return;
    }
    SQToast.show("正在登陆中");
    Response response;
    var dio = Dio();
    response = await dio.get("https://xiaobei.yinghuaonline.com/prod-api/captchaImage",options: Options(headers: _headers));
    Map<String,dynamic> cap= response.data;
    print("123");
    response = await dio.post("https://xiaobei.yinghuaonline.com/prod-api/login",options: Options(headers: _headers),data: {
    "username": _userNameController.value.text,
    "password": encodeBase64(_passwordController.value.text),
    "code": cap["showCode"],
    "uuid": cap["uuid"]
    });
    print(response.data);
    print(_userNameController.toString());
    print(encodeBase64(_passwordController.toString()));
    Map<String,dynamic> data = response.data;
    if (data["code"].toString()=="200"){
      SQToast.show("登录成功，正在跳转");
      SharedPreferences ps = await SharedPreferences.getInstance();
      ps.setString("token", data["token"]);
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }else{
      SQToast.show("登录失败\n\t"+data['msg']);
      print(data["msg"]);
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "static/login/login_bg.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 350,
            height: 250,
            left: 30,
            right: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                        prefixIcon: Image.asset('static/login/userName.png',width: 4,height: 4,)
                    ),
                  ),
                    width: MediaQuery.of(context).size.width,
                    height: 70
                ),
                SizedBox(
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset('static/login/password.png',width: 4,height: 4,)
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 70
                ),
                Container(
                  child: new Text(""),
                ),
                SizedBox(
                    child: Center(
                      child: InkWell(//在最外层包裹InkWell组件
                        onTap: (){
                          _getCapther();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.lightBlue
                          ),
                          child: Center(//加上Center让文字居中
                            child: Text('登  录',style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      )
                      ,
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
