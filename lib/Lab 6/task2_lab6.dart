import 'package:flutter/material.dart';

void main() {
  runApp(ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card UI',
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(child: ProfileCard()),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300',
              ),
            ),
            SizedBox(height: 15),

            // Name
            Text(
              'Asjad Kashif',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Bio
            SizedBox(height: 8),
            Text(
              'Graphics Designer • CS Student • Nature Lover',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.person_add_alt_1),
                  label: Text('Follow'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: StadiumBorder(),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.message),
                  label: Text('Message'),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Colors.teal),
                    foregroundColor: Colors.teal,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
