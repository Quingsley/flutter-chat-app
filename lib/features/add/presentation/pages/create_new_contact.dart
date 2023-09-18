import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/add/presentation/widgets/new_contact_card.dart';
import 'package:ui/styles/theme.dart';

class NewContact extends StatelessWidget {
  const NewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppTheme.kSecondaryColor,
        title: Text('New Contact',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Builder(builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).showBottomSheet(
                  (context) => const NewContactCard(),
                  backgroundColor: AppTheme.kSecondaryColor,
                  elevation: 0,
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.all(8),
                      width: 60,
                      height: 60,
                      child: const Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 24,
                              top: 5,
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: AppTheme.kSecondaryColor,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: AppTheme.kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'New contact',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Contacts on WeeChat',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: Placeholder(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
