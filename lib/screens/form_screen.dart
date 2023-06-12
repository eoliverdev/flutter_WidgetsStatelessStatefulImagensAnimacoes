import 'package:first_project/components/task.dart';
import 'package:first_project/data/task_dao.dart';
import 'package:first_project/data/task_inherited.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});
  final BuildContext taskContext;
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool valueValidator(String? value){
    if(value != null && value.isEmpty){
      return true;
    }
    return false;
  }

  bool difficultyalidator(String? value){
    if(value != null && value.isEmpty){
      if(int.parse(value) > 5 || int.parse(value) < 1){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.black26)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value){
                        if(valueValidator(value)){
                          return 'Insira o nome da tarefa';
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white,
                        filled: true
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(difficultyalidator(value)){
                          return 'Insira uma dificuldade da tarefa entre 1 e 5';
                        }
                        return null;
                      },
                      controller: difficultyController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dificuldade',
                          fillColor: Colors.white,
                          filled: true
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value){
                        if(valueValidator(value)){
                          return 'Insira a imagem da tarefa';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      onChanged: (text){
                        setState(() {});
                      },
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Imagem',
                          fillColor: Colors.white,
                          filled: true
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.white),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          imageController.text,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                            return Image.asset('assets/images/no-photo-available.png');
                          },
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          TaskDao().save(Task(nameController.text, imageController.text, int.parse(difficultyController.text)));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Criando nova tarefa...'),
                                  backgroundColor: Colors.blue,
                              ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Adicionar')
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
