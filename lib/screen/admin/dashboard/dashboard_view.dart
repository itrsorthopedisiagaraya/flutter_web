import 'package:flutter/material.dart';

import 'widget/card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double ratio = 1.0;

    int columns = 2;
    if (width >= 1024) {
      columns = 4;
      ratio = 1.5;
    } else if (width >= 720) {
      columns = 3;
      ratio = 1.35;
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overview',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.only(bottom: 16),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: ratio, // 👈 IMPORTANT for desktop
            ),
            delegate: SliverChildListDelegate(const [
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
            ]),
          ),
        ),
      ],
    );
  }
}
