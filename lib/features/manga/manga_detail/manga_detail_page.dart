import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:manpwa/api/entities/manga.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/entities/follow.dart';
import '../../../api/entities/rating.dart';
import '../../../api/requests/follow_api.dart';
import '../../../api/requests/manga_api.dart';
import '../../../api/requests/rating_api.dart';
import '../chapter_list/chapter_page.dart';
import '../comment_list/comment_list_page.dart';

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
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
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
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          child: ElevatedButton(
              onPressed: () => {
                    context.pushNamed(
                      ChapterPage.routeName,
                      pathParameters: {
                        ChapterPage.kMangaIdParam: widget.mangaId,
                      },
                    )
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surfaceTint,
              ),
              child: const Text(
                "READ NOW",
                style: TextStyle(color: Colors.white),
              )),
        ),
        body: RemoterQuery<Manga>(
            remoterKey: jsonEncode(['detail_manga', 'item', widget.mangaId]),
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
                                  imageUrl: manga.cover_art_url ?? 'N/A',
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
                              imageUrl: manga.cover_art_url ?? 'N/A',
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
                                  const Icon(Icons.error),
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
                                      manga.title ?? 'N/A',
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
                                        ((manga.average_rating ?? "N/A")
                                                .toString()
                                                .replaceAll(regex, ''))
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${manga.year ?? 'N/A'}, ${manga.status ?? 'N/A'}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    manga.author ?? 'N/A',
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
                                      Expanded(
                                        child: Container(
                                            child: follow(widget.mangaId)),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Container(
                                            child: rating(widget.mangaId)),
                                      ),
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
                            manga.description ?? 'N/A',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                            trimLines: 3,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' show more',
                            trimExpandedText: ' show less',
                            moreStyle: const TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                            lessStyle: const TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              manga.title ?? 'N/A',
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
                              manga.tags?.join(", ") ?? 'N/A',
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
                              (manga.year ?? 'N/A').toString(),
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
                              manga.status ?? 'N/A',
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
                              manga.author ?? 'N/A',
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
                              manga.demographic ?? 'N/A',
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
                              manga.original_language ?? 'N/A',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        )),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Comments",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  CommentListPage.routeName,
                                  pathParameters: {
                                    CommentListPage.kMangaIdParam: widget.mangaId,
                                  },
                                );
                              },
                              child: const Row(
                                children: [
                                  Text('Read comments',
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
                          ],
                        ))
                  ],
                ),
              );
            }));
  }

  Widget follow(String mangaId) {
    return RemoterQuery<Follow>(
        remoterKey: jsonEncode(['follow', 'item', mangaId]),
        execute: () async {
          final followApi = GetIt.I.get<FollowApi>();
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
          final response =
              await followApi.getFollowItem(mangaId: mangaId, token: token);
          return response;
        },
        disabled: false,
        builder: (context, snapshot, utils) {
          if (snapshot.status == RemoterStatus.fetching) {
            return ElevatedButton(
              onPressed: () => {},
              child: const SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            );
          }
          if (snapshot.status == RemoterStatus.error) {
            return followButton(mangaId, utils);
          }

          final follow = snapshot.data;
          if (follow == null || follow.is_following == false) {
            return followButton(mangaId, utils);
          }
          return ElevatedButton(
            onPressed: () => {followManga(mangaId, utils)},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_rounded, color: Colors.white),
              ],
            ),
          );
        });
  }

  ElevatedButton followButton(
      String mangaId, RemoterQueryUtils<RemoterData<Follow>> utils) {
    return ElevatedButton(
      onPressed: () => {followManga(mangaId, utils)},
      // style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_rounded, color: Colors.red),
        ],
      ),
    );
  }

  void followManga(
      String mangaId, RemoterQueryUtils<RemoterData<Follow>> utils) async {
    final followApi = GetIt.I.get<FollowApi>();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    try {
      await followApi.followManga(mangaId: mangaId, token: token);
      utils.refetch();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Login to follow this manga",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(166, 0, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget rating(String mangaId) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return RemoterQuery<Rating>(
        remoterKey: jsonEncode(['rating', 'item', mangaId]),
        execute: () async {
          final ratingApi = GetIt.I.get<RatingApi>();
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
          final response =
              await ratingApi.getRatingItem(mangaId: mangaId, token: token);
          return response;
        },
        disabled: false,
        builder: (context, snapshot, utils) {
          if (snapshot.status == RemoterStatus.fetching) {
            return ElevatedButton(
              onPressed: () => {},
              child: const SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            );
          }
          if (snapshot.status == RemoterStatus.error) {
            return ratingButton(context, mangaId, utils);
          }

          final rating = snapshot.data;
          if (rating == null) {
            return ratingButton(context, mangaId, utils);
          }
          return ElevatedButton(
            onPressed: () => {ratingList(context, mangaId, utils)},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 219, 0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star_rounded, color: Colors.white),
                const SizedBox(width: 5),
                Text(rating.rating.toString().replaceAll(regex, ''),
                    style: const TextStyle(color: Colors.white))
              ],
            ),
          );
        });
  }

  ElevatedButton ratingButton(BuildContext context, String mangaId,
      RemoterQueryUtils<RemoterData<Rating>> utils) {
    return ElevatedButton(
      onPressed: () => {ratingList(context, mangaId, utils)},
      child: const Icon(Icons.star_rounded,
          color: Color.fromARGB(255, 243, 219, 0)),
    );
  }

  void ratingList(BuildContext context, String mangaId,
      RemoterQueryUtils<RemoterData<Rating>> utils) {
    List<String> rating = [
      "(1) Appalling",
      "(2) Horrible",
      "(3) Very Bad",
      "(4) Bad",
      "(5) Average",
      "(6) Fine",
      "(7) Good",
      "(8) Very Good",
      "(9) Great",
      "(10) Masterpiece"
    ];
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            content: SizedBox(
                width: MediaQuery.of(context).size.height * 0.75,
                child: SingleChildScrollView(
                  child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: rating.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => {
                            rateManga(mangaId, index + 1, utils),
                            Navigator.pop(context)
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(rating[index],
                                style: const TextStyle(fontSize: 19)),
                          ),
                        );
                      }),
                ))),
        barrierDismissible: true);
  }

  void rateManga(String mangaId, int rating,
      RemoterQueryUtils<RemoterData<Rating>> utils) async {
    final ratingApi = GetIt.I.get<RatingApi>();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    try {
      await ratingApi.ratingManga(
          mangaId: mangaId, token: token, rating: rating);
      utils.refetch();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Login to rate this manga",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(166, 0, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
