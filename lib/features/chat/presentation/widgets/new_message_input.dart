import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/chat/presentation/pages/chat.dart';

class NewMessageInput extends StatefulWidget {
  const NewMessageInput({super.key});

  @override
  State<NewMessageInput> createState() => _NewMessageInputState();
}

class _NewMessageInputState extends State<NewMessageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              chats.add(
                Chat(
                  isMe: true,
                  text: _controller.text,
                  date: DateTime.now(),
                ),
              );
              _controller.clear();
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
