import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'VoltWise',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Text(
                'Please enter your e-mail address and enter password',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
              ),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                // controller: loginController.email,
                decoration: InputDecoration(
                  labelText: 'Enter e-mail id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  // fillColor: colorSearchBg,
                ),
                onSubmitted: (_) => {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                textAlign: TextAlign.center,
                // controller: loginController.pwd,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter the password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  // fillColor: colorSearchBg,
                ),
                onSubmitted: (_) => {},
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              'Forgot Password?',
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 200,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 86, 173, 244),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                // Replace childWidget with your desired child widget
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {},
                  child: Text('Register'),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
