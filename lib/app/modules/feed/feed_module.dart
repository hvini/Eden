import 'package:eden/app/modules/feed/data/datasource/feed_datasource_impl.dart';
import 'package:eden/app/modules/feed/data/repositories/feed_repository_impl.dart';
import 'package:eden/app/modules/feed/domain/usecases/get_user_predictions.dart';
import 'package:eden/app/modules/feed/domain/usecases/image_pick.dart';
import 'package:eden/app/modules/feed/domain/usecases/sign_out.dart';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_controller.dart';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => ImagePickImpl(i())),
    Bind((i) => FeedRepositoryImpl(i())),
    Bind((i) => GetUserPredictionsImpl(i())),
    Bind((i) => FeedDataSourceImpl()),
    Bind((i) => SignOutImpl(i())),
  ];

  List<Bind> export = [
    $FeedController
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/", child: (context, args) => FeedPage(uid: args.data['uid']))
  ];
}