import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/auth/presentation/widgets/auth_button.dart';
import 'package:ui/features/auth/presentation/widgets/text_input.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<AuthPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var isSignUp = ref.watch(isSignUpState);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Material(
            elevation: 25,
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary,
            child: Container(
              width: size.width * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .1,
                  vertical: size.height * .05,
                ),
                child: SingleChildScrollView(
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
                          fontFamily: GoogleFonts.pacifico().fontFamily,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInput(
                        hintText: 'Enter your email',
                        controller: emailController,
                      ),
                      if (isSignUp)
                        const SizedBox(
                          height: 20,
                        ),
                      if (isSignUp)
                        TextInput(
                          hintText: 'Enter your username',
                          controller: usernameController,
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthButton(
                        isSignUp: isSignUp,
                        usernameController: usernameController,
                        emailController: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(isSignUpState.notifier).state =
                              !ref.read(isSignUpState.notifier).state;
                        },
                        child: Text(
                          !isSignUp
                              ? 'Don\'t have an account? Create one'
                              : 'Log in',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final isSignUpState = StateProvider<bool>((ref) {
  return false;
});
