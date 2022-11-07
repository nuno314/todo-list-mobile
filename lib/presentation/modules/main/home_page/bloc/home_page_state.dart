part of 'home_page_bloc.dart';

class _ViewModel {
  final List<Todo> todos;
  const _ViewModel({
    this.todos = const [],
  });

  _ViewModel copyWith({
    List<Todo>? todos,
  }) {
    return _ViewModel(
      todos: todos ?? this.todos,
    );
  }
}

abstract class HomePageState {
  final _ViewModel viewModel;

  HomePageState(this.viewModel);

  T copyWith<T extends HomePageState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == HomePageState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<Todo> get todos => viewModel.todos;
}

class HomePageInitialState extends HomePageState {
  HomePageInitialState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  HomePageInitialState: (viewModel) => HomePageInitialState(
        viewModel: viewModel,
      ),
};
