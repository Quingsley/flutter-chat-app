import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/welcome/presentation/widgets/text_input.dart';
import 'package:ui/styles/theme.dart';

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
      decoration: BoxDecoration(
        color: AppTheme.kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextInput(controller: _controller),
          SizedBox(
            height: size.height * .15,
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: AppTheme.kPrimaryColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            ),
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
