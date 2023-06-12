import 'package:first_project/components/difficulty.dart';
import 'package:first_project/data/task_dao.dart';
import 'package:flutter/material.dart';


class Task extends StatefulWidget {
  final String name;
  final String image;
  final int difficulty;

  Task(this.name, this.image, this.difficulty, {super.key});

  int level = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  bool assetOrNetwork(){
    if(widget.image.contains('http')){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
          ),
          Column(
            children: [
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.blue,
                        ),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: (assetOrNetwork()) ? Image.asset(
                              widget.image,
                              fit: BoxFit.cover
                          ) : Image.network(
                              widget.image,
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.name,
                              style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Difficulty(difficultyLevel: widget.difficulty),
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                        onLongPress: (){
                          TaskDao().delete(widget.name);
                          print('Excluiu!');
                        },
                        onPressed: (){
                          setState(() {
                            widget.level++;
                          });
                        }, child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_drop_up),
                            Text('Up', style: TextStyle(fontSize: 12, color: Colors.white))
                          ],
                        )),
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.difficulty > 0 ) ? (widget.level/widget.difficulty)/10 : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Nível: ${widget.level}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}