import 'package:flutter/material.dart';

class CadastroContatoPage extends StatefulWidget {
    final Map<String,String>? contato;
    const CadastroContatoPage({super.key, this.contato});

    @override
    State<CadastroContatoPage> createState() {
        return _CadastroContatoPageState();
    }

}

class _CadastroContatoPageState
    extends State<CadastroContatoPage> {

    final nomeController = TextEditingController();
    final telefoneController = TextEditingController();
    final emailController = TextEditingController();

    @override
    void initState() {
        super.initState();
        if(widget.contato != null){
            nomeController.text = widget.contato!['nome'] ?? '';
            telefoneController.text = widget.contato!['telefone'] ?? '';
            emailController.text = widget.contato!['email'] ?? '';
        }
    }

    @override
    void dispose() {
        nomeController.dispose();
        telefoneController.dispose();
        emailController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('Cadastro de Contato'),
            ),
            body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                    children: [

                        TextField(
                            controller: nomeController,
                            decoration: InputDecoration(
                                labelText: 'Nome',
                                border: OutlineInputBorder(),
                            ),
                        ),

                        const SizedBox(height: 16.0),
                        TextField(
                            controller: telefoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Telefone',
                                border: OutlineInputBorder(),
                            ),
                        ),

                        const SizedBox(height: 16.0),
                        TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(),
                            ),
                        ),

                        const SizedBox(height: 16.0),
                        ElevatedButton(
                            onPressed: () {

                                String nome = nomeController.text;
                                String telefone = telefoneController.text;
                                String email = emailController.text;

                                if(nome.trim().isEmpty ||
                                    telefone.trim().isEmpty ||
                                    email.trim().isEmpty){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Atenção! Todos os campos são obrigatórios!')
                                        ),
                                    );
                                    return;
                                }

                                Navigator.pop(context, {
                                    'nome' : nome.trim(),
                                    'telefone' : telefone.trim(),
                                    'email' : email.trim(),
                                });

                            },
                            child: const Text('Salvar'),
                        ),

                    ],
                ),
            ),
        );
    }
}