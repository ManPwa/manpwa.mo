import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../manga_list/manga_list_page.dart';

Container homeHeader(BuildContext context, String title) {
  return Container(
    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        GestureDetector(
          onTap: () {
            context.pushNamed(
              MangaListPage.routeName,
              pathParameters: {
                MangaListPage.kMangaListTypeParam: title,
              },
            );
          },
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
      ],
    ),
  );
}
