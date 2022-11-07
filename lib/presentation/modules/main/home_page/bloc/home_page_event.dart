part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class HomePageInitialEvent extends HomePageEvent {}

class AddTodoEvent extends HomePageEvent {
  final Todo todo;
  AddTodoEvent({
    required this.todo,
  });
}

class RemoveTodoEvent extends HomePageEvent {
  final Todo todo;
  RemoveTodoEvent({
    required this.todo,
  });
}

class UpdateTodoEvent extends HomePageEvent {
  final Todo todo;
  UpdateTodoEvent({
    required this.todo,
  });
}

class SearchTodoEvent extends HomePageEvent {
  final String? title;
  SearchTodoEvent(this.title);
}

class FilterTodoEvent extends HomePageEvent {
  final DeadlineStatus? status;
  FilterTodoEvent(this.status);
}

