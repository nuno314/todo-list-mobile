import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_list/api/notification_api.dart';
import 'package:todo_list/constants/server_constants.dart';
import 'package:todo_list/data/models/todo.dart';
import 'package:todo_list/di/di.dart';
import 'package:todo_list/presentation/modules/main/home_page/widgets/todo_item.dart';
import 'package:todo_list/theme/theme_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/utils/debouncer.dart';
import '../../../extentions/localization.dart';
import 'bloc/home_page_bloc.dart';
import 'widgets/add_todo_form.dart';

part 'home_page.action.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late Debouncer<String> debouncer = Debouncer<String>(
    const Duration(milliseconds: 500),
    onSearchTodo,
  );

  final _notificationApi = injector.get<NotificationApi>();

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  HomePageBloc get bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    listenNotification();
  }

  void listenNotification() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(NotificationResponse? payload) => print(payload);

  @override
  Widget build(BuildContext context) {
    trans = translate(context);

    _themeData = Theme.of(context);

    final itemW = (MediaQuery.of(context).size.width - 16 * 2) / 2;
    const itemImageRatio = 167 / 132;
    final imageH = itemW / itemImageRatio;
    return GestureDetector(
      onTap: (() => hideKeyBoard(context)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: themeColor.primaryColor,
          title: Text(
            'Todo List',
            style: textTheme.bodyText1?.copyWith(
              color: themeColor.white,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: onRefresh,
              icon: const Icon(
                Icons.refresh_outlined,
              ),
            ),
            _buildDropdownFilter(),
          ],
        ),
        body: BlocConsumer<HomePageBloc, HomePageState>(
          listener: _blocListener,
          bloc: bloc,
          builder: (context, state) {
            final todos = state.todos;
            return Container(
              color: const Color(0xfff7f7f7),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _buildSearchBar(context),
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: imageH + 70,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          itemBuilder: (context, index) => TodoItem(
                            todo: todos[index],
                            textTheme: textTheme,
                            trans: trans,
                            onRemove: () => onRemoveTodo(todos[index]),
                            onDone: () => onDoneTodo(todos[index]),
                          ),
                          itemCount: todos.length,
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    fillOverscroll: true,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Wrap(
                        children: [
                          _buildBottomButtons(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return InkWell(
      onTap: () => _showAddTodoForm(context),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          color: themeColor.primaryColorLight,
        ),
        child: Text(
          trans.addTodo,
          style: textTheme.bodyText1?.copyWith(
            color: themeColor.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void onRemoveTodo(Todo todo) {
    bloc.add(
      RemoveTodoEvent(
        todo: todo,
      ),
    );
  }

  void onDoneTodo(Todo todo) {
    bloc.add(UpdateTodoEvent(todo: todo));
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: (() => hideKeyBoard(context)),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: TextField(
          onChanged: (value) {
            debouncer.value = value;
          },
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: themeColor.primaryColor,
            ),
            suffixIconColor: themeColor.primaryColorLight,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: themeColor.primaryColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: themeColor.primaryColorLight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onSearchTodo(String? value) {
    bloc.add(SearchTodoEvent(value));
  }

  Widget _buildDropdownFilter() {
    return PopupMenuButton(
      onSelected: (value) => onFilterTodo(value),
      icon: const Icon(Icons.filter_alt),
      itemBuilder: (context) => DeadlineStatus.values
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: Text(
                e.localized(trans),
              ),
            ),
          )
          .toList(),
    );
  }
}
