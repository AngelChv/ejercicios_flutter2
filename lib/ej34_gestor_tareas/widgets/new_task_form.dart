import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task_list_provider.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({super.key});

  @override
  State<StatefulWidget> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  int? _tagSelectedId;

  void showNotification(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Tarea creada")));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              // Título
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: TextFormField(
                    controller: _titleCtrl,
                    decoration: const InputDecoration(
                      labelText: "Título",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Introduzca un título";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Expanded(
                // Descripción
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: TextFormField(
                    controller: _descriptionCtrl,
                    decoration: const InputDecoration(
                      labelText: "Descripción",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: IconButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final task = Task(
                        title: _titleCtrl.text,
                        description: _descriptionCtrl.text,
                      );

                      final taskListProvider = context.read<TaskListProvider>();
                      final txt = (await taskListProvider.addTask(task))
                          ? "Tarea creada"
                          : "Error al crear la tarea";
                      showNotification(txt);
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              )
            ],
          ),

          // todo hacer un widget TagList:
          // Etiquetas:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
            child: Row(
              children:
                  List<Padding>.generate(Tag.values.length, (int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(Tag.values[index].label),
                    selected: _tagSelectedId == index,
                    onSelected: (selected) {
                      setState(() {
                        _tagSelectedId = selected ? index : null;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
