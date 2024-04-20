import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../data/model/model.dart';
import '../../data/usecase/login.usecase.dart';
import '../../interfaces/repository/login.repository.dart';
import '../home/home.view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoginRepository loginRepository = LoginUsecase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      const FlutterLogo(size: 100),
                      const SizedBox(height: 20),
                      Container(
                        height: 270,
                        width: constraints.maxWidth / 1.2,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            LoginFieldComponent(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              label: "Email",
                              onChanged: (value) =>
                                  setState(() => emailController.text = value),
                            ),
                            const SizedBox(height: 20),
                            LoginFieldComponent(
                              controller: passwordController,
                              textInputAction: TextInputAction.done,
                              label: "Password",
                              onChanged: (value) => setState(
                                  () => passwordController.text = value),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  final response = await loginRepository
                                      .login(LoginRequestModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ));
                                  if (response != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            HomeView(entity: response),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content:
                                            Text('email or password incorrect'),
                                      ),
                                    );
                                  }
                                },
                                child: Semantics(
                                  button: true,
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        "Marcelo Cesar",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
