import 'package:enjoy_android/entity/fail_entity.dart';
import 'package:enjoy_android/entity/home_banner_entity.dart';
import 'package:enjoy_android/entity/login_entity.dart';
import 'package:enjoy_android/entity/register_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "FailEntity") {
      return FailEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeBannerEntity") {
      return HomeBannerEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == "RegisterEntity") {
      return RegisterEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}