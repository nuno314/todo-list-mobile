import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/constants/server_constants.dart';
import 'package:todo_list/di/di.dart';
import 'package:todo_list/presentation/extentions/component_extention.dart';

import '../../../../../data/models/todo.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitialState()) {
    on<HomePageInitialEvent>(initial);
    on<AddTodoEvent>(addTodo);
    on<RemoveTodoEvent>(removeTodo);
    on<UpdateTodoEvent>(updateTodo);
    on<SearchTodoEvent>(searchTodo);
    on<FilterTodoEvent>(filterTodo);
    add(HomePageInitialEvent());
  }

  final _sharedPref = injector.get<SharedPreferences>();

  FutureOr<void> initial(
    HomePageInitialEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final todos = getTodoListFromPref();
    print(todos.first.title);
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(todos: todos),
      ),
    );
  }

  FutureOr<void> addTodo(
    AddTodoEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final newList = [
      ...state.todos,
      ...[event.todo]
    ];
    final encodedList = Todo.encode(newList);
    await _sharedPref.setString('todo_list', encodedList);
    add(HomePageInitialEvent());
  }

  FutureOr<void> removeTodo(
    RemoveTodoEvent event,
    Emitter<HomePageState> emit,
  ) async {
    state.todos.remove(event.todo);
    final encodedList = Todo.encode(state.todos);
    await _sharedPref.setString('todo_list', encodedList);
    add(HomePageInitialEvent());
  }

  FutureOr<void> updateTodo(
    UpdateTodoEvent event,
    Emitter<HomePageState> emit,
  ) async {
    state.todos.firstWhere((todo) => todo == event.todo).status =
        TodoStatus.completed;
    final encodedList = Todo.encode(state.todos);
    await _sharedPref.setString('todo_list', encodedList);
    add(HomePageInitialEvent());
  }

  FutureOr<void> searchTodo(
      SearchTodoEvent event, Emitter<HomePageState> emit) {
    final todos = getTodoListFromPref();
    print(todos.first.title?.toLowerCase());
    final newList = todos
        .where((element) =>
            element.title
                ?.toLowerCase()
                .removeDiacritics
                .contains(event.title?.toLowerCase().removeDiacritics ?? '') ??
            false)
        .toList();
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(todos: newList),
      ),
    );
  }

  FutureOr<void> filterTodo(
    FilterTodoEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final todos = getTodoListFromPref();

    final newList = event.status == DeadlineStatus.all
        ? todos
        : todos
            .where(
              (element) =>
                  element.deadlineStatus == event.status &&
                  element.status == TodoStatus.inProgress,
            )
            .toList();
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(todos: newList),
      ),
    );
  }

  List<Todo> getTodoListFromPref() {
    final hasData = _sharedPref.containsKey('todo_list');
    final List<Todo> todos;
    if (hasData) {
      final todoString = _sharedPref.getString('todo_list') ?? '';
      todos = Todo.decode(todoString);
      for (var element in todos) {
        element.updateStatus();
      }
      todos.sort(mySortComparison);
    } else {
      todos = [];
    }

    return todos;
  }
}

int mySortComparison(Todo a, Todo b) {
  if (a.status == TodoStatus.expired) {
    return 1;
  }
  if (b.status == TodoStatus.expired) {
    return -1;
  }

  if (a.status == TodoStatus.inProgress && b.status == TodoStatus.inProgress) {
    if (a.deadline!.compareTo(b.deadline!) < 0) {
      return -1;
    } else {
      return 1;
    }
  }
  if (a.status == TodoStatus.inProgress) {
    return -1;
  }

  if (b.status == TodoStatus.inProgress) {
    return 1;
  }

  return a.deadline!.compareTo(b.deadline!);
}
