import '../../../../common/definations.dart';

const listingModuleScreen = '''import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../bloc/${moduleNameKey}_bloc.dart';

part '$moduleNameKey.action.dart';

class ${classNameKey}Screen extends StatefulWidget {
  const ${classNameKey}Screen({Key? key}) : super(key: key);

  @override
  State<${classNameKey}Screen> createState() => _${classNameKey}ScreenState();
}

class _${classNameKey}ScreenState extends StateBase<${classNameKey}Screen> {
  final _refreshController = RefreshController(initialRefresh: true);

  @override
  ${classNameKey}Bloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  void hideLoading() {
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
    super.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<${classNameKey}Bloc, ${classNameKey}State>(
      listener: _blocListener,
      builder: (context, state) {
        return _buildListing(state);
      },
    );
  }

  Widget _buildListing(${classNameKey}State state) {
    return SmartRefresherWrapper.build(
      enablePullDown: true,
      enablePullUp: state.viewModel.canLoadMore,
      onLoading: loadMore,
      onRefresh: onRefresh,
      controller: _refreshController,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const SizedBox();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: state.viewModel.data.length,
      ),
    );
  }
}
''';
