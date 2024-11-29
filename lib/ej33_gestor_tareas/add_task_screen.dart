import 'package:ejercicios_flutter2/ej33_gestor_tareas/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Tarea"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: TaskForm(),
      ),
    );
  }
}

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<StatefulWidget> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              label: Text("Nueva tarea"),
              hintText: "Nueva Tarea",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Introduzca un nombre";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<TaskProvider>().addTask(_nameController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text("Agregar"),
            ),
          ),
        ],
      ),
    );
  }
}
