import 'package:flutter/material.dart';
import 'package:mvideo/models/public.dart';
import 'package:mvideo/widgets/public.dart';

class SearchVideoPage extends StatelessWidget {
  final List<Video>? videoList;
  const SearchVideoPage({Key? key, this.videoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoList(videoList: videoList);
  }
}
