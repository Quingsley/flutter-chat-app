import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/chat/data/models/chat_model.dart';
import 'package:ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:ui/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:ui/features/chat/presentation/widgets/new_message_input.dart';
import 'package:ui/services/stream_service.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.contact});

  final User contact;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  Future<void> _scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    ref.listen(groupChatStreamProvider, (previous, chats) {
      chats.whenOrNull(
        error: (error, stackTrace) => debugPrint(error.toString()),
        data: (chat) {
          ref.read(chatListProvider.notifier).addChat(chat);
          _scrollToBottom();
        },
      );
    });
    var chats = ref.watch(chatListProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          widget.contact.userName,
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
                controller: _scrollController,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return chatBubble(chats[index], context);
                },
              ),
            ),
          SizedBox(
            height: chats.isEmpty ? size.height * 0.3 : 0,
          ),
          NewMessageInput(
            contact: widget.contact,
          )
        ],
      ),
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

    Color otherMessageLabelColor = Theme.of(context).colorScheme.secondary;
    Color myMessageLabelColor = Theme.of(context).colorScheme.primary;

    Color myMessageColor = Theme.of(context).colorScheme.onPrimary;
    Color otherMessageColor = Theme.of(context).colorScheme.onSecondary;

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
                  chat.isMe ? 'You' : chat.messageLabel,
                  style: GoogleFonts.poppins(
                    color: chat.isMe
                        ? myMessageLabelColor
                        : otherMessageLabelColor,
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
                  color:
                      chat.isMe ? myMessageLabelColor : otherMessageLabelColor,
                  size: 14,
                )
              ],
            ),
            TimeStampChatBubble(
              text: chat.message,
              sentAt: formatChatTime(
                  DateTime.parse(chat.isMe ? chat.sentAt : chat.receivedAt!)),
              textStyle: GoogleFonts.openSans(
                color: chat.isMe ? myMessageColor : otherMessageColor,
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
