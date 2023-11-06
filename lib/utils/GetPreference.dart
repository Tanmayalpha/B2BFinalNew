import 'package:shared_preferences/shared_preferences.dart';

void setString ({required String key, required String value}) async{

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sharedPreferences.setString(key, value) ;
}

Future<String?> getString ({required String key}) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? value = sharedPreferences.getString(key);
  return value ;

}


