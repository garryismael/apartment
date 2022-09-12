import 'package:flutter/material.dart';
import 'package:prestation/pages/home_page.dart';
import 'package:prestation/pages/user/user.dart';
import 'package:prestation/services/services.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _form();
  }

  Widget _form() {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Form(
        key: _formKey,
        child: SizedBox(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isLoading
                      ? [
                          const Center(
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ]
                      : list(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> list() {
    return <Widget>[
      const Center(
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: isVisible,
        child: const Center(
          child: Text(
            "Invalid User or Password",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: passwordController,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: "Password",
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        },
        child: const Text(
          "Register?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (() async {
                setState(() {
                  isLoading = true;
                });
                String email = emailController.text;
                String password = passwordController.text;
                var resp = await Service.login(email, password);
                if (!mounted) return;

                setState(() {
                  isLoading = false;
                });

                if (resp) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                } else {
                  setState(() {
                    isVisible = true;
                  });
                }
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
