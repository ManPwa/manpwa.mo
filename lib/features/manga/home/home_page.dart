import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:manpwa/features/manga/home/search.dart';
import 'package:manpwa/features/manga/manga_detail/manga_detail_page.dart';
import '../../../api/entities/manga_response.dart';
import '../../../api/requests/manga_api.dart';
import 'drawer.dart';
import 'home_header.dart';
import 'manga_grid_view.dart';
class HomePage extends StatefulWidget {
  static const routeName = 'manga/listing';
  static const routePath = 'manga';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: homeDrawer(context)
      ),
      appBar: AppBar(
          title: const Text('ManPwa'),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search),
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              RemoterQuery<MangaResponse>(
                remoterKey: jsonEncode(['top_rated', 'list']),
                execute: () async {
                  final mangaApi2 = GetIt.I.get<MangaApi>();
                  final response = await mangaApi2.getMangaList(
                      {"limit": 9, "sort": '{"average_rating": -1}'});
                  return response;
                },
                disabled: false,
                builder: (context, snapshot, utils) {
                  if (snapshot.status == RemoterStatus.fetching) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child:
                            const Center(child: CircularProgressIndicator()));
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
                      homeHeader(context, 'Top rated'),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            MangaDetailPage.routeName,
                            pathParameters: {
                              MangaDetailPage.kMangaIdParam:
                                  '${mangaList?.manga_list[currentIndex].id}',
                            },
                          );
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
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
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
                remoterKey: jsonEncode(['updated_manga', 'list']),
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
                        child:
                            const Center(child: CircularProgressIndicator()));
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
                    color: HexColor("#f5f5f5"),
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Column(
                      children: [
                        homeHeader(context, 'Recently Updated'),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: SizedBox(
                            height: 210,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: mangaList?.manga_list.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        MangaDetailPage.routeName,
                                        pathParameters: {
                                          MangaDetailPage.kMangaIdParam:
                                              '${mangaList?.manga_list[index].id}',
                                        },
                                      );
                                    },
                                    child: SizedBox(
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
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
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
                                              mangaList?.manga_list[index]
                                                      .title ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                          ),
                                          Text(
                                            "Chapter ${(mangaList?.manga_list[index].latest_chapter ?? 0).toString().replaceAll(regex, '')}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
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
                remoterKey: jsonEncode(['most_popular', 'list']),
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
                        child:
                            const Center(child: CircularProgressIndicator()));
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
                      homeHeader(context, 'Most following'),
                      mangaGridView(context, mangaList?.manga_list)
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
