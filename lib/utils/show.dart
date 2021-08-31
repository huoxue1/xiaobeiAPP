import 'package:fluttertoast/fluttertoast.dart';

class SQToast {
  static show(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 25
    );
  }
}