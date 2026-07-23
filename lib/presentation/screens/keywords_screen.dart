import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/keyword_providers.dart';

class KeywordsScreen extends ConsumerStatefulWidget {
  const KeywordsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<KeywordsScreen> createState() => _KeywordsScreenState();
}

class _KeywordsScreenState extends ConsumerState<KeywordsScreen> {
  final TextEditingController _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keywords = ref.watch(keywordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keywords'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _keywordController,
                    decoration: InputDecoration(
                      hintText: 'Add new keyword...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    if (_keywordController.text.isNotEmpty) {
                      ref.read(addKeywordProvider(_keywordController.text));
                      _keywordController.clear();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: keywords.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (keywordList) => keywordList.isEmpty
                  ? const Center(child: Text('No keywords added'))
                  : ListView.builder(
                      itemCount: keywordList.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(keywordList[index].keyword),
                        subtitle: Text(keywordList[index].isDefault ? 'Default' : 'Custom'),
                        trailing: !keywordList[index].isDefault
                            ? IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => ref.read(
                                  deleteKeywordProvider(keywordList[index].id),
                                ),
                              )
                            : null,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
