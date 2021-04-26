import 'package:shared_preferences/shared_preferences.dart';

///Internal class for shared preferences methods
///This class provides low level preferences methods
class Prefs{
  ///Instance of shared preferences
  static SharedPreferences? _sharedPrefs;

  ///Singleton instance of Preferences Helper
  static Prefs? _instance;

  ///Private constructor
  const Prefs._();

  ///Get instance of this class
  static Prefs get instance =>  _instance ?? const Prefs._();

  ///Initializer for shared prefs
  ///Should be called in main before runApp and
  ///after WidgetsBinding.FlutterInitialized()
  static init() async {
    if(_sharedPrefs == null ) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  ///Loads value for the key from preferences
  T? get<T>(String key) {
    switch(T){
      case String: return _sharedPrefs!.getString(key) as T;
      case int: return _sharedPrefs!.getInt(key)  as T;
      case bool: return _sharedPrefs!.getBool(key)  as T;
      case double: return _sharedPrefs!.getDouble(key)  as T;
      default: return _sharedPrefs!.getString(key)  as T;
    }
  }

  ///Sets the value for the key to preferences
  set<T>(String key, T value) {
    switch(T){
      case String: return _sharedPrefs!.setString(key, value as String);
      case int: return _sharedPrefs!.setInt(key, value as int);
      case bool: return _sharedPrefs!.setBool(key, value as bool);
      case double: return _sharedPrefs!.setDouble(key, value as double);
      default: return _sharedPrefs!.setString(key, value as String);
    }
  }

  ///Resets preferences
  clear() => _sharedPrefs!.clear();
}
