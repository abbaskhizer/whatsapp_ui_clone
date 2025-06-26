import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0.3,
        title: Text(
          "Status",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'edit',
            mini: true,
            backgroundColor: Colors.grey.shade300,
            onPressed: () {},
            child: Icon(Icons.edit, color: Colors.black, size: width * 0.05),
          ),
          SizedBox(height: height * 0.015),
          FloatingActionButton(
            heroTag: 'camera',
            backgroundColor: Colors.teal,
            onPressed: () {},
            child: Icon(Icons.camera_alt, size: width * 0.06),
          ),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        children: [
          ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: width * 0.08,
                  backgroundColor: Colors.teal,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: width * 0.035,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.add,
                      size: width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              'My Status',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.042,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Text(
              'Tap to add status update',
              style: TextStyle(fontSize: width * 0.035, color: Colors.grey),
            ),
            onTap: () {},
          ),

          const Divider(),

          Padding(
            padding: EdgeInsets.only(
              top: height * 0.015,
              bottom: height * 0.01,
            ),
            child: Text(
              "Recent updates",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.04,
              ),
            ),
          ),

          SizedBox(
            height: height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: width * 0.04),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(width * 0.008),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.teal, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: width * 0.08,
                          backgroundColor: Colors.teal,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      SizedBox(
                        width: width * 0.15,
                        child: Text(
                          'User $index',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const Divider(),

          Padding(
            padding: EdgeInsets.only(
              top: height * 0.015,
              bottom: height * 0.01,
            ),
            child: Text(
              "Viewed updates",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.04,
              ),
            ),
          ),

          // Viewed Updates List
          ...List.generate(3, (index) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: CircleAvatar(
                  radius: width * 0.07,
                  backgroundColor: Colors.teal,
                ),
              ),
              title: Text(
                "Friend ${index + 1}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.042,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                "${index + 2} minutes ago",
                style: TextStyle(fontSize: width * 0.035, color: Colors.grey),
              ),
              onTap: () {},
            );
          }),
        ],
      ),
    );
  }
}
