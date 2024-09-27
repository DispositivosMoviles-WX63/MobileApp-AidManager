import 'package:aidmanager_mobile/config/router/app_router.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  static const name = 'payment_screen';

  const PaymentScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

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
                                              value: false,
                                              onChanged: (value) {},
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
                                              value: false,
                                              onChanged: (value) {},
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
                                    onPressed: () {},
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
