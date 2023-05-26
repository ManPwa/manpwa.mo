import 'package:go_router/go_router.dart';
import 'package:manpwa/features/todo/pages/todo_detail_page.dart';

import 'pages/index.dart';

GoRoute setupRoutes() {
  return GoRoute(
    name: TodoListingPage.routeName,
    path: TodoListingPage.routePath,
    builder: (context, state) => const TodoListingPage(),
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
