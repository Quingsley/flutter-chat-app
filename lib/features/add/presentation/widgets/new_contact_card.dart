import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/auth/presentation/widgets/text_input.dart';

class NewContactCard extends StatefulWidget {
  const NewContactCard({super.key});

  @override
  State<NewContactCard> createState() => _NewContactCardState();
}

class _NewContactCardState extends State<NewContactCard> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * .4,
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextInput(
            controller: _controller,
            hintText: 'Enter users email',
          ),
          const SizedBox(
            height: 10,
          ),
          TextInput(
            controller: _controller,
            hintText: 'Enter user\'s username',
          ),
          SizedBox(
            height: size.height * .1,
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            ),
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
