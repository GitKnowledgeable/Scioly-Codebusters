import 'package:flutter/material.dart';
import 'package:scioly_codebusters/library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryPage extends ConsumerWidget {
  DictionaryPage({super.key});
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = [
      AppTheme.logoGreen,
      Colors.yellowAccent,
      Colors.blueAccent,
      Colors.redAccent,
    ];

    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: AppTheme.backgroundGradient,
        child: Scaffold(
          backgroundColor: AppTheme.appBarBackground,
          appBar: AppBar(
            title: const Text('Pattern Dictionary'),
            backgroundColor: AppTheme.appBarBackground,
            bottom: const TabBar(
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: 'English'),
                Tab(text: 'Spanish'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DictionaryTab(
                dictionaryId: "english",
                colors: colors,
                scrollController: _scrollController,
              ),
              DictionaryTab(
                dictionaryId: "spanish",
                colors: colors,
                scrollController: _scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
