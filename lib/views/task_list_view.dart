import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../widgets/task_card.dart';
import 'task_form_view.dart';
import 'package:lottie/lottie.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskVM = Provider.of<TaskViewModel>(context);

    // Modern color scheme
    const backgroundColor = Color(0xFFF8F9FA); // Light gray background
    const primaryColor = Colors.black; // Vibrant green
    const primaryDarkColor = Colors.black; // Darker green
    const accentColor = Color(0xFFFFC107); // Amber accent
    const textPrimary = Color(0xFF212121); // Dark gray for text
    const textSecondary = Color(0xFF757575); // Light gray for secondary text

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Task Manager',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            )),
        backgroundColor: primaryColor,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 26),
            tooltip: 'Refresh tasks',
            onPressed: () => taskVM.fetchFromAPI(),
          )
        ],
      ),
      body: Column(
        children: [
          // Header with stats
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(
                  context,
                  value: taskVM.tasks.length.toString(),
                  label: 'Total Tasks',
                  icon: Icons.list_alt,
                  color: primaryColor,
                ),
                _buildStatItem(
                  context,
                  value: taskVM.tasks.where((t) => t.isCompleted).length.toString(),
                  label: 'Completed',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                _buildStatItem(
                  context,
                  value: taskVM.tasks.where((t) => !t.isCompleted).length.toString(),
                  label: 'Pending',
                  icon: Icons.pending_actions,
                  color: accentColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Task list
          Expanded(
            child: RefreshIndicator(
              color: primaryColor,
              onRefresh: () => taskVM.fetchFromAPI(),
              child: taskVM.tasks.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.separated(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: taskVM.tasks.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFEEEEEE),
                ),
                itemBuilder: (context, index) {
                  final task = taskVM.tasks[index];
                  return Dismissible(
                    key: ValueKey(task.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red[400]!, Colors.red[600]!],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 30),
                      child: const Icon(Icons.delete_forever,
                          color: Colors.white,
                          size: 28),
                    ),
                    confirmDismiss: (_) async {
                      return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.white,
                          title: const Text("Confirm Delete",
                              style: TextStyle(
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                              )),
                          content: const Text("Are you sure you want to delete this task?",
                              style: TextStyle(color: textSecondary)),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("CANCEL",
                                    style: TextStyle(
                                      color: textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("DELETE",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    )))
                          ],
                        ),
                      );
                    },
                    onDismissed: (_) => taskVM.deleteTask(task.id!),
                    child: TaskCard(task: task),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 4,
        hoverElevation: 8,
        focusElevation: 6,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TaskFormView())),
        child: const Icon(Icons.add,
            color: Colors.white,
            size: 28),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212121),
            )),
        Text(label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF757575),
            )),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/empty_tasks.json',
            height: 200,
            width: 200,
            repeat: true,
            reverse: false,
            animate: true,
          ),
          const SizedBox(height: 20),
          const Text(
            'No Tasks Found',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF757575),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the + button to add a new task',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFBDBDBD),
            ),
          ),
        ],
      ),
    );
  }
}