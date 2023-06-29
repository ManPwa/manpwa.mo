import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/entities/manga_response.dart';
import '../../../api/requests/manga_api.dart';
import '../home/manga_grid_view.dart';

class MangaListPage extends StatefulWidget {
  static const routeName = 'manga/list';
  static const routePath = ':$kMangaListTypeParam/list';
  static const kMangaListTypeParam = 'mangaListType';

  final String mangaListType;

  const MangaListPage({super.key, required this.mangaListType});

  @override
  State<MangaListPage> createState() => _MangaListPageState();
}

class _MangaListPageState extends State<MangaListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.mangaListType),
          backgroundColor: Colors.white,
        ),
        body: RemoterQuery<MangaResponse>(
                remoterKey: jsonEncode(['manga', 'list', widget.mangaListType]),
                execute: () async {
                  final mangaApi = GetIt.I.get<MangaApi>();
                  String sort = "_created";
                  switch (widget.mangaListType) {
                    case "Most following":
                      sort = "following";
                      break;
                    case "Top rated": 
                      sort = "average_rating";
                      break;
                    case "Recently Updated":
                      sort = "_updated";
                      break;
                    case "Following":
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('token') ?? '';
                      final response = await mangaApi
                          .getFollowingMangaList(token: token);
                      return response;
                    case "Recommends for you":
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('token') ?? '';
                      final response = await mangaApi.getMangaList(
                          {"limit": 9, "sort": '{"average_rating": -1}'},
                          token: token);
                      return response;
                  }
                  final response = await mangaApi
                      .getMangaList({"limit": 24, "sort": '{"$sort": -1}'});
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
                      child: Text('No manga'),
                    );
                  }
              return mangaGridView(context, mangaList?.manga_list);
            }
        )
    );
  }
}