import 'package:flutter/material.dart';
import 'package:test_app/theme/app_button_style.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, color: Colors.black);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const _FormWidget(),
          const SizedBox(
            height: 25,
          ),
          const Text(
              'In order to use the editing and rating capabilities of TMDb, as well as get personal recommendations you will need to login to your account. if you do not have an account, registering for an account is free and simple. Click here to get started.',
              style: textStyle),
          const SizedBox(height: 5),
          TextButton(
              onPressed: () {},
              style: AppButtonClass.linkButton,
              child: const Text('Register')),
          const SizedBox(height: 25),
          const Text(
              'If you signed up but didn`t get ypur verification email, click here to have it resent.',
              style: textStyle),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            style: AppButtonClass.linkButton,
            child: const Text(
              'Verify email',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/custom_paint');
            },
            style: AppButtonClass.linkButton,
            child: const Text(
              'Open CustomPaint',
            ),
          )
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController(text: 'admin');
  final _passwordTextController = TextEditingController(text: 'admin');
  String? errorText;
  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    if (login == 'admin' && password == 'admin') {
      errorText = null;

      Navigator.of(context).pushNamed('/main_screen');
    } else {
      errorText = "Не верный логин или пароль";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, color: Color(0xFF212529));
    const colorForButton = Color(0xFF01B4E4);
    final textFieldDecorator = InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        isCollapsed: true);
    final errorText = this.errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _loginTextController,
          decoration: textFieldDecorator,
          // keyboardAppearance: Brightness.dark,
          // textInputAction: TextInputAction.next,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _passwordTextController,
          decoration: textFieldDecorator,
          // obscuringCharacter: '*',
          obscureText: true,
          // keyboardAppearance: Brightness.dark,
        ),
        if (errorText != null) ...[
          Text(
            errorText,
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _auth();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(colorForButton),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8))),
              child: const Text(
                'Login',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {},
              style: AppButtonClass.linkButton,
              child: const Text('Reset password'),
            ),
          ],
        )
      ],
    );
  }
}
