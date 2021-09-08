import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Console extends StatefulWidget {
  const Console({Key? key}) : super(key: key);

  @override
  _ConsoleState createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {


  Widget getData(String imageUrl,String text){
    return Expanded(child: Center(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              switch(text){
                case "体温上报": {
                  Navigator.pushNamed(context, "/console/health");
                }
              }
            },
              child: Image.asset(imageUrl,width: 50,height: 50)
          ),

          Text(text)
        ],
      ),
    ));
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
          Positioned(
              top: 20,
              height: MediaQuery.of(context).size.height-280,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(),
                    Row(
                      children: [

                        getData("static/console2/leave.png", "请假"),
                        VerticalDivider(),
                        getData("static/console2/backout.png", "销假"),
                      ],
                    ),
                    Divider(color: Colors.black,),
                    Row(
                        children: [
                          getData("static/console2/knowing.png", "查寝"),
                          VerticalDivider(),
                          getData("static/console2/signin.png", "活动签到"),
                        ],
                    ),
                    Divider(color: Colors.black,),
                    Row(
                      children: [
                        getData("static/console2/info.png", "信息收集"),
                        VerticalDivider(),
                        getData("static/console2/studentInfo.png", "学生信息"),
                      ],
                    ),
                    Divider(color: Colors.black,),
                    Row(
                        children: [
                          getData("static/console2/email.png", "学生信箱"),
                          VerticalDivider(),
                          getData("static/console2/health.png", "体温上报"),
                        ],
                    ),
                    Divider(color: Colors.black,),
                    Row(
                        children: [
                          getData("static/console2/leave.png", "创意设计大赛"),
                          VerticalDivider(color: Colors.black,),
                          getData("static/console2/backout.png", "综合评测"),
                        ],
                    ),
                    Row()
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
