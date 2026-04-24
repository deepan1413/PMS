import 'package:flutter/material.dart';

class AddEditTaskBottomSheet extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final String? initialPriority;
  final void Function(String title, String description, String priority) onSave;

  const AddEditTaskBottomSheet({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialPriority,
    required this.onSave,
  });

  @override
  State<AddEditTaskBottomSheet> createState() => _AddEditTaskBottomSheetState();
}

class _AddEditTaskBottomSheetState extends State<AddEditTaskBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  String _priority = 'medium';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _descController =
        TextEditingController(text: widget.initialDescription ?? '');
    _priority = widget.initialPriority ?? 'medium';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialTitle != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEdit ? "Edit Task" : "New Task",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E2D),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _titleController,
            decoration: _inputDecoration("Task Title", Icons.title),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _descController,
            maxLines: 3,
            decoration: _inputDecoration("Description", Icons.notes),
          ),
          const SizedBox(height: 16),

          // Priority
          const Text(
            "Priority",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1E2D),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: ['low', 'medium', 'high'].map((p) {
              final isSelected = _priority == p;
              final color = _priorityColor(p);
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _priority = p),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? color.withOpacity(0.15)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? color : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        p[0].toUpperCase() + p.substring(1),
                        style: TextStyle(
                          color: isSelected ? color : Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final desc = _descController.text.trim();
                if (title.isEmpty) return;
                widget.onSave(title, desc, _priority);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isEdit ? "Update Task" : "Create Task",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4F6AF5)),
      ),
    );
  }

  Color _priorityColor(String p) {
    switch (p) {
      case 'high':
        return const Color(0xFFEF4444);
      case 'medium':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF22C55E);
    }
  }
}