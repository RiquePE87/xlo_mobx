import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
      ),
      body: Card(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(
                  "Senha",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
                    GestureDetector(
                      child: Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(
                          color: Colors.purple,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    )
                  ],
                ),
              ),
          TextField(
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          )
            ],
          ),
        ),
      ),
    );
  }
}
