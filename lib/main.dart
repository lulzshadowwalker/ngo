import 'package:flutter/material.dart';
import 'package:ngo/core/helpers/helper.dart';
import 'package:ngo/l10n/locale/cubit/locale_cubit.dart';
import 'package:ngo/ngo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefHelper.init();

  LocaleCubit.initial(SharedPrefHelper.instance);
  runApp(const MyApp());
}
