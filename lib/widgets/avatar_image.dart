import 'package:flutter/material.dart';

const defaultAvatarPath = 'assets/default_avatar.jpg';

// Ảnh avatar mẫu có sẵn trong template để người dùng chọn (không nhập tay).
const templateAvatarPaths = <String>[
  defaultAvatarPath,
  'assets/avatars/avatar_1.png',
  'assets/avatars/avatar_2.png',
  'assets/avatars/avatar_3.png',
  'assets/avatars/avatar_4.png',
  'assets/avatars/avatar_5.png',
  'assets/avatars/avatar_6.png',
];

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    super.key,
    this.avatar,
    this.radius = 24,
  });

  final String? avatar;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final value = avatar?.trim() ?? '';
    final assetPath = value.isEmpty ? defaultAvatarPath : value;

    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: Image.asset(
          assetPath,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _AvatarPlaceholder(radius: radius),
        ),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder({required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      color: Theme.of(context).colorScheme.primaryContainer,
      alignment: Alignment.center,
      child: Icon(
        Icons.person,
        size: radius,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
