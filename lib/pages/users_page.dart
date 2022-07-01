import 'package:chat/consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/user.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

class UsersPage extends StatefulWidget {
  static const String routeName = 'users';

  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController = RefreshController();

  final users = [
    User(uid: '1', name: 'Maria', email: 'test1@test.com', online: true),
    User(uid: '2', name: 'Andres', email: 'test2@test.com', online: false),
    User(uid: '3', name: 'José', email: 'test3@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(user!.name),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.black87,
            ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app_outlined),
          color: Colors.black,
          onPressed: () {
            context.read<SocketService>().disconnect();

            Navigator.pushReplacementNamed(context, LoginPage.routeName);

            context.read<AuthService>().logOut();
          },
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: Consts.padding / 2),
            child: connectionStatusIcon(),
          ),
        ],
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

  Future<dynamic> _loadUsers() => Future.delayed(const Duration(seconds: 5));

  Icon connectionStatusIcon() {
    ServerStatus status = context.watch<SocketService>().serverStatus;

    if (status == ServerStatus.connecting) {
      return const Icon(
        Icons.offline_bolt,
        color: Colors.amberAccent,
      );
    } else if (status == ServerStatus.online) {
      return Icon(
        Icons.check_circle,
        color: Colors.blue.shade400,
      );
    } else {
      return const Icon(
        Icons.offline_bolt,
        color: Colors.grey,
      );
    }
  }
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
