import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
import 'package:beatconnect/model.dart';
import 'package:beatconnect/koneksi.dart';
import 'package:beatconnect/view/tab/tap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool isLoading = false;

  final ApiService apiService = ApiService();

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      User user = User(
        email: emailController.text,
        password: passwordController.text,
      );

      bool success = await apiService.login(user);
      setState(() {
        isLoading = false;
      });

      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Tabs()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: height,
              child: Stack(
                children: [
                  // Bagian atas
                  Container(
                    height: height / 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Millions of songs, free on BeatConnect',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: height,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Form Login
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 20),
                              height: height / 1.9,
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Login Account',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 22),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email or Username',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SwitchListTile.adaptive(
                                    activeColor: ColorConstants.primaryColor,
                                    value: rememberMe,
                                    onChanged: (bool value) {
                                      setState(() {
                                        rememberMe = value;
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(0),
                                    title: const Text('Remember me'),
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(31),
                                    ),
                                    height: 40,
                                    color: ColorConstants.primaryColor,
                                    onPressed: isLoading ? null : handleLogin,
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            'LOG IN',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
