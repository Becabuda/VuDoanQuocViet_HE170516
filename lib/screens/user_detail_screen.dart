import 'package:flutter/material.dart';

import '../models/user.dart';
import '../widgets/avatar_image.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 32),
              Center(
                child: AvatarImage(
                  key: const Key('detail_avatar'),
                  avatar: user.avatar,
                  radius: 64,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _InfoField(
                        label: 'ID',
                        // Không gộp label và value vào cùng một Text.
                        // Testcase cần thấy đúng Text(user.fullName) và Text(user.email).
                        child: Text(
                          '${user.id}',
                          key: const Key('detail_id'),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _InfoField(
                        label: 'Fullname',
                        child: Text(
                          user.fullName,
                          key: const Key('detail_fullname'),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _InfoField(
                        label: 'Email',
                        child: Text(
                          user.email,
                          key: const Key('detail_email'),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}
