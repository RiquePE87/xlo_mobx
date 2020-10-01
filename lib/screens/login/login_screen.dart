import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';
import 'package:xlo_mobx/stores/login_store.dart';

class LoginScreen extends StatelessWidget {
  LoginStore loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Acessar com E-mail",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[900], fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      onChanged: loginStore.setEmail,
                      decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(),
                          errorText: loginStore.emailError),
                      keyboardType: TextInputType.emailAddress,
                    );
                  }),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Senha",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        GestureDetector(
                          child: Text(
                            "Esqueceu sua senha?",
                            style: TextStyle(
                                color: Colors.purple,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      onChanged: loginStore.setPassword,
                      decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(),
                          errorText: loginStore.passwordError),
                      obscureText: true,
                    );
                  }),
                  Observer(builder: (_) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12, top: 28),
                      height: 40,
                      child: RaisedButton(
                        onPressed: loginStore.loginPressed,
                        color: Colors.orange,
                        disabledColor: Colors.orange.withAlpha(120),
                        child: loginStore.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text("ENTRAR"),
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    );
                  }),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          "Não tem conta? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SignUpScreen()));
                          },
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
