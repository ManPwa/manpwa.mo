import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/entities/comment.dart';
import '../../../api/entities/manga_response.dart';
import '../../../api/requests/comment_api.dart';
import '../../../api/requests/manga_api.dart';
import '../home/manga_grid_view.dart';

class CommentListPage extends StatefulWidget {
  static const routeName = 'comment/list';
  static const routePath = 'comment';
  static const kMangaIdParam = 'mangaId';

  final String mangaId;

  const CommentListPage({super.key, required this.mangaId});

  @override
  State<CommentListPage> createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: RemoterQuery<List<Comment>>(
              remoterKey: jsonEncode(['comment', 'list', widget.mangaId]),
              execute: () async {
                final commentApi = GetIt.I.get<CommentApi>();
                final response =
                    await commentApi.getCommentList(mangaId: widget.mangaId);
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

                final comment_list = snapshot.data;
                if (comment_list?.isEmpty ?? true) {
                  return Column(
                    children: [
                      commentField(widget.mangaId, utils),
                      const SizedBox(height: 300),
                      const Text('No comment yet!'),
                    ],
                  );
                }

                return Column(children: [
                  commentField(widget.mangaId, utils),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: comment_list?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.all(15),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          comment_list?[index]
                                                  .user
                                                  ?.avatar_url ??
                                              "https://res.cloudinary.com/dt9bzvzw9/image/upload/v1686499661/default_user_anvydm.png",
                                          fit: BoxFit.cover,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                          comment_list?[index].user?.username ??
                                              'N/A',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceTint,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2)
                                    ]),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (() {
                                        final DateFormat formatter =
                                            DateFormat('dd/MM/yyyy');
                                        final String formatted =
                                            formatter.format(
                                                comment_list?[index].created ??
                                                    DateTime.now());
                                        return formatted;
                                      })(),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const Divider(color: Colors.grey),
                                    ReadMoreText(
                                      comment_list?[index].content ?? 'N/A',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 13),
                                      trimLines: 4,
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
                            ],
                          ),
                        );
                      }),
                ]);
              }),
        ),
      ),
    );
  }

  Widget commentField(
      String mangaId, RemoterQueryUtils<RemoterData<List<Comment>>> utils) {
    TextEditingController commentController = TextEditingController();
    return TextField(
      controller: commentController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          hintText: 'Write your comment...',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.surfaceTint,
            onPressed: () async {
              final commentApi = GetIt.I.get<CommentApi>();
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('token') ?? '';
              try {
                await commentApi.commentManga(
                    mangaId: widget.mangaId,
                    token: token,
                    content: commentController.text);
                utils.refetch();
              } catch (e) {
                Fluttertoast.showToast(
                    msg: "Login to write comment",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: const Color.fromARGB(166, 0, 0, 0),
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
          )),
    );
  }
}
