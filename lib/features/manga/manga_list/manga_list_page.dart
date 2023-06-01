import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../api/entities/manga_response.dart';
import '../../../api/requests/manga_api.dart';
import '../home/manga_grid_view.dart';
import '../home/manga_grid_view_item.dart';
import '../manga_detail/manga_detail_page.dart';

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
          automaticallyImplyLeading: false,
          title: Text(widget.mangaListType),
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.white,
        ),
        body: RemoterQuery<MangaResponse>(
                remoterKey: jsonEncode(['manga', 'list', widget.mangaListType]),
                execute: () async {
                  final mangaApi3 = GetIt.I.get<MangaApi>();
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
                  }
                  final response = await mangaApi3
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
                      child: Text('No todo yet!'),
                    );
                  }
              return mangaGridView(context, mangaList?.manga_list);
            }
        )
    );
  }
}