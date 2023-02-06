import 'dart:io';
import 'package:flutter/material.dart';
import '../image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  
  final  bool isLoading;
  final void Function(String email,
   String password, 
   String username,
 File image,
  bool isLogin,
   BuildContext ctx) 
   submitFn;


  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _username = '';
  var _password = '';
   File _userImage;

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _submitForm() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

   
    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'please pick User image',
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _email.trim(),
           _password.trim(), 
           _username.trim(), 
           _userImage,
           _isLogin, 
           context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                      key: const ValueKey('email'),
                      onSaved: (val) {
                        _email = val;
                      },
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'please insert avalid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'email')),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      onSaved: (val) {
                        _username = val;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'username'),
                      
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (val) {
                      _password = val;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'password must be at least 7 characters long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'password',
                    ),
                    obscureText: true,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                        ),
                        onPressed: ()=>_submitForm(),
                        child: Text(
                          _isLogin ? 'Login' : 'SignUp',
                        )),
                  if (!widget.isLoading)
                    ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create Account'
                            : 'Already have an Account'))
                ],
              ),
            )),
      ),
    );
  }
}
