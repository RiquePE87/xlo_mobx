import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FieldTitle(
                      title: "Apelido",
                      subtitle: "Como aparecerá em seus anúncios",
                    ),
                    Observer(builder: (_){
                      return TextField(
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
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          hintText: "Exemplo: joao@gmail.com."),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: "Celular",
                      subtitle: "Proteja sua conta",
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          hintText: "(99) 99999-9999"),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: "Senha",
                      subtitle: "Utilize números, letras e caracteres especiais",
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          isDense: true, border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: "Confirmar a senha",
                      subtitle: "Repita a senha",
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          isDense: true, border: OutlineInputBorder()),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12, top: 28),
                      height: 40,
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.orange,
                        child: Text("CADASTRAR"),
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
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
