import 'package:first_project/components/task.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: (opacidade) ? 1 : 0,
        duration: const Duration(milliseconds: 1000),
        child: ListView(
          children: const [
            Task('Aprender Flutter', 'assets/images/Eu7m692XIAEvxxP.png', 3),
            Task('Andar de Bike', 'assets/images/images.png', 2),
            Task('Meditar', 'assets/images/plena-e1579805752463.jpg', 4),
            Task('Jogar', 'assets/images/jogos-825x450px.webp', 1),
            Task('Meditar na hora do almoço em dia de trabalho', 'assets/images/meditacao-no-trabalho-97077984.webp', 5),
            SizedBox(height: 80)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          opacidade = !opacidade;
        });
      },
          child: const Icon(Icons.remove_red_eye)
      ),
    );
  }
}