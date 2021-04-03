import 'package:eden/app/app_widget.dart';
import 'package:eden/app/modules/feed/feed_module.dart';
import 'package:eden/app/modules/login/login_module.dart';
import 'package:eden/app/modules/prediction/prediction_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    ...LoginModule().export,
    ...PredictionModule().export,
    ...FeedModule().export
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/login", module: LoginModule()),
    ModularRouter("/feed", module: FeedModule()),
    ModularRouter("/prediction", module: PredictionModule())
  ];

  @override
  Widget get bootstrap => AppWidget();
}