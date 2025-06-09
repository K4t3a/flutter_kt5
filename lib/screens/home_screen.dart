import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userService.getUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final user = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: const Text('Главная')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Имя: ${user.firstName}'),
                Text('Фамилия: ${user.lastName}'),
                Text('Email: ${user.email}'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _userService.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: const Text('Выйти'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
