import 'package:flutter/material.dart';

void main() => runApp(DashboardApp());

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard UI',
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<DashboardCardData> cards = [
    DashboardCardData(title: 'Users', value: '1,245', icon: Icons.people, color: Colors.teal),
    DashboardCardData(title: 'Revenue', value: '\$8,530', icon: Icons.attach_money, color: Colors.blue),
    DashboardCardData(title: 'Messages', value: '312', icon: Icons.message, color: Colors.purple),
    DashboardCardData(title: 'Notifications', value: '27', icon: Icons.notifications, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final card = cards[index];
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(card.title),
                    content: Text('More details about ${card.title}.'),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: card.color.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(card.icon, size: 40, color: card.color),
                      SizedBox(height: 10),
                      Text(
                        card.value,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: card.color),
                      ),
                      SizedBox(height: 4),
                      Text(
                        card.title,
                        style: TextStyle(fontSize: 16, color: card.color.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DashboardCardData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  DashboardCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}
  