import 'package:go_router/go_router.dart';
import 'package:manpwa/features/manga/chapter_list/chapter_page.dart';
import 'package:manpwa/features/manga/manga_detail/manga_detail_page.dart';

import '../auth/pages/login_page.dart';
import '../auth/pages/register_page.dart';
import 'manga_list/manga_list_page.dart';
import 'read_chapter/chapter_image_page.dart';
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
              final mangaId = state.pathParameters[ChapterPage.kMangaIdParam]!;
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
      GoRoute(
        name: MangaListPage.routeName,
        path: MangaListPage.routePath,
        builder: (context, state) {
          final mangaListType =
              state.pathParameters[MangaListPage.kMangaListTypeParam]!;
          return MangaListPage(mangaListType: mangaListType);
        },
      ),
      GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.routePath,
          builder: (context, state) {
            return const LoginPage();
          },
          routes: [
            GoRoute(
              name: RegisterPage.routeName,
              path: RegisterPage.routePath,
              builder: (context, state) {
                return const RegisterPage();
              },
            ),
          ]),
    ],
  );
}
