import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeley_frontend/commons/decoration.dart';
import 'package:yeley_frontend/commons/validators.dart';
import 'package:yeley_frontend/providers/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/yeley_logo_95.png',
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Connectes toi",
                  style: kBold22,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Pour accéder à vos restaurants et activités favorites !",
                    style: kRegular14,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Se connecter",
                      style: kBold22,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 4,
                      decoration: const BoxDecoration(
                        color: kMainGreen,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Email", style: kRegular14),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: 'mon.email@gmail.com',
                  ),
                  controller: _emailController,
                  validator: Validator.email,
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Mot de passe", style: kRegular14),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: '********',
                  ),
                  controller: _passwordController,
                  validator: Validator.password,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: context.read<AuthProvider>().isLogin
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: kMainGreen),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await context
                                  .read<AuthProvider>()
                                  .login(context, _emailController.text, _emailController.text);
                            }
                          },
                          child: const Text("Se connecter", style: kBold16),
                        ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: "Lato",
                    ),
                    children: [
                      TextSpan(
                        text: 'Tu n\'as pas de compte ? ',
                        style: kRegular16.copyWith(color: Colors.black),
                      ),
                      TextSpan(
                        style: kRegular16.copyWith(color: kMainGreen),
                        text: 'Inscris toi.',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/signup');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}