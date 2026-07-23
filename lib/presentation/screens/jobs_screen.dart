import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/job_providers.dart';
import '../widgets/job_list_item.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _filterType = 'all';
  String _sortBy = 'date';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobsAsyncValue = _searchQuery.isEmpty
        ? ref.watch(jobsProvider)
        : ref.watch(jobSearchProvider(_searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search jobs...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: _filterType,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'all', child: Text('All')),
                          DropdownMenuItem(value: 'very_relevant', child: Text('Very Relevant')),
                          DropdownMenuItem(value: 'relevant', child: Text('Relevant')),
                        ],
                        onChanged: (value) => setState(() => _filterType = value ?? 'all'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _sortBy,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'date', child: Text('Newest')),
                          DropdownMenuItem(value: 'importance', child: Text('Most Relevant')),
                          DropdownMenuItem(value: 'company', child: Text('Company')),
                        ],
                        onChanged: (value) => setState(() => _sortBy = value ?? 'date'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: jobsAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text('Error: $err'),
              ),
              data: (jobs) => jobs.isEmpty
                  ? const Center(child: Text('No jobs found'))
                  : ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: JobListItem(job: jobs[index]),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
