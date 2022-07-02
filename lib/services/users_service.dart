import 'package:chat/global/env.dart';
import 'package:chat/models/users_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/user.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    final res = await http.get(
      Uri.parse('${Environment.apiUrl}/users'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? "",
      },
    );

    final userRes = usersResponseFromJson(res.body);

    return userRes.users;
  }
}
