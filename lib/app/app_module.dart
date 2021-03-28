import 'package:eden/app/app_widget.dart';
import 'package:eden/app/modules/login/login_module.dart';
import 'package:eden/app/modules/login/presentation/pages/feedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    ...LoginModule().export
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/login", module: LoginModule()),
    ModularRouter("/feed/:uid", child: (_,args) => FeedScreen(uid: args.params['uid']))
  ];

  @override
  Widget get bootstrap => AppWidget();
}