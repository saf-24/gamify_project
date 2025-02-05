import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Text(
          "Gamify",
          style: TextStyle(
              fontSize: 32,
              color: Color.fromARGB(197, 0, 129, 189),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: "Bach",
          icon: const Icon(
            Icons.arrow_back,
            size: 38.4,
            color: Color.fromARGB(197, 0, 129, 189),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No notifications available"));
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final title = notifications[index].data() as Map<String, dynamic>;
              final massege =
                  notifications[index].data() as Map<String, dynamic>;
              return NotificationCard(
                title: title['title'] ?? 'New Notification',
                massege: massege['message'] ?? 'New Notification',
              );
            },
          );
        },
      ),

    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 40.0),
          color:
              isActive ? const Color.fromARGB(197, 0, 129, 189) : Colors.grey,
          onPressed: () {},
        ),
        Text(
          label,
          style: TextStyle(
            height: 0.1,
            color:
                isActive ? const Color.fromARGB(197, 0, 129, 189) : Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String massege;

  const NotificationCard({
    super.key,
    required this.title,
    required this.massege,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: 349,
                    child: Text(
                      massege,
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
