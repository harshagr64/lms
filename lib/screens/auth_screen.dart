import "package:flutter/material.dart";
import "../widgets/sign_in.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        child: Center(
          child: _isLoading
                  ? CircularProgressIndicator( backgroundColor: Colors.black,)
                  :FlatButton(
              child:  Container(
                      height: 60,
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign in with",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            child: Image.asset(
                              'assets/images/googlelogo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
              onPressed:  () {
                      setState(() {
                        _isLoading = true;
                      });

                      signwithgoogle();

                      setState(() {
                        _isLoading = false;
                      });
                    }
          

              ),
        ),
      ),
    );
  }
}
