import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prestation/constants/service.dart';
import 'package:prestation/models/user.dart';
import 'package:prestation/pages/user/login_page.dart';
import 'package:prestation/services/services.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();

  late XFile uploadimage;

  Future<void> chooseImage() async {
    var picker = ImagePicker();
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

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
              margin: const EdgeInsets.all(4),
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
          "Register",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: isVisible,
        child: const Center(
          child: Text(
            "Invalid Data",
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
        controller: firstNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "First Name",
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
        controller: lastNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Last Name",
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
        controller: phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Phone",
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      ElevatedButton.icon(
        onPressed: () {
          chooseImage(); // call choose image function
        },
        icon: const Icon(Icons.folder_open),
        label: const Text("CHOOSE IMAGE"),
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
          "Login?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (() async {
                setState(() {
                  isLoading = true;
                });

                var req = http.MultipartRequest(
                    'POST', Uri.https(baseUrl, "$urlUser/register"));
                req.files.add(await http.MultipartFile.fromPath(
                    "image", uploadimage.path));

                req.fields['first_name'] = firstNameController.text;
                req.fields['last_name'] = lastNameController.text;
                req.fields['is_admin'] = 'False';
                req.fields['email'] = emailController.text;
                req.fields['phone'] = phoneController.text;
                req.fields['password'] = passwordController.text;

                var r = await req.send();
                var resp = r.statusCode == 201;

                if (!mounted) return;

                setState(() {
                  isLoading = false;
                });

                if (resp) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginForm(),
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
                "Register",
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

class MePage extends StatelessWidget {
  const MePage({super.key});

  Future<User> getData() async {
    var service = Service<User>(User.init(), urlUser);
    return await service.me();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error} occurred',
              style: const TextStyle(fontSize: 16),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          String? url = snapshot.data!.getImageUrl();
          var data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(
              15,
            ),
            child: Center(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(url),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text("${data.firstName} ${data.lastName}"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(data.email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(data.phone),
                      ),
                    ],
                  )),
            ),
          );
        }
      },
    );
  }
}
