import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:manpwa/api/entities/manga.dart';
import 'package:readmore/readmore.dart';

import '../../../api/index.dart';
import '../../../api/requests/manga_api.dart';
import 'chapter_page.dart';

class MangaDetailPage extends StatefulWidget {
  static const routeName = 'manga/detail';
  static const routePath = ':$kMangaIdParam';
  static const kMangaIdParam = 'mangaId';

  final String mangaId;

  const MangaDetailPage({super.key, required this.mangaId});

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   forceMaterialTransparency: true,
        //   scrolledUnderElevation: 250,
        //   automaticallyImplyLeading: false,
        //   leading: IconButton(
        //     color: Colors.white,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(Icons.arrow_back_ios),
        //   ),
        //   backgroundColor: Color.fromARGB(0, 255, 255, 255),
        //   elevation: 0,
        // ),
        body: RemoterQuery<Manga>(
            remoterKey: jsonEncode(['detail_manga', 'item']),
            execute: () async {
              final mangaApi = GetIt.I.get<MangaApi>();
              final response = await mangaApi.getMangaItem(widget.mangaId);
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

              final manga = snapshot.data;
              if (manga == null) {
                return const Center(
                  child: Text('No manga yet!'),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(children: [
                      SizedBox(
                          height: 250,
                          child: Stack(
                            children: [
                              SizedBox(
                                child: CachedNetworkImage(
                                  imageUrl: manga.cover_art_url ?? 'NaN',
                                  fit: BoxFit.contain,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.3),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 100, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: manga.cover_art_url ?? 'NaN',
                              fit: BoxFit.contain,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15.0),
                              width: MediaQuery.of(context).size.width - 190,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    child: Text(
                                      manga.title ?? 'NaN',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        (manga.average_rating ?? "NaN")
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${manga.year ?? 'NaN'}, ${manga.status ?? 'NaN'}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    manga.author ?? 'NaN',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () => {
                                                context.pushNamed(
                                                  ChapterPage.routeName,
                                                  pathParameters: {
                                                    ChapterPage
                                                            .kMangaIdParam:
                                                        widget.mangaId,
                                                  },
                                                )
                                              },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ))),
                                          child: const Text("READ NOW")),
                                      IconButton(
                                        onPressed: () => {print("follow")},
                                        icon: const Icon(
                                            Icons.favorite_border_outlined),
                                        color: const Color.fromARGB(
                                            255, 150, 10, 63),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          ReadMoreText(
                            manga.description ?? 'NaN',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' show more',
                            trimExpandedText: ' show less',
                            moreStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            lessStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Completed Info',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Title',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              manga.title ?? 'NaN',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Tags',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              manga.tags?.join(", ") ?? 'NaN',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Year',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (manga.year ?? 'NaN').toString(),
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Status',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              manga.status ?? 'NaN',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Author',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              manga.author ?? 'NaN',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Demographic',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              manga.demographic ?? 'NaN',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Original language',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              manga.original_language ?? 'NaN',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        )),
                  ],
                ),
              );
            }));
  }
}
