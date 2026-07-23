import 'package:flutter/material.dart';
import '../../data/models/job_dto.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final Future<dynamic> future;
  final IconData icon;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.future,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              FutureBuilder<dynamic>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Text('Error', style: TextStyle(fontSize: 12));
                  }

                  late String count;
                  if (snapshot.data is List) {
                    count = snapshot.data.length.toString();
                  } else if (snapshot.data is int) {
                    count = snapshot.data.toString();
                  } else {
                    count = '0';
                  }

                  return Text(
                    count,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
