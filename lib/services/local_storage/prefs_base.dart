import 'package:shared_preferences/shared_preferences.dart';

///Base class for shared preferences methods
///This class provides low level preferences methods
class PrefsBase{
  ///Instance of shared preferences
  static SharedPreferences? _sharedPrefs;

  ///Singleton instance of Preferences Helper
  static PrefsBase? _instance;

  ///Private constructor
  const PrefsBase._();

  ///Get instance of this class
  static PrefsBase get instance =>  _instance ?? const PrefsBase._();

  ///Initializer for shared prefs
  ///Should be called in main before runApp and
  ///after WidgetsBinding.FlutterInitialized()
  static Future<void> init() async {
    if(_sharedPrefs == null ) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  ///Loads value for the key from preferences
  T? get<T>(String key) {
    switch(T){
      case String: return _sharedPrefs!.getString(key) as T?;
      case int: return _sharedPrefs!.getInt(key)  as T?;
      case bool: return _sharedPrefs!.getBool(key)  as T?;
      case double: return _sharedPrefs!.getDouble(key)  as T?;
      default: return _sharedPrefs!.getString(key)  as T?;
    }
  }

  ///Sets the value for the key to preferences
  Future<bool> set<T>(String key, T value) {
    switch(T){
      case String: return _sharedPrefs!.setString(key, value as String);
      case int: return _sharedPrefs!.setInt(key, value as int);
      case bool: return _sharedPrefs!.setBool(key, value as bool);
      case double: return _sharedPrefs!.setDouble(key, value as double);
      default: return _sharedPrefs!.setString(key, value as String);
    }
  }

  ///Resets preferences
  void clear() => _sharedPrefs!.clear();
}
