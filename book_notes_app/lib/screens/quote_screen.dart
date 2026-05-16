import 'package:flutter/material.dart';
import 'about_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const List<Map<String, String>> _quotes = [
    {'text': 'Ученье — свет, а неученье — тьма.', 'author': 'Русская пословица'},
    {'text': 'Не откладывай на завтра то, что можно сделать сегодня.', 'author': 'Бенджамин Франклин'},
    {'text': 'Дорогу осилит идущий.', 'author': 'Русская пословица'},
    {'text': 'Жить — значит действовать.', 'author': 'Оноре де Бальзак'},
    {'text': 'Знание — сила.', 'author': 'Фрэнсис Бэкон'},
    {'text': 'Лучше поздно, чем никогда.', 'author': 'Русская пословица'},
    {'text': 'Терпение и труд всё перетрут.', 'author': 'Русская пословица'},
  ];

  late Map<String, String> _currentQuote;

  @override
  void initState() {
    super.initState();
    final dayIndex = DateTime.now().weekday - 1;
    _currentQuote = _quotes[dayIndex];
  }

  void _showDailyQuote() {
    final dayIndex = DateTime.now().weekday - 1;
    setState(() => _currentQuote = _quotes[dayIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Цитата дня'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _showDailyQuote,
                child: const Text('Цитата дня'),
              ),
              const SizedBox(height: 32),
              Text(
                '«${_currentQuote['text']}»',
                style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '— ${_currentQuote['author']}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text(
                '7 цитат — каждый день своя',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
