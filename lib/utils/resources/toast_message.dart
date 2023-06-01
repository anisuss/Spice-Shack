import 'package:fluttertoast/fluttertoast.dart';
import 'package:spice_shack/resources/colors/colors_resources.dart';

class ToastMessage{

  void toastMessage(message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.red.withOpacity(0.8),
        textColor: MyColors.silver,
        fontSize: 16.0,
    );
  }
}