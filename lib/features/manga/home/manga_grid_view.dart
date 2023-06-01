import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../api/entities/manga.dart';
import '../manga_detail/manga_detail_page.dart';
import 'manga_grid_view_item.dart';

Container mangaGridView(BuildContext context, BuiltList<Manga>? manga_list) {
  return Container(
    padding: const EdgeInsets.only(left: 15),
    child: SingleChildScrollView(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.6),
          itemCount: manga_list?.length,
          itemBuilder: (BuildContext c, int index) {
            return GestureDetector(
              onTap: () {
                context.pushNamed(
                  MangaDetailPage.routeName,
                  pathParameters: {
                    MangaDetailPage.kMangaIdParam: '${manga_list?[index].id}',
                  },
                );
              },
              child: mangaGridViewItem(manga_list?[index]),
            );
          }),
    ),
  );
}
