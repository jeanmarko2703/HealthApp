import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_app/screens/onboarding_backgroun.dart';
import 'package:health_app/theme/app_theme.dart';
import 'package:health_app/widgets/widgets.dart';

import '../providers/auth.dart';
import '../providers/providers.dart';

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
    const TextStyle titleStyle = TextStyle(
        color: Colors.white, fontSize: 35, fontWeight: FontWeight.w700);
    const TextStyle subTitleStyle = TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const OnboardingBackground(),
            Positioned(
                top: size.height * 0.08,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    color: Colors.white,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.15, bottom: size.height * 0.1),
                      child: const Text(
                        "Health app",
                        style: titleStyle,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                        key: loginForm.formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: const Text(
                                    "Log In",
                                    style: subTitleStyle,
                                  )),

                              CustomInput(
                                title: Text(
                                  ' Correo:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
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
                                title: Text(' Contraseña:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.5))),
                                backgroundColor: Colors.white,
                                obscureText: hiddenPassword,
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hiddenPassword = !hiddenPassword;
                                    });
                                  },
                                  icon: Icon(hiddenPassword == false
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye),
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
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ElevatedButton(
                                    onPressed: loginForm.isLoading
                                        ? null
                                        : () async {
                                            final authProvider =
                                                Provider.of<AuthProvider>(
                                                    context,
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
                                                loginForm
                                                        .passwordValidatorError !=
                                                    '') return;
                                            //login button state
                                            loginForm.isLoading = true;

                                            //login request

                                            var access =
                                                await authProvider.logIn(
                                                    loginForm.email.text,
                                                    loginForm.password.text);

                                            if (access != null &&
                                                context.mounted) {
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
                                        elevation: 0,
                                        foregroundColor: AppTheme
                                            .buttonLabelColor
                                            .withOpacity(0.8),
                                        backgroundColor: Colors.white),
                                    child: Text(
                                      loginForm.isLoading
                                          ? 'Cargando...'
                                          : 'Iniciar Sesión',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                              TextButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: null,
                                  child:
                                      const Text('¿ Olvidaste tu contraseña ?'))
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Image.asset('assets/google_logo.png')),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
