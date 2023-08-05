import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:manpwa/api/entities/chapter_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/requests/chapter_image_api.dart';

class ChapterImagePage extends StatefulWidget {
  static const routeName = 'image/list';
  static const routePath = ':$kChapterIdParam';
  static const kChapterIdParam = 'chapterId';

  final String chapterId;

  const ChapterImagePage({super.key, required this.chapterId});

  @override
  State<ChapterImagePage> createState() => _ChapterImagePageState();
}

class _ChapterImagePageState extends State<ChapterImagePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
            ),
          ];
        },
        body: RemoterQuery<List<ChapterImage>>(
            remoterKey: jsonEncode(['chapter-image', 'list', widget.chapterId]),
            execute: () async {
              final imageApi = GetIt.I.get<ChapterImageApi>();
              final prefs = await SharedPreferences.getInstance();
              String token = prefs.getString('token') ?? '';
              final response = await imageApi.getChapterImageList(
                  chapterId: widget.chapterId);
              try {
                await imageApi.readChapter(
                    chapterId: widget.chapterId, token: token);
              } catch (e) {

              }
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

              final image_list = snapshot.data;
              if (image_list?.isEmpty ?? true) {
                return const Center(
                  child: Text('Can\'t load this chapter'),
                );
              }
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: image_list!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == image_list.length) {
                      return Container(
                        height: 50,
                        color: Colors.white,
                        child: const Center(
                          child: Text("End of chapter"),
                        ),
                      );
                    } else {
                      return CachedNetworkImage(
                        imageUrl: image_list[index].image_url ?? 'N/A',
                        placeholder: (context, url) {
                          return const SizedBox(
                              height: 200,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        },
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    }
                  });
            }),
      )),
    );
  }
}
