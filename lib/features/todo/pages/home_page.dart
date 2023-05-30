import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:manpwa/features/todo/pages/todo_detail_page.dart';

import '../../../api/entities/manga.dart';
import '../../../api/entities/manga_response.dart';
import '../../../api/index.dart';
import '../../../api/requests/manga_api.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'todo/listing';
  static const routePath = 'todo';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Manpwa'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              RemoterQuery<MangaResponse>(
                remoterKey: jsonEncode(['top_rated', 'list']),
                execute: () async {
                  final mangaApi2 = GetIt.I.get<MangaApi>();
                  final response = await mangaApi2.getMangaList(
                      {"limit": 8, "sort": '{"average_rating": -1}'});
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
                  return Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Top rated',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
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
                                    margin: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 10.0,
                                        bottom: 10.0),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: item.cover_art_url ?? '',
                                          fit: BoxFit.contain,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
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
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        ClipRRect(
                                          // Clip it cleanly.
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.3),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 215,
                                                  margin: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(item.title ?? '',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              item.tags?.join(
                                                                      ", ") ??
                                                                  '',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Description",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                              item.description ??
                                                                  '',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 4),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 15.0,
                                                      right: 15.0,
                                                      top: 15.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        item.cover_art_url ??
                                                            '',
                                                    fit: BoxFit.contain,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      width: 120,
                                                      height: 180,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10)),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) {
                                                      return const Center(
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
              const SizedBox(height: 20),
              RemoterQuery<MangaResponse>(
                remoterKey: jsonEncode(['updated_manga', 'list1']),
                execute: () async {
                  final mangaApi = GetIt.I.get<MangaApi>();
                  final response = await mangaApi
                      .getMangaList({"limit": 15, "sort": '{"_updated": -1}'});
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
                  return Container(
                    color: HexColor("#f0f0f0"),
                    padding: const EdgeInsets.only(bottom: 5.0, top: 20.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Recently Updated',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: SizedBox(
                            height: 210,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: mangaList?.manga_list.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: 130,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 15.0, bottom: 10.0),
                                          child: CachedNetworkImage(
                                            imageUrl: mangaList
                                                    ?.manga_list[index]
                                                    .cover_art_url ??
                                                '',
                                            fit: BoxFit.contain,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 180,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3), // changes position of shadow
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 110,
                                          child: Text(
                                            mangaList
                                                    ?.manga_list[index].title ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          "Chapter ${(mangaList?.manga_list[index].latest_chapter ?? 0).toStringAsFixed(0)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              RemoterQuery<MangaResponse>(
                remoterKey: jsonEncode(['most_popular', 'list3']),
                execute: () async {
                  final mangaApi3 = GetIt.I.get<MangaApi>();
                  final response = await mangaApi3
                      .getMangaList({"limit": 9, "sort": '{"following": -1}'});
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text('Most following',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: SingleChildScrollView(
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 0.6),
                              itemCount: mangaList?.manga_list.length,
                              itemBuilder: (BuildContext c, int index) {
                                return Container(
                                  height: 180,
                                  margin: const EdgeInsets.only(
                                      bottom: 15.0, right: 15.0, top: 15.0),
                                  child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: mangaList?.manga_list[index]
                                                  .cover_art_url ??
                                              '',
                                          fit: BoxFit.contain,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 120,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        Container(
                                          height: 45,
                                          child: Stack(children: [
                                            ClipRRect(
                                              // Clip it cleanly.
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10)),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                            ),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7, right: 7),
                                                  child: Text(
                                                      mangaList
                                                              ?.manga_list[
                                                                  index]
                                                              .title ??
                                                          '',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                ))
                                          ]),
                                        ),
                                      ]),
                                );
                              }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
