import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:manpwa/features/todo/pages/todo_detail_page.dart';

import '../../../api/entities/manga.dart';
import '../../../api/entities/manga_response.dart';
import '../../../api/index.dart';
import '../../../api/requests/manga_api.dart';

class TodoListingPage extends StatefulWidget {
  static const routeName = 'todo/listing';
  static const routePath = 'todo';

  const TodoListingPage({super.key});

  @override
  State<TodoListingPage> createState() => _TodoListingPageState();
}

class _TodoListingPageState extends State<TodoListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todo List'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: RemoterQuery<MangaResponse>(
        remoterKey: jsonEncode(['todo', 'list']),
        execute: () async {
          final todoApi = GetIt.I.get<MangaApi>();
          final response = await todoApi.getMangaList();
          return response;
        },
        disabled: false,
        builder: (context, snapshot, utils) {
          if (snapshot.status == RemoterStatus.fetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
          print(mangaList);
          return CarouselSlider(
            items: mangaList?.manga_list.map((item) => Container(
              width: 500,
              height: 100,
              child: Center(
                child: CachedNetworkImage(
                    imageUrl: item.cover_art_url ?? '',
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ))
            .toList(),
            options: CarouselOptions(
                height: 400,
                aspectRatio: 16/9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
            )
          );
        },
      ),
    );
  }
}
