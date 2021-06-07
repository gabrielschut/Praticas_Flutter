import 'package:flutter/material.dart';
import 'package:loja_exemplo/exceptions/firebase_exception.dart';
import 'package:loja_exemplo/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final Map<String, String> _authData = {
    'e-mail': '',
    'password': '',
  };

  GlobalKey<FormState> _form = GlobalKey();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  bool _isLoading = false;

  void _showErrorDialog(String msg){
    showDialog(context: context,
        builder: (ctx)=> AlertDialog(
          title: Text("Erro"),
          content: Text(msg),
          actions: [
            TextButton(onPressed: ()=> Navigator.of(context).pop(),
                child: Text('Fechar')
            ),
          ],
        )
    );
  }

  Future<void> _submit() async {
  if(_form.currentState.validate()){
    return;
  }
  setState(() {
    _isLoading = true;
  });

  _form.currentState.save();

  Auth auth =  Provider.of(context,listen: false);
  try{
    if(_authMode == AuthMode.Login){
      await auth.signup(
          _authData['email'],
          _authData['password'],
      );
    }else{
      await auth.signup(
          _authData['email'],
          _authData['password'],
      );
    }
  }on AuthException catch (error) {
    _showErrorDialog(error.toString());
  } catch (error) {
    _showErrorDialog("Ocorreu um erro inesperado!");
  }


  setState(() {
    _isLoading = false;
  });
  }

  void _swithAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: _authMode == AuthMode.Login
            ? deviceSize.height * 0.48
            : deviceSize.height * 0.555,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Informe um E-mail valido';
                  }
                  return null;
                },
                onSaved: (value) => _authData['e-mail'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe uma senha valida';
                  } else if (value.length < 5) {
                    return 'A senha minima é de 5 caracteres';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => _authData['password'] = value,
                controller: _passwordController,
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Falha na confirmação de senha';
                          } else {
                            return null;
                          }
                        }
                      : null,
                ),
             Spacer(),
              Container(
                height: 50,
                width: _authMode == AuthMode.Login ? 110 : 130,
                child: _isLoading
                    ? RefreshProgressIndicator()
                    : ElevatedButton(
                        child: Text(
                          _authMode == AuthMode.Login
                              ? 'ENTRAR'
                              : 'FAZER CADASTRO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 8.0,
                            ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        onPressed: () => _submit(),
                      ),
              ),
              TextButton(
                child: _authMode == AuthMode.Login
                    ? Text('Criar conta?')
                    : Text('Já possui Conta?'),
                onPressed: _swithAuthMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
