import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../api/entities/manga.dart';

Container mangaGridViewItem(Manga? manga) {
  return Container(
    height: 180,
    margin: const EdgeInsets.only(bottom: 15.0, right: 15.0, top: 15.0),
    child: Stack(alignment: Alignment.bottomCenter, children: [
      CachedNetworkImage(
        imageUrl: manga?.cover_art_url ?? '',
        fit: BoxFit.contain,
        imageBuilder: (context, imageProvider) => Container(
          width: 120,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) {
          return const Center(child: CircularProgressIndicator());
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      Container(
        height: 45,
        child: Stack(children: [
          ClipRRect(
            // Clip it cleanly.
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.only(left: 7, right: 7),
                child: Text(
                  manga?.title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ))
        ]),
      ),
    ]),
  );
}
