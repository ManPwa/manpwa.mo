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
        onTap: () async {},
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

ListView authorizedDrawer(BuildContext context, User user, RemoterQueryUtils<RemoterData<User>> utils) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: Text(user.username ?? ''),
        accountEmail: Text(user.email ?? ''),
        currentAccountPictureSize: const Size.square(70.0), 
        currentAccountPicture: CachedNetworkImage(
          imageUrl: user.avatar_url ?? 'NaN',
          fit: BoxFit.contain,
          imageBuilder: (context, imageProvider) => Container(
            color: Colors.white,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) {
            return const Center(child: CircularProgressIndicator());
          },
          errorWidget: (context, url, error) => const CircleAvatar(
            backgroundImage: AssetImage('assets/default_user.jpg'),
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.person_rounded),
        title: const Text('Profile'),
        onTap: () async {
          
        },
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
        onTap: () async {},
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