import 'package:enjoy_android/entity/logout_entity.dart';
import 'package:enjoy_android/widget/sub/login.dart';
import 'package:flutter/material.dart';
import 'package:enjoy_android/global/my_public.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity_factory.dart';
import 'api_service.dart';

const int baseBg = 0xFFECECEC;

myToast(String s){
  BotToast.showText(text: s);
}

goTo(BuildContext context, Widget key){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return key;
  }));
}

goToRm(BuildContext context, Widget key){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_){
    return key;
  }), (route) => route == null);
}

goPop(BuildContext context, Map key){
  Navigator.of(context).pop(key);
}

numStr(int count){
  if(count<11000){
    return count.toString();
  }else if(count<10000*100){
    return (count/10000.0).toStringAsFixed(2)+'万';
  }else{
    return (count/10000.0).toStringAsFixed(1)+'万';
  }
}

logout(BuildContext context){
  ApiService.logout().then((json){
    LogoutEntity entity = EntityFactory.generateOBJ(json);
    if(entity.errorCode == 0){
      SPKey.spSetStr(SPKey.USER_NAME, '');
      SPKey.spSetStr(SPKey.PASS_WORD, '');
      SPKey.spSetStr(SPKey.COOKIE, '');
      SPKey.spSetBool(SPKey.IS_LOGIN, false);
      goToRm(context, Login());
    }else{
      myToast(entity.errorMsg);
    }
  });
}
