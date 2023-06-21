import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

import 'onboarding_backgroun.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _errorMessage = false;
  void _message() {
    setState(() {
      _errorMessage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final signInForm = Provider.of<SignInFormProvider>(context);
    const TextStyle titleStyle = TextStyle(
        color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700);
    TextStyle subTitleStyle = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.5));

    return Scaffold(
      body: Stack(
        children: [
          const OnboardingBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            // top: size.height * 0.08,
                            bottom: size.height * 0.025),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'onboardingScreen', (route) => false);
                              },
                              icon: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              "Registro",
                              style: titleStyle,
                            )
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Form(
                          key: signInForm.formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                CustomInput(
                                  title: Text(
                                    ' Nombre completo:',
                                    style: subTitleStyle,
                                  ),
                                  backgroundColor: Colors.white,
                                  controller: signInForm.name,
                                  validator: (value) {
                                    {
                                      (value != null && value.length >= 5)
                                          ? signInForm.nameValidatorError = ''
                                          : signInForm.nameValidatorError =
                                              'Ingrese un nombre valido';
                                      return null;
                                    }
                                  },
                                ),
                                // Add some space between the TextFormField and the error message
                                Text(
                                  signInForm.nameValidatorError == ''
                                      ? ''
                                      : signInForm.nameValidatorError,
                                  style: const TextStyle(color: Colors.red),
                                ),

                                CustomInput(
                                  title: Text(' Correo:', style: subTitleStyle),
                                  backgroundColor: Colors.white,
                                  controller: signInForm.email,
                                  validator: (value) {
                                    {
                                      String pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regExp = RegExp(pattern);
                                      signInForm.emailValidatorError =
                                          regExp.hasMatch(value ?? '')
                                              ? ''
                                              : 'Ingrese un correo valido';

                                      return null;
                                    }
                                  },
                                ),

                                Text(
                                  signInForm.emailValidatorError == ''
                                      ? ''
                                      : signInForm.emailValidatorError,
                                  style: const TextStyle(color: Colors.red),
                                ),
                                CustomInput(
                                  title: Text(' Contraseña:',
                                      style: subTitleStyle),
                                  backgroundColor: Colors.white,
                                  obscureText: true,
                                  controller: signInForm.password,
                                  validator: (value) {
                                    {
                                      (value != null && value.length >= 5)
                                          ? signInForm.passwordValidatorError =
                                              ''
                                          : signInForm.passwordValidatorError =
                                              'Ingrese una contraseña correcta';
                                      return null;
                                    }
                                  },
                                ),

                                Text(
                                  signInForm.passwordValidatorError == ''
                                      ? ''
                                      : signInForm.passwordValidatorError,
                                  style: const TextStyle(color: Colors.red),
                                ),
                                CustomInput(
                                  title: Text(' Confirmar contraseña:',
                                      style: subTitleStyle),
                                  backgroundColor: Colors.white,
                                  obscureText: true,
                                  controller: signInForm.confirmationPassword,
                                  validator: (value) {
                                    {
                                      (signInForm.password.text == value)
                                          ? signInForm
                                                  .confirmationPasswordValidatorError =
                                              ''
                                          : signInForm
                                                  .confirmationPasswordValidatorError =
                                              'La contraseña no coincide';
                                      return null;
                                    }
                                  },
                                ),

                                Text(
                                  signInForm.confirmationPasswordValidatorError ==
                                          ''
                                      ? ''
                                      : signInForm
                                          .confirmationPasswordValidatorError,
                                  style: const TextStyle(color: Colors.red),
                                ),
                                _errorMessage
                                    ? Column(
                                        children: const [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Hubo un error, intentelo nuevamente',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          )
                                        ],
                                      )
                                    : const SizedBox(),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      onPressed: signInForm.isLoading
                                          ? null
                                          : () async {
                                              FocusScope.of(context).unfocus();

                                              final auth =
                                                  Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false);
                                              final uiProvider =
                                                  Provider.of<UiProvider>(
                                                      context,
                                                      listen: false);
                                              final DatabaseService database =
                                                  DatabaseService();
                                              if (!signInForm.isValidForm() ||
                                                  signInForm
                                                          .nameValidatorError !=
                                                      '' ||
                                                  signInForm
                                                          .emailValidatorError !=
                                                      '' ||
                                                  signInForm
                                                          .passwordValidatorError !=
                                                      '' ||
                                                  signInForm
                                                          .confirmationPasswordValidatorError !=
                                                      '') {
                                                return;
                                              }

                                              signInForm.isLoading = true;

                                              UserCredential? userCredential =
                                                  await auth.signIn(
                                                      signInForm.email.text,
                                                      signInForm.password.text);
                                              if (userCredential != null) {
                                                final UserModel newUser =
                                                    UserModel(
                                                        uid: userCredential
                                                            .user!.uid,
                                                        email:
                                                            signInForm
                                                                .email.text,
                                                        name: signInForm
                                                            .name.text);
                                                try {
                                                  await database
                                                      .saveUserInfo(newUser);
                                                } catch (e) {
                                                  print(e);
                                                }
                                              }

                                              signInForm.isLoading = false;
                                              if (userCredential != null) {
                                                print(await userCredential.user!
                                                    .getIdToken());
                                                if (context.mounted) {
                                                  uiProvider.selectedMenuOpt =
                                                      0;

                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          'navigationScreen');
                                                }
                                              } else {
                                                _message();
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          foregroundColor: AppTheme
                                              .buttonLabelColor
                                              .withOpacity(0.8),
                                          backgroundColor: Colors.white),
                                      child: Text(
                                        signInForm.isLoading
                                            ? 'Cargando...'
                                            : 'Registrarse',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1.0,
                                width: size.width * 0.2,
                                color: Colors.grey,
                              ),
                              Text(
                                'Otro método',
                                style: subTitleStyle,
                              ),
                              Container(
                                height: 1.0,
                                width: size.width * 0.2,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  UserCredential? user =
                                      await AuthService().signInWithGoogle();
                                  if (user != null) {
                                    print('respuestaaaaa');

                                    print(user.user?.displayName);
                                    print(user.user?.email);
                                    print(user.user?.uid);
                                    if (user.user != null) {
                                      UserModel? userRegisterd =
                                          await DatabaseService()
                                              .getUserInfo(user.user!.uid);

                                      if (userRegisterd != null) {
                                        if (mounted) {
                                          Navigator.pushReplacementNamed(
                                              context, 'saveAccount');
                                        }
                                      } else {
                                        await DatabaseService().saveUserInfo(
                                            UserModel(
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
                                      child: Image.asset(
                                          'assets/google_logo.png')),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (Platform.isIOS)
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child:
                                          Image.asset('assets/apple_logo.png')),
                                )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
