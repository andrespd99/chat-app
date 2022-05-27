import 'package:chat/functions/random_color.dart';
import 'package:flutter/material.dart';

import 'package:chat/models/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  static const String routeName = 'users';

  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController = RefreshController();

  final users = [
    User(id: '1', name: 'Maria', email: 'test1@test.com', online: true),
    User(id: '2', name: 'Andres', email: 'test2@test.com', online: false),
    User(id: '3', name: 'José', email: 'test3@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.black87,
            ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () async {
          await _loadUsers();
          _refreshController.refreshCompleted();
        },
        child: ListView.separated(
          itemCount: users.length,
          itemBuilder: (_, i) => _UserListTile(users[i]),
          separatorBuilder: (_, i) => const Divider(),
        ),
      ),
    );
  }

  Future<dynamic> _loadUsers() => Future.delayed(Duration(seconds: 5));
}

class _UserListTile extends StatelessWidget {
  final User user;

  const _UserListTile(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        backgroundColor: user.color,
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: CircleAvatar(
        backgroundColor:
            user.online ? Colors.greenAccent.shade400 : Colors.grey.shade300,
        radius: 5,
      ),
    );
  }
}
