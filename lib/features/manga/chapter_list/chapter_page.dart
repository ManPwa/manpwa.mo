import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/entities/chapter.dart';
import '../../../api/requests/chapter_api.dart';
import '../read_chapter/chapter_image_page.dart';

class ChapterPage extends StatefulWidget {
  static const routeName = 'chapter/list';
  static const routePath = 'chapter';
  static const kMangaIdParam = 'mangaId';

  final String mangaId;

  const ChapterPage({super.key, required this.mangaId});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chapter list"),
          backgroundColor: Colors.white,
        ),
        body: RemoterQuery<List<Chapter>>(
            remoterKey: jsonEncode(['chapter', 'list', widget.mangaId]),
            execute: () async {
              final chapterApi = GetIt.I.get<ChapterApi>();
              final prefs = await SharedPreferences.getInstance();
              String token = prefs.getString('token') ?? '';
              final response =
                  await chapterApi.getChapterList(mangaId: widget.mangaId, token: token);
              return response.toList();
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

              final chapter_list = snapshot.data;
              log(chapter_list.toString());
              if (chapter_list?.isEmpty ?? true) {
                return const Center(
                  child: Text('No manga yet!'),
                );
              }
              List<double> chapter_number_list = [];
              List<Chapter> new_chapter_list = [];
              chapter_list?.forEach((Chapter chapter) {
                if (!chapter_number_list.contains(chapter.chapter)) {
                  new_chapter_list.add(chapter);
                  chapter_number_list.add(chapter.chapter ?? 0);
                }
              });
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  scrollDirection: Axis.vertical,
                  itemCount: new_chapter_list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => {
                              context.pushNamed(
                                ChapterImagePage.routeName,
                                pathParameters: {
                                  ChapterImagePage.kChapterIdParam: new_chapter_list[index].id ?? "",
                                  ChapterPage.kMangaIdParam: widget.mangaId,
                                  // ChapterImagePage.kChapterParam: (new_chapter_list[index].chapter ?? new_chapter_list[index].title)
                                  //             .toString()
                                  //             .replaceAll(regex, '')
                                },
                              )
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Text((() {
                                        String string1 = "";
                                        String string2 = "";
                                        String middleString = "";
                                        if (new_chapter_list[index].chapter !=
                                            null) {
                                          string1 =
                                              "Chapter ${new_chapter_list[index].chapter.toString().replaceAll(regex, '')}";
                                        }
                                        if (new_chapter_list[index].title !=
                                            null) {
                                          string2 =
                                              new_chapter_list[index].title ?? '';
                                        }
                                        if (new_chapter_list[index].chapter !=
                                                null &&
                                            (new_chapter_list[index].title !=
                                                    null &&
                                                new_chapter_list[index].title !=
                                                    "")) {
                                          middleString = ". ";
                                        }
                                        return string1 + middleString + string2;
                                      })(),
                                          style: TextStyle(
                                            color: (() {
                                              if (new_chapter_list[index].read?.length == 0) {
                                                return Colors.black;
                                              } else {
                                                return Theme.of(context).colorScheme.surfaceTint;
                                              }
                                              
                                            }()),
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                    ),
                                    Text(
                                      (() {
                                        final DateFormat formatter =
                                            DateFormat('dd/MM/yyyy');
                                        final String formatted = formatter.format(
                                            new_chapter_list[index].created ??
                                                DateTime.now());
                                        return formatted;
                                      })(),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ]),
                            ),
                            ),
                          const Divider(color: Colors.grey)
                        ],
                      ),
                    );
                  });
            }));
  }
}
