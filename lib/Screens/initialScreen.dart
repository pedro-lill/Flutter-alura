import 'package:curso/Components/task.dart';
import 'package:curso/data/taskDAO.dart';
import 'package:flutter/material.dart';
import 'package:curso/Screens/formScreen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [IconButton(onPressed: (){setState(() {});},
        icon: const Icon(Icons.refresh))
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder<List<Task>>(
              future: TaskDao().findAll(),
              builder: (context, snapshot) {
                List<Task>? items = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando...'),
                        ],
                      ),
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando...'),
                        ],
                      ),
                    );
                  case ConnectionState.active:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          // centralizar texto
                          Text('Carregando...'),

                        ],
                      ),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasData && items != null) {
                      if (items.isNotEmpty) {
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Task tarefa = items[index];
                              return tarefa;
                            });
                      }
                      return const Center(
                        child: Column(
                          children: [
                            Icon(Icons.error_outline, size: 128),
                            Text(
                              'Nenhuma tarefa cadastrada',
                              style: TextStyle(fontSize: 28),
                              
                            ),
                          ],
                        ),
                      );
                    }
                    return const Text('Erro ao carregar tarefas');
                }
              }
            )
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState(() {
          },));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
