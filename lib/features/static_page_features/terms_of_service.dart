import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/static_page_features/cubit/static_page_cubit.dart';

import '../../export_tools.dart';
import '../../service_locator.dart';



class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    final localeName = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) =>
          sl<StaticPageCubit>()
            ..getTermsAndConditions(locale: localeName.localeName),
      child: BlocBuilder<StaticPageCubit, StaticPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Terms of Service')),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, StaticPageState state) {
    final type = state.runtimeType.toString();
    if (type.contains('Initial')) {
      return const SizedBox.shrink();
    } else if (type.contains('Loading')) {
      return const Center(child: CircularProgressIndicator());
    } else if (type.contains('Success')) {
      // ignore: avoid_dynamic_calls
      final staticPage = (state as dynamic).staticPage;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: SelectableText(
          staticPage.content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            color: Colors.black87,
            height: 1.6,
          ),
          textAlign: TextAlign.left,
        ),
      );
    } else if (type.contains('Error')) {
      // ignore: avoid_dynamic_calls
      final message = (state as dynamic).message;
      return Center(
        child: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
