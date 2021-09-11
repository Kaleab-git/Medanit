library my_prj.globals;

import 'package:localstorage/localstorage.dart';

import 'User/user.dart';

final storage = new LocalStorage('my_data.json');

late User user;

late String token;
