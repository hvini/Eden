import 'package:eden/app/modules/feed/presentation/pages/feed_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedModule extends ChildModule {
  @override
  List<Bind> get binds => [

  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/:uid", child: (context, args) => FeedPage(uid: args.params['uid']))
  ];
}