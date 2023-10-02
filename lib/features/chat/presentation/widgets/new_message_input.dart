import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';
import 'package:ui/features/chat/presentation/viewmodels/chat_view_model.dart';
import 'package:ui/shared/providers/shared_providers.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class NewMessageInput extends ConsumerStatefulWidget {
  const NewMessageInput({required this.contact, super.key});
  final User contact;

  @override
  ConsumerState<NewMessageInput> createState() => _NewMessageInputState();
}

class _NewMessageInputState extends ConsumerState<NewMessageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = ref.watch(currentUserProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: TextField(
        controller: _controller,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: GoogleFonts.poppins().fontFamily),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          hintText: 'Type a message',
          contentPadding: const EdgeInsets.all(20),
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (_controller.text.isEmpty) return;
              Chat chat = Chat(
                isRead: false,
                receivedAt: '',
                recipientId: widget.contact.userId,
                senderId: currentUser!.userId,
                message: _controller.text,
                sentAt: DateTime.now().toIso8601String(),
                chatId: uuid.v4(),
                isMe: true,
                messageLabel: currentUser.userName,
              );

              _controller.clear();
              ref.read(chatViewModelProvider.notifier).sendChat(chat);
            },
            icon: Icon(
              Icons.send,
              size: 30,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
