part of 'home_page_screen.dart';

extension HomePageAction on HomePageScreenState {
  void initial() {
    bloc.add(HomePageInitialEvent());
  }

  void onRefresh() {
    bloc.add(HomePageInitialEvent());
  }

  void _blocListener(_, HomePageState state) {}

  void _showAddTodoForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddTodoForm(
        trans: trans,
        textTheme: textTheme,
      ),
    ).then((value) {
      if (value is Todo) {
        _notificationApi.showScheduledNotification(
          title: value.title,
          body: value.description,
          scheduledDate: value.deadline!.subtract(
            const Duration(
              minutes: 10,
            ),
          ),
        );
        bloc.add(
          AddTodoEvent(
            todo: value,
          ),
        );
      }
    });
  }

  void onFilterTodo(DeadlineStatus status) {
    bloc.add(FilterTodoEvent(status));
  }
}
