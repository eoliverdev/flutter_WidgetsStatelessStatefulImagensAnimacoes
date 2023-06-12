import 'package:first_project/components/task.dart';
import 'package:first_project/data/task_dao.dart';
import 'package:first_project/screens/form_screen.dart';
import 'package:flutter/material.dart';

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
        actions: [
          IconButton(onPressed: (){setState((){});}, icon: const Icon(Icons.refresh))
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top:8, bottom: 70),
          child: FutureBuilder<List<Task>>(future: TaskDao().findAll(), builder: (context, snapshot){
            List<Task>? items = snapshot.data;
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...')
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...')
                    ],
                  ),
                );
              case ConnectionState.active:
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...')
                    ],
                  ),
                );
              case ConnectionState.done:
                if(snapshot.hasData && items != null){
                  if(items.isNotEmpty){
                    return ListView.builder(itemCount: items.length, itemBuilder: (BuildContext context, int index){
                      final Task task = items[index];
                      return task;
                    });
                  }
                  return const Center(
                      child: Column(
                          children: [
                            SizedBox(width: 250, height: 200,),
                            Icon(Icons.error_outline, size: 32, color: Colors.blue,),
                            Text('Não há nenhuma Tarefa', style: TextStyle(fontSize: 18))
                          ]
                      )
                  );
                }
                return const Text('Erro ao carregar Tarefas');
            }
            return const Text('Erro desconhecido ao carregar Tarefas');

          }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (contextNew) => FormScreen(taskContext: context),
              ),
            ).then((value) => setState(() {
              print('Recarregando a tela inicial');
            }));
          },
          child: const Icon(Icons.add)
      ),
    );
  }
}