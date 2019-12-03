import 'package:enjoy_android/entity/fail_entity.dart';
import 'package:enjoy_android/entity/home_article_entity.dart';
import 'package:enjoy_android/entity/home_banner_entity.dart';
import 'package:enjoy_android/entity/login_entity.dart';
import 'package:enjoy_android/entity/register_entity.dart';
import 'package:enjoy_android/entity/system_sub_entity.dart';
import 'package:enjoy_android/entity/system_tree_entity.dart';

import 'entity/navigate_entity.dart';
import 'entity/project_entity.dart';
import 'entity/project_tab_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "FailEntity") {
      return FailEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeArticleEntity") {
      return HomeArticleEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeBannerEntity") {
      return HomeBannerEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == "RegisterEntity") {
      return RegisterEntity.fromJson(json) as T;
    } else if (T.toString() == "SystemSubEntity") {
      return SystemSubEntity.fromJson(json) as T;
    } else if (T.toString() == "SystemTreeEntity") {
      return SystemTreeEntity.fromJson(json) as T;
    } else if (T.toString() == "NavigateEntity") {
      return NavigateEntity.fromJson(json) as T;
    }else if (T.toString() == "ProjectTabEntity") {
      return ProjectTabEntity.fromJson(json) as T;
    }else if (T.toString() == "ProjectEntity") {
      return ProjectEntity.fromJson(json) as T;
    }else {
      return null;
    }
  }
}