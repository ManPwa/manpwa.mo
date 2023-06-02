import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';

import '../../../api/entities/manga_response.dart';
import '../../../api/requests/manga_api.dart';
import 'manga_grid_view.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search";
  @override
  TextStyle get searchFieldStyle =>
      const TextStyle(fontWeight: FontWeight.normal, color: Colors.black);
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle:
              TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
          border: InputBorder.none,
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.grey));
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    if (query == "") {
      return SizedBox();
    } else {
      return RemoterQuery<MangaResponse>(
        remoterKey: jsonEncode(['most_popular', 'list', query]),
        execute: () async {
          final mangaApi3 = GetIt.I.get<MangaApi>();
          final response =
              await mangaApi3.getMangaList({"limit": 24, "title": query});
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
            final error = snapshot.error;
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () {
                      utils.retry();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          final mangaList = snapshot.data;
          if ((mangaList?.manga_list)?.isEmpty ?? true) {
            return const Center(
              child: Text('Manga not found'),
            );
          }
          return SingleChildScrollView(
            child: mangaGridView(context, mangaList?.manga_list),
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('');
  }
}
