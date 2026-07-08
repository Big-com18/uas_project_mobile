import '../data/dummy_users.dart';
import '../model/user_model.dart';

class AuthService {
  /// Returns the matching UserModel if credentials are correct,
  /// otherwise returns null.
  UserModel? login(String email, String password) {
    try {
      return dummyUsers.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }
}
