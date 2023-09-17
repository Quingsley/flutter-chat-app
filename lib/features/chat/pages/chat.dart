import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/chat/widgets/chat_bubble.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.title});

  final String title;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = 'Hey, how are you?';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2e6b47).withOpacity(.9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDC100),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (_controller.text != '')
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: 20, bottom: 20, left: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDC100).withOpacity(.8),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: ListenableBuilder(
                        listenable: _controller,
                        builder: (context, widget) => TimeStampChatBubble(
                          text: _controller.text,
                          sentAt: '2 minutes ago',
                          textStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: TextField(
                controller: _controller,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: GoogleFonts.poppins().fontFamily),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff2e6b47),
                  hintText: 'Type a message',
                  contentPadding: const EdgeInsets.all(20),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFDC100),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFFFDC100).withOpacity(.5),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFDC100),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // _controller.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 30,
                      color: Color(0xFFFDC100),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
