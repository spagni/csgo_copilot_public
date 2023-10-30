import 'package:csgo_copilot/domain/repositories/auth_repository.dart';
import 'package:csgo_copilot/utils/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> isUserLoggedIn() {
    try {
      String value =
          Preferences.getStringValueByType(PreferenceTypes.USER_STEAM_ID);
      bool _isLoggedIn = value?.isNotEmpty ?? false;

      return Future.value(_isLoggedIn);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
