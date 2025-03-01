import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recepies_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPagesState();
  }
}

class _LoginPagesState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? userName,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text("Login "),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }
  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recepi Book",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "emilys",
              onSaved: (value)
              {
                setState(() {
                  userName = value;
                });

              },
              validator: (value){
                if(value == null || value.isEmpty)
                  {
                    return "Enter a UserName";
                  }
              },
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            TextFormField(
            initialValue: "emilyspass",
              obscureText: true,
              onSaved: (value)
              {
                setState(() {
                 password = value;
                });

              },
            validator: (value){
            if(value == null || value.length<5)
            {
                 return "Enter a Valid  Password";
            }
          },
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        onPressed: () async{
          if(_loginFormKey.currentState?.validate() ?? false)
            {
                _loginFormKey.currentState?.save();
                // print("$userName -- $password");
              bool result = await AuthService().login(userName!, password!);
              // print(result);
              if(result)
                {
                  // StatusAlert.show(
                  //   context,
                  //   duration: const Duration(seconds: 5),
                  //   title: 'Login Sucessfull',
                  //   subtitle: 'Welcom $userName',
                  //   configuration: const IconConfiguration(icon: Icons.done),
                  //   maxWidth: 260,
                  // );

                  Navigator.pushReplacementNamed(context, '/home');
                }
              else
                {
                  StatusAlert.show(
                    context,
                    duration: const Duration(seconds: 2),
                    title: 'Login Failed',
                    subtitle: 'Please try again',
                    configuration: const IconConfiguration(icon: Icons.error),
                    maxWidth: 260,
                  );
                }
            }
        },
        child: const Text("Login"),
      ),
    );
  }
}
