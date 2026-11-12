import 'package:flutter/material.dart';
import 'cadastro_contato_page.dart';
final navigatorKey = GlobalKey<NavigatorState>();

final List<String> nomes = [
    'João Silva',
    'Maria Oliveira',
    'Pedro Santos',
    'Ana Souza',
];

final List<Map<String,String>> contatos = [
    {'nome' : 'João Silva', 'telefone' : '(62) 99999-9999', 'email' : 'joao@gmail.com'},
    {'nome' : 'Maria Oliveira', 'telefone' : '(62) 88888-8888', 'email' : 'maria@gmail.com'},
    {'nome' : 'Pedro Santos', 'telefone' : '(62) 77777-7777', 'email' : 'pedro@gmail.com'},
    {'nome' : 'Ana Souza', 'telefone' : '(62) 66666-6666', 'email' : 'ana@gmail.com'},
];

class AgendaPage extends StatefulWidget {
    const AgendaPage({super.key});

    @override
    State<AgendaPage> createState() {
        return _AgendaPageState();
    }

}

class _AgendaPageState extends State<AgendaPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text("Agenda"),
            ),
            body: ListView.builder(
                itemCount: contatos.length,
                itemBuilder: (context, index) {
                    return ListTile(

                        onTap: () async {
                            final contatoEditado = await Navigator.push<Map<String,String>>(
                                navigatorKey.currentContext!,
                                MaterialPageRoute(
                                    builder: (context) => CadastroContatoPage(contato: contatos[index]),
                                ),
                            );
                            if(contatoEditado != null && mounted){
                                setState(() {
                                    contatos[index] = contatoEditado;
                                });
                            }
                        },

                        leading: const Icon(Icons.person),
                        title: Text(contatos[index]['nome']!),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(contatos[index]['telefone']!),
                                Text(contatos[index]['email']!),
                            ],
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: Text('Excluir Contato'),
                                        content: Text('Deseja excluir o contato ${contatos[index]['nome']!}?'),
                                        actions: [
                                            TextButton(
                                                onPressed: () {
                                                    Navigator.pop(context);
                                                },
                                                child: Text('Cancelar'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                    setState(() {
                                                        contatos.removeAt(index);
                                                    });
                                                    Navigator.pop(context);
                                                },
                                                child: Text('Excluir'),
                                            ),
                                        ],
                                    ),
                                );
                            },
                        ),
                    );
                },
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                    final novoContato = await Navigator.push<Map<String,String>>(
                        navigatorKey.currentContext!,
                        MaterialPageRoute(
                            builder: (context) => CadastroContatoPage(),
                        ),
                    );
                    debugPrint('Contato recebido $novoContato');
                    if(novoContato != null){
                        setState(() {
                            contatos.add(novoContato);
                        });
                    }
                },
                child: Icon(Icons.add),
            ),
        );
    }
}

void mainAntigo() {
    runApp(
        MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: Text("Agenda"),
                ),
                body: ListView.builder(
                    itemCount: contatos.length,
                    itemBuilder: (context, index) {
                        return ListTile(

                            leading: Icon(Icons.person),
                            title: Text(contatos[index]['nome']!),

                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(contatos[index]['telefone']!),
                                    Text(contatos[index]['email']!),
                                ],
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {},
                            ),
                        );
                    },
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                        final novoContato = await Navigator.push<Map<String,String>>(
                            navigatorKey.currentContext!,
                            MaterialPageRoute(
                                builder: (context) => CadastroContatoPage(),
                            ),
                        );
                        debugPrint('Contato recebido $novoContato');
                        if(novoContato != null){
                            contatos.add(novoContato);
                        }
                    },
                    child: Icon(Icons.add),
                ),
            ),
        ),
    );
}

void main(){
    runApp(MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const AgendaPage(),
    ));
}