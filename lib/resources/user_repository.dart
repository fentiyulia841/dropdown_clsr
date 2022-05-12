import 'package:dropdwon_clsr/models/user_model.dart';
import 'user_provider.dart';

class UserRepository {
  final _provider = UserProvider();

  
  Future<UserModel> fetchUserList() {
    return _provider.fetchUserList();
  }
}

class NetworkError extends Error {
  
}
