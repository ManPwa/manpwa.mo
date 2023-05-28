import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Manpwa'),
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
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Top rated manga',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                    GestureDetector(
                      onTap: () {
                        print("Show more was tapped");
                      },
                      child: Container(
                        child: const Row(
                          children: [
                            Text('Show more',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 13.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Container was tapped");
                },
                child: CarouselSlider(
                    items: mangaList?.manga_list
                        .map(
                          (item) => Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: item.cover_art_url ?? '',
                                  fit: BoxFit.contain,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                ClipRRect(
                                  // Clip it cleanly.
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.3),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 215,
                                          margin: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(item.title ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                      item.tags?.join(", ") ??
                                                          '',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Description",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(item.description ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 4),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 15.0,
                                              right: 15.0,
                                              top: 15.0),
                                          child: CachedNetworkImage(
                                            imageUrl: item.cover_art_url ?? '',
                                            fit: BoxFit.contain,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 120,
                                              height: 180,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    )),
              ),
              DotsIndicator(
                dotsCount: mangaList?.manga_list.length ?? 0,
                position: currentIndex,
              )
            ],
          );
        },
      ),
    );
  }
}
