import 'package:cleanarch/features/post/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {

  static GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) => const PostListScreen(),
      ),

      GoRoute(
        path: "/create-post",
        builder: (context, state) => const CreatePostScreen(),
      )

    ]
  );

}