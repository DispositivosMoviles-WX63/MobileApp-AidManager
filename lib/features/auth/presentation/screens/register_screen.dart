import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/access_code_team_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/passwords_not_same_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  static const String name = "register_screen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  // to manage the checkboxs owo
  bool isDirectorSelected = true;
  bool isTeamSelected = false;

  void onSubmitRegister() {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;

    /* if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordConfirm.isEmpty ||
        (!isDirectorSelected && !isTeamSelected)) {
      // mostrar dialogo cuando no se cumpletaron todos los inputs
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IsEmptyDialog();
          });

      return;
    }

    if (!(password == passwordConfirm)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const PasswordsNotSameDialog();
          });

      return;
    } */

    // navegar a la pantalla de tutorial si se ha completado los filtros :p
    isTeamSelected
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AccessCodeTeamDialog();
            })
        : context.go('/payment');
  }

  @override
  Widget build(BuildContext context) {
    //final double containerHeight = MediaQuery.of(context).size.height * 0.25;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.darkGreen,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 210,
                    child: Center(
                      child: SizedBox(
                        width: deviceWidth * 0.85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: const Offset(0, 5),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.0,
                                      height: 1.5,
                                      letterSpacing: 0.85),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Create an account\nin '),
                                    TextSpan(
                                      text: 'AidManager',
                                      style: TextStyle(
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/images/register-person.png',
                              width: 160.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CustomColors.lightGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: deviceWidth * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Transform your idea with us",
                                    style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      height: 1.75,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _firstNameController,
                                          keyboardType: TextInputType.name,
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: CustomColors.fieldGrey,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: CustomColors.grey,
                                              ),
                                            ),
                                            hintText: 'First Name',
                                            hintStyle:
                                                const TextStyle(fontSize: 18.0),
                                            suffixIcon: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 18.0),
                                              child:
                                                  Icon(Icons.person, size: 28),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 18.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: TextField(
                                          controller: _lastNameController,
                                          keyboardType: TextInputType.name,
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: CustomColors.fieldGrey,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: CustomColors.grey,
                                              ),
                                            ),
                                            hintText: 'Last Name',
                                            hintStyle:
                                                const TextStyle(fontSize: 18.0),
                                            suffixIcon: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 18.0),
                                              child: Icon(Icons.person_add,
                                                  size: 28),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 18.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(fontSize: 18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: CustomColors.fieldGrey,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: CustomColors.grey,
                                        ),
                                      ),
                                      hintText: 'Institution Email',
                                      hintStyle:
                                          const TextStyle(fontSize: 18.0),
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child:
                                            Icon(Icons.email_rounded, size: 28),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 18.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: _passwordController,
                                    style: const TextStyle(fontSize: 18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: CustomColors.fieldGrey,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: CustomColors.grey,
                                        ),
                                      ),
                                      hintText: 'Password',
                                      hintStyle:
                                          const TextStyle(fontSize: 18.0),
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child: Icon(Icons.remove_red_eye,
                                            size: 28),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 18.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextField(
                                    controller: _passwordConfirmController,
                                    style: const TextStyle(fontSize: 18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: CustomColors.fieldGrey,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: CustomColors.grey,
                                        ),
                                      ),
                                      hintText: 'Confirm Password',
                                      hintStyle:
                                          const TextStyle(fontSize: 18.0),
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child: Icon(Icons.lock, size: 28),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 18.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.25,
                                            child: Checkbox(
                                              value: isDirectorSelected,
                                              onChanged: (value) =>
                                                  setState(() {
                                                isDirectorSelected =
                                                    value ?? false;
                                                if (isDirectorSelected) {
                                                  isTeamSelected = false;
                                                }
                                              }),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              activeColor: Colors.green,
                                            ),
                                          ),
                                          const Text(
                                            'Director',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 35),
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.25,
                                            child: Checkbox(
                                              value: isTeamSelected,
                                              onChanged: (value) =>
                                                  setState(() {
                                                isTeamSelected = value ?? false;
                                                if (isTeamSelected) {
                                                  isDirectorSelected = false;
                                                }
                                              }),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              activeColor: Colors.green,
                                            ),
                                          ),
                                          const Text(
                                            'Team',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  ElevatedButton(
                                    onPressed: () {
                                      onSubmitRegister();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: CustomColors
                                          .darkGreen, // Color de fondo
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      minimumSize:
                                          const Size(double.infinity, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Create account',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.8),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(color: Colors.transparent),
                                  ),
                                  const Center(
                                    child: _HaveAccountText(),
                                  ),
                                  const SizedBox(height: 15)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 10.0,
                left: 0.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HaveAccountText extends StatelessWidget {
  const _HaveAccountText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.8,
          color: Colors.black,
        ),
        children: [
          const TextSpan(
            text: "Already have an account? ",
          ),
          TextSpan(
            text: 'Sign in',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.teal,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push('/');
              },
          ),
        ],
      ),
    );
  }
}
