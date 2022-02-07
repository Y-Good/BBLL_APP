import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mvideo/widgets/common/m_search.dart';
import 'package:mvideo/widgets/public.dart';
import 'package:mvideo/widgets/text/m_text.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        titleWidget: MSearch(autofocus: true),
        actionWidget: MText('搜索', size: 18),
      ),
      body: Center(
        child: Text(
          'SearchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
