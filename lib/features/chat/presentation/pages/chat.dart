import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:ui/features/chat/presentation/widgets/new_message_input.dart';
import 'package:ui/styles/theme.dart';

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
      backgroundColor: AppTheme.kPrimaryColor.withOpacity(.7),
      appBar: AppBar(
        backgroundColor: AppTheme.kSecondaryColor,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
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
                  return chatBubble(chats[index]);
                },
              ),
            ),
          SizedBox(
            height: chats.isEmpty ? size.height * 0.75 : 0,
          ),
          const NewMessageInput()
        ],
      ),
      // floatingActionButton: const NewMessageInput(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Align chatBubble(Chat chat) {
    const isMeBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    );
    const isOtherBorderRadius = BorderRadius.only(
      topRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
    );

    Color isMeChatColor = AppTheme.kSecondaryColor.withOpacity(.8);
    Color isOtherChatColor = AppTheme.kPrimaryColor.withOpacity(.9);

    return Align(
      alignment: chat.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 10, left: 20, top: 10),
        decoration: BoxDecoration(
          color: chat.isMe ? isMeChatColor : isOtherChatColor,
          borderRadius: chat.isMe ? isMeBorderRadius : isOtherBorderRadius,
        ),
        padding: const EdgeInsets.all(15),
        child: TimeStampChatBubble(
          text: chat.text,
          sentAt: formatChatTime(chat.date),
          textStyle: GoogleFonts.openSans(
            color: chat.isMe ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

String formatChatTime(DateTime messageTime) {
  final currentTime = DateTime.now();
  final difference = currentTime.difference(messageTime);

  if (difference.inMinutes <= 1) {
    return 'just now';
  } else if (difference.inMinutes < 10) {
    return '${difference.inMinutes} minutes ago';
  } else {
    // Format the time in your preferred way
    final hour = messageTime.hour.toString().padLeft(2, '0');
    final minute = messageTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // Customize this format as needed
  }
}
