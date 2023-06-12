import 'package:get_it/get_it.dart';

import '../api/index.dart';
import '../api/requests/chapter_api.dart';
import '../api/requests/chapter_image_api.dart';
import '../api/requests/comment_api.dart';
import '../api/requests/follow_api.dart';
import '../api/requests/manga_api.dart';
import '../api/requests/rating_api.dart';
import '../api/requests/user_api.dart';
import '../lib_wrappers/index.dart';
import 'env.dart';

void setupAccess() {
  GetIt.I.registerSingleton<NetworkAccess>(
    NetworkAccess(
      EnvVariables.kAPIBaseUrl,
      getCustomHeaders: () {
        // get refresh_token or cookie here through shared_preferences
        return {};
      },
    ),
    instanceName: 'normal',
  );
  GetIt.I.registerSingleton<NetworkAccess>(
    NetworkAccess(
      EnvVariables.kAPIBaseUrl,
      getCustomHeaders: () {
        // get refresh_token or cookie here through shared_preferences
        return {};
      },
    ),
    instanceName: 'auth',
  );
}

void setupApis() {
  GetIt.I.registerSingleton<TodoApi>(
    TodoApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
  GetIt.I.registerSingleton<MangaApi>(
    MangaApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
  GetIt.I.registerSingleton<ChapterApi>(
    ChapterApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
  GetIt.I.registerSingleton<ChapterImageApi>(
    ChapterImageApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
  GetIt.I.registerSingleton<UserApi>(
    UserApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
  GetIt.I.registerSingleton<FollowApi>(
    FollowApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
  GetIt.I.registerSingleton<RatingApi>(
    RatingApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
  GetIt.I.registerSingleton<CommentApi>(
    CommentApi(
      access: GetIt.I.get<NetworkAccess>(instanceName: 'normal'),
    ),
  );
}

void setupServiceLocators() {
  setupAccess();
  setupApis();
}
