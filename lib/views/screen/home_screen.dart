import 'package:flutter/material.dart';
import 'package:studentmanagement/service/auth_service.dart';
import 'package:studentmanagement/service/cloude_service.dart';
import 'package:studentmanagement/views/screen/get_started_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService auth = AuthService();
  CloudeService cloud = CloudeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Home')),
      body: StreamBuilder(
        stream: cloud.getStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No Data'));
          }

          final stu = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: stu.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text(stu[index]['name']),
                subtitle: Text(stu[index]['phone']),
                trailing: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          cloud.updateStudent(
                            stu[index].id,
                            "roth",
                            "female",
                            "09699998888",
                            4.0,
                            18,
                          );
                        },
                        child: Text('Update'),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          cloud.deleteStudent(stu[index].id);
                        },
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              );
            },
          );
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  auth.logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetStartedScreen()),
                  );
                },
                child: Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cloud.addStudent("roth", "female", "09699998888", 4.0, 18);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
