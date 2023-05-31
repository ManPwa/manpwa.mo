import 'package:go_router/go_router.dart';
import 'package:manpwa/features/manga/home/chapter_page.dart';
import 'package:manpwa/features/manga/home/manga_detail_page.dart';

import 'home/chapter_image_page.dart';
import 'home/index.dart';

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
        routes: [
          GoRoute(
            name: ChapterPage.routeName,
            path: ChapterPage.routePath,
            builder: (context, state) {
              final mangaId =
                  state.pathParameters[ChapterPage.kMangaIdParam]!;
              return ChapterPage(mangaId: mangaId);
            },
            routes: [
              GoRoute(
                name: ChapterImagePage.routeName,
                path: ChapterImagePage.routePath,
                builder: (context, state) {
                  final chapterId =
                      state.pathParameters[ChapterImagePage.kChapterIdParam]!;
                  return ChapterImagePage(chapterId: chapterId);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
