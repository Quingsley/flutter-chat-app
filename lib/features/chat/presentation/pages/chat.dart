import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:ui/features/chat/presentation/widgets/new_message_input.dart';

class Chat {
  final String text;
  final DateTime date;
  final bool isMe;

  Chat({
    required this.text,
    required this.date,
    required this.isMe,
  });
}

List<Chat> chats = [];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (chats.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return chatBubble(chats[index], context);
                },
              ),
            ),
          SizedBox(
            height: chats.isEmpty ? size.height * 0.3 : 0,
          ),
          const NewMessageInput()
        ],
      ),
      // floatingActionButton: const NewMessageInput(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Align chatBubble(Chat chat, BuildContext context) {
    const isMeBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    );
    const isOtherBorderRadius = BorderRadius.only(
      topRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
    );

    Color isMeChatColor = Theme.of(context).colorScheme.secondary;
    Color isOtherChatColor = Theme.of(context).colorScheme.primary;

    return Align(
      alignment: chat.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 10, left: 20, top: 10),
        decoration: BoxDecoration(
          color: chat.isMe ? isMeChatColor : isOtherChatColor,
          borderRadius: chat.isMe ? isMeBorderRadius : isOtherBorderRadius,
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Jerome',
                  style: GoogleFonts.poppins(
                    color: chat.isMe
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
                Builder(builder: (context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  );
                }),
                Icon(
                  Icons.check,
                  color: chat.isMe
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  size: 14,
                )
              ],
            ),
            TimeStampChatBubble(
              text: chat.text,
              sentAt: formatChatTime(chat.date),
              textStyle: GoogleFonts.openSans(
                color: chat.isMe
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatChatTime(DateTime messageTime) {
  // Format the time in your preferred way
  final hour = messageTime.hour.toString().padLeft(2, '0');
  final minute = messageTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute'; // Customize this format as needed
}
