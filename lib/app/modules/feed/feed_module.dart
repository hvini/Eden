import 'package:eden/app/modules/feed/data/repositories/feed_repository_impl.dart';
import 'package:eden/app/modules/feed/domain/usecases/gallery_pick.dart';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_controller.dart';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => GalleryPickImpl(i())),
    Bind((i) => FeedRepositoryImpl())
  ];

  List<Bind> export = [
    $FeedController
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/", child: (context, args) => FeedPage(uid: args.data['uid']))
  ];
}