import 'package:fetch_api_flutter/models/user.dart';
import 'package:fetch_api_flutter/services/user_service.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  final int _limit = 15;
  int _skip = 0;
  bool hasMore = true;
  List<User> users = [];

  Future fetchUser() async {
    try {
      List<User> response = await _userService.getUser(_limit, _skip);

      if (response.length < _limit) {
        hasMore = false;
      }

      users.addAll(response);
      _skip += 15;

      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refresh() async {
    _skip = 0;
    hasMore = true;
    users = [];

    await fetchUser();

    notifyListeners();
  }
}
