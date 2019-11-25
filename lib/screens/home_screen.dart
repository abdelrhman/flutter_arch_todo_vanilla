import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/core/keys.dart';
import 'package:flutter_arch_todo_vanilla/core/localization/app_localizations.dart';
import 'package:flutter_arch_todo_vanilla/core/routes.dart';
import 'package:flutter_arch_todo_vanilla/data/app_state.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/extra_actions_button.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/filter_button.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/stats_counter.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/todo_list.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/typedefs.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  final TodoAdder addTodo;
  final TodoRemover removeTodo;
  final TodoUpdater updateTodo;
  final Function toggleAll;
  final Function clearCompleted;

  HomeScreen({
    @required this.appState,
    @required this.addTodo,
    @required this.removeTodo,
    @required this.updateTodo,
    @required this.toggleAll,
    @required this.clearCompleted,
    Key key,
  }) : super(key: TodoKeys.homeScreen);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VisibilityFilter activeFilter = VisibilityFilter.all;
  AppTab activeTab = AppTab.todos;

  _updateVisibility(VisibilityFilter filter) {
    setState(() {
      activeFilter = filter;
    });
  }

  _updateTab(AppTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.appTitle),
        actions: [
          FilterButton(
            isActive: activeTab == AppTab.todos,
            activeFilter: activeFilter,
            onSelected: _updateVisibility,
          ),
          ExtraActionsButton(
            allComplete: widget.appState.allComplete,
            hasCompletedTodos: widget.appState.hasCompletedTodos,
            onSelected: (action) {
              if (action == ExtraAction.toggleAllComplete) {
                widget.toggleAll();
              } else if (action == ExtraAction.clearCompleted) {
                widget.clearCompleted();
              }
            },
          )
        ],
      ),
      body: activeTab == AppTab.todos
          ? TodoList(
              filteredTodos: widget.appState.filteredTodos(activeFilter),
              loading: widget.appState.isLoading,
              removeTodo: widget.removeTodo,
              addTodo: widget.addTodo,
              updateTodo: widget.updateTodo,
            )
          : StatsCounter(
              numActive: widget.appState.numActive,
              numCompleted: widget.appState.numCompleted,
            ),
      floatingActionButton: FloatingActionButton(
        key: TodoKeys.addTodoFab,
        onPressed: () {
          Navigator.pushNamed(context, TodoRoutes.addTodo);
        },
        child: Icon(Icons.add),
        tooltip: TodoLocalizations.of(context).addTodo,
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: TodoKeys.tabs,
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) {
          _updateTab(AppTab.values[index]);
        },
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.todos ? Icons.list : Icons.show_chart,
              key: tab == AppTab.stats ? TodoKeys.statsTab : TodoKeys.todoTab,
            ),
            title: Text(
              tab == AppTab.stats
                  ? TodoLocalizations.of(context).stats
                  : TodoLocalizations.of(context).todos,
            ),
          );
        }).toList(),
      ),
    );
  }
}
