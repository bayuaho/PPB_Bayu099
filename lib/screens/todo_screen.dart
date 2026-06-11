import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/api_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late Future<List<Todo>> _todosFuture;
  String _filter = 'all'; // 'all' | 'done' | 'pending'

  @override
  void initState() {
    super.initState();
    _todosFuture = ApiService.fetchTodos();
  }

  List<Todo> _applyFilter(List<Todo> todos) {
    if (_filter == 'done') return todos.where((t) => t.completed).toList();
    if (_filter == 'pending') return todos.where((t) => !t.completed).toList();
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A6B),
        foregroundColor: Colors.white,
        title: const Text(
          'Todo List',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ── Filter Chip ──────────────────────────────────────────────────
          Container(
            color: const Color(0xFF1A3A6B),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _filter == 'all',
                  onTap: () => setState(() => _filter = 'all'),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Done ✓',
                  selected: _filter == 'done',
                  onTap: () => setState(() => _filter = 'done'),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Pending',
                  selected: _filter == 'pending',
                  onTap: () => setState(() => _filter = 'pending'),
                ),
              ],
            ),
          ),

          // ── List ─────────────────────────────────────────────────────────
          Expanded(
            child: FutureBuilder<List<Todo>>(
              future: _todosFuture,
              builder: (context, snapshot) {
                // Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1A3A6B),
                    ),
                  );
                }
                // Error
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 12),
                        Text(
                          'Error: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              setState(() => _todosFuture = ApiService.fetchTodos()),
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                }

                // Data siap
                final filtered = _applyFilter(snapshot.data!);

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada data',
                        style: TextStyle(color: Colors.grey)),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final todo = filtered[index];
                    return _TodoCard(todo: todo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Filter Chip Widget ────────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF1A3A6B) : Colors.white,
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ── Todo Card Widget ──────────────────────────────────────────────────────────
class _TodoCard extends StatelessWidget {
  final Todo todo;

  const _TodoCard({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Status icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: todo.completed
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFF3E0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
              color: todo.completed
                  ? const Color(0xFF43A047)
                  : const Color(0xFFFB8C00),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          // Title + metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    decoration: todo.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'User ${todo.userId}  ·  ID #${todo.id}',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Badge status
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: todo.completed
                  ? const Color(0xFF43A047)
                  : const Color(0xFFFB8C00),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              todo.completed ? 'Done' : 'Pending',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}