import 'package:go_router/go_router.dart';
import 'package:manpwa/features/todo/pages/manga_detail_page.dart';

import 'pages/index.dart';

GoRoute setupRoutes() {
  return GoRoute(
    name: HomePage.routeName,
    path: HomePage.routePath,
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        name: MangaDetailPage.routeName,
        path: MangaDetailPage.routePath,
        builder: (context, state) {
          final mangaId = state.pathParameters[MangaDetailPage.kMangaIdParam]!;
          return MangaDetailPage(mangaId: mangaId);
        },
      ),
    ],
  );
}
