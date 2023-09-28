import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/chat/presentation/pages/chat.dart';
import 'package:ui/features/chat/presentation/providers/chat_providers.dart';

class ContactCard extends ConsumerWidget {
  const ContactCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var chats = ref.watch(chatListProvider);
    return ListTile(
      onTap: () => context.push('/chat', extra: user),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 30,
        child: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 30,
        ),
      ),
      title: Text(
        user.userName,
        style: GoogleFonts.poppins(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        chats.isNotEmpty ? chats.last.message : 'Start a conversation',
        style: GoogleFonts.openSans(
          color: Colors.grey[600],
          fontSize: 16,
        ),
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (chats.isNotEmpty)
            Text(
              formatChatTime(DateTime.parse(chats.last.sentAt)),
              style: GoogleFonts.openSans(
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }
}
