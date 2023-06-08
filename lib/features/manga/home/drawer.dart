import 'dart:convert';

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
        ;
        final user = snapshot.data;
        if (user == null) {
          return const Center(
            child: Text('User not found!'),
          );
        }
        return authorizedDrawer(context);
      });
}

ListView unauthorizedDrawer(BuildContext context) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Drawer Header'),
      ),
      ListTile(
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

ListView authorizedDrawer(BuildContext context) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Drawer Header'),
      ),
      ListTile(
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
        title: const Text('Logout'),
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', "");
        },
      ),
    ],
  );
}