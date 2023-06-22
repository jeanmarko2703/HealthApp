import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

import 'package:health_app/models/user_model.dart';
import 'package:health_app/theme/app_theme.dart';
import 'package:health_app/widgets/widgets.dart';

import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hiddenPassword = true;
  bool errorMessage = false;
  void _message() {
    setState(() {
      errorMessage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);

    TextStyle titleStyle = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.5));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper:
                      BottomClipper(), // Radio para hacer los lados inferiores redondeados
                  child: Container(
                    decoration: const BoxDecoration(color: AppTheme.primary),
                    height: 300,
                    child: Stack(children: [
                      Positioned(
                          bottom: 50,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: SvgPicture.asset(
                              'assets/Oncoguard_Logo.svg',
                              width: size.width - 80,
                            ),
                          ))
                    ]),
                  ),
                ),
                Form(
                    key: loginForm.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          CustomInput(
                            secondTitle: 'Correo',
                            secondTitleStyle: titleStyle,
                            backgroundColor: Colors.white,
                            controller: loginForm.email,
                            validator: (value) {
                              {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(pattern);
                                loginForm.emailValidatorError =
                                    regExp.hasMatch(value ?? '')
                                        ? ''
                                        : 'Ingrese un correo valido';

                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            loginForm.emailValidatorError == ''
                                ? ''
                                : loginForm.emailValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),
                          CustomInput(
                            secondTitle: 'Contraseña',
                            secondTitleStyle: titleStyle,
                            obscureText: hiddenPassword,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              icon: Icon(
                                hiddenPassword == false
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: Colors.grey,
                              ),
                            ),
                            controller: loginForm.password,
                            validator: (value) {
                              {
                                (value != null && value.length >= 5)
                                    ? loginForm.passwordValidatorError = ''
                                    : loginForm.passwordValidatorError =
                                        'Ingrese una contraseña correcta';
                                return null;
                              }
                            },
                          ),

                          const SizedBox(
                              height:
                                  5), // Add some space between the TextFormField and the error message
                          Text(
                            loginForm.passwordValidatorError == ''
                                ? ''
                                : loginForm.passwordValidatorError,
                            style: const TextStyle(color: Colors.red),
                          ),

                          errorMessage
                              ? Column(
                                  children: const [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Correo o contraseña incorrecta',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : const SizedBox(),

                          const SizedBox(
                            height: 30,
                          ),
                          // TextButton(
                          //     style: ElevatedButton.styleFrom(
                          //       foregroundColor: Colors.white,
                          //     ),
                          //     onPressed: null,
                          //     child: const Text('¿ Olvidaste tu contraseña ?')),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                                onPressed: loginForm.isLoading
                                    ? null
                                    : () async {
                                        final authProvider =
                                            Provider.of<AuthProvider>(context,
                                                listen: false);
                                        //uiProvider to set home as initial route in navigation bar
                                        final uiProvider =
                                            Provider.of<UiProvider>(context,
                                                listen: false);
                                        //hide keyboard once user touch login button
                                        FocusScope.of(context).unfocus();
                                        if (!loginForm.isValidForm() ||
                                            loginForm.emailValidatorError !=
                                                '' ||
                                            loginForm.passwordValidatorError !=
                                                '') return;
                                        //login button state
                                        loginForm.isLoading = true;

                                        //login request

                                        var access = await authProvider.logIn(
                                            loginForm.email.text,
                                            loginForm.password.text);

                                        if (access != null && context.mounted) {
                                          print('el uid es: ${access.uid}');

                                          uiProvider.selectedMenuOpt = 0;
                                          Navigator.pushReplacementNamed(
                                              context, 'navigationScreen');
                                          loginForm.isLoading = false;
                                          loginForm.password.text = '';
                                        } else {
                                          _message();
                                          loginForm.isLoading = false;
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(size.width, 50),
                                    elevation: 0,
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppTheme.buttonLabelColor),
                                child: Text(
                                  loginForm.isLoading
                                      ? 'Cargando...'
                                      : 'Iniciar Sesión',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿Aún no tienes una cuenta? '),
                              GestureDetector(
                                  onTap: () {
                                    print('hola');
                                  },
                                  child: const Text(
                                    'Crear cuenta',
                                    style: TextStyle(
                                        color: AppTheme.buttonLabelColor),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          UserCredential? user =
                              await AuthService().signInWithGoogle();
                          if (user != null) {
                            if (user.user != null) {
                              UserModel? userRegisterd = await DatabaseService()
                                  .getUserInfo(user.user!.uid);

                              if (userRegisterd != null) {
                                if (mounted) {
                                  Navigator.pushReplacementNamed(
                                      context, 'saveAccount');
                                }
                              } else {
                                await DatabaseService().saveUserInfo(UserModel(
                                    uid: user.user!.uid,
                                    email: user.user!.email!,
                                    name: user.user!.displayName!));
                                if (mounted) {
                                  Navigator.pushReplacementNamed(
                                      context, 'saveAccount');
                                }
                              }
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Image.asset('assets/google_logo.png')),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      if (Platform.isIOS)
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Image.asset('assets/apple_logo.png')),
                        )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Linea izquierda inferior
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 50); // Curva inferior
    path.lineTo(size.width, 0); // Linea derecha inferior
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
