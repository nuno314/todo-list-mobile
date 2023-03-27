part of 'home_page_bloc.dart';

class ViewModel {
  final List<Todo> todos;
  const ViewModel({
    this.todos = const [],
  });

  ViewModel copyWith({
    List<Todo>? todos,
  }) {
    return ViewModel(
      todos: todos ?? this.todos,
    );
  }
}

abstract class HomePageState {
  final ViewModel viewModel;

  HomePageState(this.viewModel);

  T copyWith<T extends HomePageState>({
    ViewModel? viewModel,
  }) {
    return _factories[T == HomePageState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<Todo> get todos => viewModel.todos;
}

class HomePageInitialState extends HomePageState {
  HomePageInitialState({
    ViewModel viewModel = const ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  ViewModel viewModel,
)>{
  HomePageInitialState: (viewModel) => HomePageInitialState(
        viewModel: viewModel,
      ),
};
