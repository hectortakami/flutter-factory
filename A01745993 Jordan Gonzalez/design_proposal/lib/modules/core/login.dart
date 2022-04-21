import 'package:design_proposal/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: size.width / 4),
            const Text(
              'Google Summits',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'ProductSans', fontSize: 24),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: auth.status == Status.Uninitialized
                    ? Container(
                        color: Colors.grey[200],
                        height: 50,
                        width: double.infinity,
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: auth.signInWithGoogle,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
              ),
            ),
            SizedBox(height: size.width / 16)
          ],
        ),
      ),
    );
  }
}
