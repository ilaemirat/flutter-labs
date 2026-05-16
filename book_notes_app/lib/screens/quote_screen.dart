import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'about_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const List<Map<String, String>> _localQuotes = [
    {'text': 'Ученье — свет, а неученье — тьма.', 'author': 'Русская пословица'},
    {'text': 'Не откладывай на завтра то, что можно сделать сегодня.', 'author': 'Бенджамин Франклин'},
    {'text': 'Дорогу осилит идущий.', 'author': 'Русская пословица'},
    {'text': 'Жить — значит действовать.', 'author': 'Оноре де Бальзак'},
    {'text': 'Знание — сила.', 'author': 'Фрэнсис Бэкон'},
    {'text': 'Лучше поздно, чем никогда.', 'author': 'Русская пословица'},
    {'text': 'Терпение и труд всё перетрут.', 'author': 'Русская пословица'},
  ];

  String _quoteText = '';
  String _quoteAuthor = '';
  bool _isLoading = false;
  String _source = 'local';

  @override
  void initState() {
    super.initState();
    final dayIndex = DateTime.now().weekday - 1;
    _quoteText = _localQuotes[dayIndex]['text']!;
    _quoteAuthor = _localQuotes[dayIndex]['author']!;
  }

  Future<void> _fetchRandomQuote() async {
    setState(() => _isLoading = true);
    try {
      final response = await http
          .get(Uri.parse(
              'https://api.forismatic.com/api/1.0/?method=getQuote&lang=ru&format=json'))
          .timeout(const Duration(seconds: 6));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = (data['quoteText'] as String?)?.trim() ?? '';
        final author = (data['quoteAuthor'] as String?)?.trim() ?? '';
        if (text.isNotEmpty) {
          setState(() {
            _quoteText = text;
            _quoteAuthor = author.isEmpty ? 'Автор неизвестен' : author;
            _source = 'api';
          });
          return;
        }
      }
    } catch (_) {}
    // Fallback — случайная локальная цитата
    final index = DateTime.now().millisecondsSinceEpoch % _localQuotes.length;
    setState(() {
      _quoteText = _localQuotes[index]['text']!;
      _quoteAuthor = _localQuotes[index]['author']!;
      _source = 'local';
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нет связи — показана локальная цитата')),
      );
    }
    setState(() => _isLoading = false);
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
                onPressed: _isLoading ? null : _fetchRandomQuote,
                child: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Новая цитата'),
              ),
              const SizedBox(height: 32),
              Text(
                '«$_quoteText»',
                style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '— $_quoteAuthor',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Text(
                _source == 'api' ? 'Источник: forismatic.com' : '7 цитат — каждый день своя',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
