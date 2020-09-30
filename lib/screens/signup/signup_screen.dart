import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Observer(builder: (_){
                      return ErrorBox(
                        message: signupStore.error
                      );
                    }),
                    FieldTitle(
                      title: "Apelido",
                      subtitle: "Como aparecerá em seus anúncios",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        onChanged: signupStore.setName,
                        decoration: InputDecoration(
                            errorText: signupStore.nameError,
                            isDense: true,
                            border: OutlineInputBorder(),
                            hintText: "Exemplo: João S."),
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: "E-mail",
                      subtitle: "Enviaremos um e-mail de confirmação",
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          onChanged: signupStore.setEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              errorText: signupStore.emailError,
                              hintText: "Exemplo: joao@gmail.com."),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: "Celular",
                      subtitle: "Proteja sua conta",
                    ),
                    Observer(
                      builder: (_){
                        return TextField(
                          enabled: !signupStore.loading,
                          onChanged: signupStore.setPhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              isDense: true,
                              errorText: signupStore.phoneError,
                              border: OutlineInputBorder(),
                              hintText: "(99) 99999-9999"),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: "Senha",
                      subtitle:
                          "Utilize números, letras e caracteres especiais",
                    ),
                    Observer(
                      builder: (_){
                        return TextField(
                          enabled: !signupStore.loading,
                          onChanged: signupStore.setPassword1,
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: signupStore.password1Error,
                              isDense: true, border: OutlineInputBorder()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: "Confirmar a senha",
                      subtitle: "Repita a senha",
                    ),
                    Observer(
                      builder: (_){
                        return TextField(
                          enabled: !signupStore.loading,
                          onChanged: signupStore.setPassword2,
                          obscureText: true,
                          decoration: InputDecoration(
                              errorText: signupStore.password2Error,
                              isDense: true, border: OutlineInputBorder()),
                        );
                      },
                    ),
                    Observer(builder: (_){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12, top: 28),
                        height: 40,
                        child: RaisedButton(
                          onPressed: signupStore.signUpPressed,
                          color: Colors.orange,
                          child: signupStore.loading ?
                          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),) : Text("CADASTRAR"),
                          textColor: Colors.white,
                          elevation: 0,
                          disabledColor: Colors.orange.withAlpha(120),
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
                            "Já tem conta? ",
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: Text(
                              "Entrar",
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
      ),
    );
  }
}
