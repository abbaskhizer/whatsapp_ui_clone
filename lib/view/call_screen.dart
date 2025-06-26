import 'package:flutter/material.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calls", style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.teal),
        elevation: 1,
        actions: [
          
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 8,
        itemBuilder: (context, index) {
          bool isIncoming = index % 2 == 0;
          return ListTile(
            leading: CircleAvatar(
              radius: width * 0.065,
              backgroundColor: Colors.teal,
              child: Text('C$index', style: const TextStyle(color: Colors.black)),
            ),
            title: Text('Contact $index'),
            subtitle: Row(
              children: [
                Icon(
                  isIncoming ? Icons.call_received : Icons.call_made,
                  size: 16,
                  color: isIncoming ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 4),
                Text(
                  isIncoming ? 'Incoming - 2:1$index PM' : 'Outgoing - 11:$index AM',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.call, color: Colors.teal),
              onPressed: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          // Handle new call
        },
        child: const Icon(Icons.add_call),
      ),
    );
  }
}
