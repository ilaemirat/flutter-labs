import 'package:flutter/material.dart';
import 'about_screen.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки дня'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Введите заметку...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: null, // логика — в ЛР5
                  child: const Text('Добавить'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  title: Text('Текст заметки 1'),
                  subtitle: Text('16.05.2026'),
                  trailing: Icon(Icons.close),
                ),
                ListTile(
                  title: Text('Текст заметки 2'),
                  subtitle: Text('16.05.2026'),
                  trailing: Icon(Icons.close),
                ),
                ListTile(
                  title: Text('Текст заметки 3'),
                  subtitle: Text('15.05.2026'),
                  trailing: Icon(Icons.close),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
