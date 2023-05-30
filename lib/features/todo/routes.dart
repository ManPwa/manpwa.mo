import 'package:go_router/go_router.dart';
import 'package:manpwa/features/todo/pages/todo_detail_page.dart';

import 'pages/index.dart';

GoRoute setupRoutes() {
  return GoRoute(
    name: HomePage.routeName,
    path: HomePage.routePath,
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        name: TodoDetailPage.routeName,
        path: TodoDetailPage.routePath,
        builder: (context, state) {
          final todoId = state.pathParameters[TodoDetailPage.kTodoIdParam]!;
          return TodoDetailPage(todoId: todoId);
        },
      ),
    ],
  );
}
