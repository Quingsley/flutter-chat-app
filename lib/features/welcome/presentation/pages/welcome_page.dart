import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/welcome/presentation/cubit/user_cubit.dart';
import 'package:ui/features/welcome/presentation/widgets/text_input.dart';

class WelcomePageWrapper extends StatelessWidget {
  const WelcomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Material(
            elevation: 25,
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black54.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                position: DecorationPosition.foreground,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .2,
                    vertical: size.height * .1,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To WeeChat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: GoogleFonts.pacifico().fontFamily,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInput(
                        controller: controller,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      OutlinedButton(
                        onPressed: () => context.go('/home'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFFDC100),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
