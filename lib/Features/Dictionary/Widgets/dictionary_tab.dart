import 'package:flutter/material.dart';
import 'package:projects/library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryTab extends ConsumerStatefulWidget {
  final String dictionaryId;
  final List<Color> colors;
  final ScrollController scrollController;

  const DictionaryTab({
    super.key,
    required this.dictionaryId,
    required this.colors,
    required this.scrollController,
  });

  @override
  ConsumerState<DictionaryTab> createState() => _DictionaryTabState();
}

class _DictionaryTabState extends ConsumerState<DictionaryTab> {
  final TextEditingController _searchController = TextEditingController();
  String? _searchTerm;
  int? _highlightedEntryIndex;

  final Map<int, GlobalKey> _entryKeys = {};
  final Map<String, GlobalKey> _wordKeys = {};

  bool _userInterrupted = false;
  bool _isJumping = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Map<int, double> get _benchmarks {
    if (widget.dictionaryId == "english") {
      return {
        1: 0,
        2: 40,
        3: 100,
        4: 2000,
        5: 8000,
        6: 16000, //mm-hmm
        7: 30000, //o'clock or session
        8: 50000, //initiate
        9: 80000, //initially
        10: 110000, //initiative
        11: 140000, //nonetheless, up to African-American and simultaneously
      };
    } else if (widget.dictionaryId == "spanish") {
      return {
        1: 0,
        2: 40,
        3: 100,
        4: 2000,
        5: 7000,
        6: 20000, //llamar
        7: 38000, //llamame
        8: 67000, //llamamos
        9: 100000, //lleguemos
        10: 140000, //emergencia
        11: 170000, //apartamento
      };
    }
    return {};
  }

  void _onSearch(List<MapEntry<String, List<String>>> entries) {
    final search = _searchController.text.trim().toLowerCase();
    if (search.isEmpty) {
      setState(() {
        _highlightedEntryIndex = null;
        _searchTerm = null;
      });
      return;
    }
    int? foundEntryIndex;
    String? foundWordKey;
    for (int i = 0; i < entries.length; i++) {
      for (final word in entries[i].value) {
        if (word.toLowerCase() == search) {
          foundEntryIndex = i;
          foundWordKey = '$i-$word';
          break;
        }
      }
      if (foundEntryIndex != null) break;
    }
    setState(() {
      _highlightedEntryIndex = foundEntryIndex;
      _searchTerm = search;
    });

    if (foundWordKey != null) {
      _userInterrupted = false;
      _scrollToWord(foundWordKey);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Word not found'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _scrollToWord(String wordKey, [int attempt = 0]) async {
    if (_userInterrupted) {
      if (_isJumping) setState(() => _isJumping = false);
      return;
    }
    final benchmarks = _benchmarks;
    final key = _wordKeys[wordKey];
    if (attempt == 0) setState(() => _isJumping = true);

    if (attempt == 0 && key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
      setState(() => _isJumping = false);
      return;
    }

    if (attempt == 0 && widget.scrollController.hasClients) {
      final parts = wordKey.split('-');
      final word = parts.length > 1 ? parts.sublist(1).join('-') : '';
      int len = word.length;
      double jumpOffset = benchmarks.containsKey(len)
          ? benchmarks[len]!
          : benchmarks[11]!; // fallback to largest
      jumpOffset = jumpOffset.clamp(
        0.0,
        widget.scrollController.position.maxScrollExtent,
      );
      await widget.scrollController.animateTo(
        jumpOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    double scrollStep = screenH;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_userInterrupted) {
        if (_isJumping) setState(() => _isJumping = false);
        return;
      }
      final key = _wordKeys[wordKey];
      if (key != null && key.currentContext != null) {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
        setState(() => _isJumping = false);
      } else {
        final targetOffset = (widget.scrollController.offset + scrollStep)
            .clamp(0.0, widget.scrollController.position.maxScrollExtent);
        await widget.scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        await Future.delayed(const Duration(milliseconds: 120));
        _scrollToWord(wordKey, attempt + 1);
      }
    });
  }

  Widget _buildEntry(
    MapEntry<String, List<String>> entry,
    int index,
    Color curColor,
  ) {
    final isEntryHighlighted = index == _highlightedEntryIndex;
    final entryKey = _entryKeys.putIfAbsent(index, () => GlobalKey());
    return Container(
      key: entryKey,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: isEntryHighlighted ? Colors.yellow : curColor,
          width: 2,
        ),
        boxShadow: [BoxShadow(color: curColor, blurRadius: 10)],
      ),
      padding: EdgeInsets.all(insetPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingWidget(
            neonColor: curColor,
            title: entry.key,
            num: (index + 1).toString(),
            fontSize: 25,
          ),
          const SizedBox(height: padding + 10),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: entry.value
                .map(
                  (word) =>
                      _buildWord(word, index, curColor, isEntryHighlighted),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWord(
    String word,
    int index,
    Color curColor,
    bool isEntryHighlighted,
  ) {
    final wordKey = _wordKeys.putIfAbsent('$index-$word', () => GlobalKey());
    final isWordHighlighted =
        isEntryHighlighted &&
        _searchTerm != null &&
        word.toLowerCase() == _searchTerm;
    return Container(
      key: wordKey,
      decoration: BoxDecoration(
        color: isWordHighlighted
            ? Colors.yellow.withAlpha((0.2 * 255).toInt())
            : Colors.black,
        border: Border.all(
          color: isWordHighlighted ? Colors.yellow : curColor,
          width: 2,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Text(
        word,
        style: TextStyle(
          color: isWordHighlighted ? Colors.yellow[900] : curColor,
          fontWeight: isWordHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref
        .watch(patternMapProvider(widget.dictionaryId))
        .map
        .entries
        .toList();

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search word...',
                        hintStyle: TextStyle(color: AppTheme.logoGreen),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.logoGreen,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withAlpha(200),
                            width: 1,
                          ),
                        ),
                        fillColor: Colors.black.withAlpha(150),
                        suffixIcon: Icon(Icons.search, color: Colors.white),
                      ),
                      cursorColor: AppTheme.logoGreen,
                      style: TextStyle(color: AppTheme.logoGreen),
                      onSubmitted: (_) => _onSearch(entries),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is UserScrollNotification) {
                    _userInterrupted = true;
                  }
                  return false;
                },
                child: Scrollbar(
                  controller: widget.scrollController,
                  child: ListView.separated(
                    controller: widget.scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final curColor =
                          widget.colors[index % widget.colors.length];
                      return _buildEntry(entry, index, curColor);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_isJumping)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
