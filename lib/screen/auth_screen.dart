import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/form/auth_form.dart';

class AuthScreen extends StatefulWidget {
  // const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitauthForm(String email, String password, String username,
      File image, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
//comment added
        final reff = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${authResult.user?.uid}.jpg');
        UploadTask uploadTask = reff.putFile(image);

        final snapshot = await uploadTask.whenComplete(() => null);

        final String url = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({'username': username, 'email': email, 'imageUrl': url});
      }
    } on PlatformException catch (er) {
      var message = ' An error occured';
      if (er.message != null) {
        message = er.message.toString();
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));

      setState(() {
        _isLoading = false;
      });
    } catch (er) {
      var mes = er.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(mes),
        backgroundColor: Colors.red,
      ));
      print(er);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://appadvice.com/cdn-cgi/mirage/80ec584b7eeb7e415153342264be8f6a183ab0093f2374a280e6e387f47020ee/1280/https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/34/20/53/342053e2-ddd3-5c0b-3109-790723268566/AppIcon-0-0-1x_U007emarketing-0-0-0-6-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/256x256bb.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: AuthForm(_submitauthForm, _isLoading)),
    );
  }
}
