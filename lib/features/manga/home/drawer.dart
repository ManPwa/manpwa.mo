import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/entities/user.dart';
import '../../../api/requests/user_api.dart';
import '../../auth/pages/login_page.dart';
import '../manga_list/manga_list_page.dart';

Widget homeDrawer(BuildContext context) {
  return RemoterQuery<User>(
      options: RemoterOptions(maxRetries: 0, retryOnMount: false),
      remoterKey: jsonEncode(['user', 'item']),
      execute: () async {
        final userApi = GetIt.I.get<UserApi>();
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';
        final response = await userApi.getCurrentUser(token: token);
        return response;
      },
      disabled: false,
      builder: (context, snapshot, utils) {
        if (snapshot.status == RemoterStatus.fetching) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()));
        }
        if (snapshot.status == RemoterStatus.error) {
          return unauthorizedDrawer(context);
        }

        final user = snapshot.data;
        if (user == null) {
          return const Center(
            child: Text('User not found!'),
          );
        }
        return authorizedDrawer(context, user, utils);
      });
}

ListView unauthorizedDrawer(BuildContext context) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      const UserAccountsDrawerHeader(
        accountName: Text(''),
        accountEmail: Text('Welcome ╰(￣ω￣ｏ)'),
      ),
      ListTile(
        leading: const Icon(Icons.account_box_rounded),
        title: const Text('About'),
        onTap: () async {
          showAbout(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.login_rounded),
        title: const Text('Login'),
        onTap: () {
          context.pushNamed(
            LoginPage.routeName,
          );
        },
      ),
    ],
  );
}

ListView authorizedDrawer(BuildContext context, User user,
    RemoterQueryUtils<RemoterData<User>> utils) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: Text(user.username ?? ''),
        accountEmail: Text(user.email ?? ''),
        currentAccountPictureSize: const Size.square(70.0),
        currentAccountPicture: CircleAvatar(
          child: ClipOval(
            child: Image.network(
              user.avatar_url ??
                  "https://res.cloudinary.com/dt9bzvzw9/image/upload/v1686499661/default_user_anvydm.png",
              fit: BoxFit.cover,
              width: 90,
              height: 90,
            ),
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.person_rounded),
        title: const Text('Profile'),
        onTap: () async {},
      ),
      ListTile(
        leading: const Icon(Icons.favorite_rounded),
        title: const Text('Following'),
        onTap: () async {
          context.pushNamed(
            MangaListPage.routeName,
            pathParameters: {
              MangaListPage.kMangaListTypeParam: "Following",
            },
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.account_box_rounded),
        title: const Text('About'),
        onTap: () async {
          showAbout(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout_rounded),
        title: const Text('Logout'),
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', "");
          utils.refetch();
        },
      ),
    ],
  );
}

void showAbout(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("About"),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Creator: Do Thanh Long."),
                  SizedBox(height: 10),
                  Text("Thanks to Nguyen Quang An, Dang Cong Khai Thu, Huynh Vu Minh Nguyet and Duong Xuan Ngoc Phong for supporting me develop this app (～￣▽￣)～."),
                  SizedBox(height: 10),
                  Text(
                      "All manga, chapter, image of this app belongs to MangaDex."),
                  SizedBox(height: 15),
                  Center(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/mangadex.png'),
                          fit: BoxFit.cover,
                          height: 75,
                          width: 75,
                        ),
                        SizedBox(height: 5),
                        Text("https://mangadex.org"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
      barrierDismissible: true);
}
