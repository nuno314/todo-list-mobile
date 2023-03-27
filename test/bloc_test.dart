import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/data/models/todo.dart';
import 'package:todo_list/presentation/modules/main/home_page/bloc/home_page_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HomePageBloc bloc;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    bloc = HomePageBloc(prefs: prefs);
  });
  group('HomePageBloc', () {
    test('initial state is empty', () {
      expect(bloc.state.todos.isEmpty, true);
    });

    blocTest<HomePageBloc, HomePageState>(
      'test AddTodoEvent',
      build: () => bloc,
      act: (bloc) => bloc.add(AddTodoEvent(todo: Todo(title: 'TEST'))),
      expect: () {
        expect(bloc.state.todos.length, 1);
        expect(bloc.state.todos.first.title, 'TEST');
        return [bloc.state];
      },
    );

    blocTest<HomePageBloc, HomePageState>(
      'test RemoveTodoEvent',
      build: () => bloc,
      act: (bloc) => bloc.add(RemoveTodoEvent(todo: Todo(title: 'TEST'))),
      expect: () {
        expect(bloc.state.todos.isEmpty, true);
        return [bloc.state];
      },
    );
  });

  tearDown(() => bloc.close());
}
