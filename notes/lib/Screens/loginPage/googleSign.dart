import 'package:flutter/material.dart';

// this function requires the googleSignIn function as a parameter.
// to call this function: use => GoogleSign(_signInWithGoogle)
//
class GoogleSign extends StatelessWidget {
  final Function _signInWithGoogle;
  GoogleSign(this._signInWithGoogle);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Colors.black12),
        ],
      ),
      child: ListTile(
        title: Text(
          'Sign-in with Google',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        leading: Image(
          image: NetworkImage(
              'https://i.pinimg.com/originals/7e/a2/a0/7ea2a086cc5082330324a94c52a66531.png'),
          height: 40,
          width: 40,
        ),
        onTap: _signInWithGoogle,
      ),
    );
  }
}
