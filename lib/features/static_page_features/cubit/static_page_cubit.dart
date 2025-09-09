import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/contracts/static_page_repository.dart';
import '../../../models/static_page.dart';

part 'static_page_cubit.freezed.dart';
part 'static_page_state.dart';

class StaticPageCubit extends Cubit<StaticPageState> {
  final StaticPageRepository _staticPageRepository;

  StaticPageCubit({required StaticPageRepository staticPageRepository})
    : _staticPageRepository = staticPageRepository,
      super(const StaticPageState.initial());

  Future<void> getAboutUs({required String locale}) async {
    emit(const StaticPageState.loading());
    try {
      final staticPage = await _staticPageRepository.aboutUs(locale);
      emit(StaticPageState.success(staticPage));
    } catch (e) {
      emit(StaticPageState.error(e.toString()));
    }
  }

  Future<void> getPrivacyPolicy({required String locale}) async {
    emit(const StaticPageState.loading());
    try {
      final staticPage = await _staticPageRepository.privacyPolicy(locale);
      emit(StaticPageState.success(staticPage));
    } catch (e) {
      emit(StaticPageState.error(e.toString()));
    }
  }

  Future<void> getTermsAndConditions({required String locale}) async {
    emit(const StaticPageState.loading());
    try {
      final staticPage = await _staticPageRepository.termsAndConditions(locale);
      emit(StaticPageState.success(staticPage));
    } catch (e) {
      emit(StaticPageState.error(e.toString()));
    }
  }
}
