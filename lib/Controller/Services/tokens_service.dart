import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class TokenController {
  static final TokenController _instance = TokenController._internal();
  // late Box<dynamic> box;
  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory TokenController() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  TokenController._internal() {
    // initialization logic
  }
  void doSomething() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentDirectory.path);
  }

  void setopend(String value) async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentDirectory.path);
    await Hive.openBox('myBox');
    var box = Hive.box('myBox');

    box.put('opstate', '$value');

    var name = box.get('opstate');

    print('opstate: $name');
  }

  Future<String?> getopend() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentDirectory.path);

    await Hive.openBox('myBox');
    var box = Hive.box('myBox');

    var name = box.get('opstate');

    box = Hive.box('myBox');
    print('opstate: $name');
    return name;
  }
}
