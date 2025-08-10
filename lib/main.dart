import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/helpers/helper.dart';
import 'package:ngo/core/observer/app_bloc_observer.dart';
import 'package:ngo/l10n/locale/cubit/locale_cubit.dart';
import 'package:ngo/ngo.dart';
import 'package:ngo/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  setupServiceLocator();
    Bloc.observer = AppBlocObserver();
  LocaleCubit.initial(SharedPrefHelper.instance);
  runApp(const MyApp());
}
