import 'package:flutter/material.dart';

import 'card.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int columns = 2;
    if (width >= 1200) {
      columns = 4;
    } else if (width >= 900) {
      columns = 3;
    } else if (width >= 600) {
      columns = 2;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: const [
              StatCard(title: 'Users', value: '1,245', icon: Icons.people),
              StatCard(title: 'Appointments', value: '312', icon: Icons.event),
              StatCard(
                title: 'Doctors',
                value: '48',
                icon: Icons.medical_services,
              ),
              StatCard(
                title: 'Revenue',
                value: '\$12,430',
                icon: Icons.attach_money,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
