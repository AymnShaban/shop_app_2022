import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

void signOut(context) {
  CasheHelper.removeData(
    key: 'token',
  ).then((value) {
    if(value) {
      myNavigator2(
      context: context,
      Widget: LoginScreen(),);
    }
  });
}
String token = '';
