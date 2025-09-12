import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/applications_repository.dart';
import 'package:ngo/models/application.dart';
import 'package:ngo/models/application_response.dart';

part 'application_cubit.freezed.dart';
part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final ApplicationsRepository _repository;

  ApplicationCubit(this._repository) : super(const ApplicationState.initial());

  /// Submit a new application
  Future<void> submitApplication({
    required int opportunityId,
    required List<ApplicationResponse> responses,
  }) async {
    try {
      emit(const ApplicationState.submitting());

      final application = await _repository.submit(
        opportunityId: opportunityId,
        responses: responses,
      );

      emit(ApplicationState.submitted(application));
    } catch (e) {
      emit(ApplicationState.error(e.toString()));
    }
  }

  /// Save application as draft (placeholder for future implementation)
  Future<void> saveAsDraft({
    required int opportunityId,
    required List<ApplicationResponse> responses,
  }) async {
    try {
      emit(const ApplicationState.saving());
      
      // For now, just simulate saving
      await Future.delayed(const Duration(seconds: 1));
      
      emit(const ApplicationState.savedAsDraft());
    } catch (e) {
      emit(ApplicationState.error(e.toString()));
    }
  }

  /// Check if user has already applied to this opportunity
  Future<void> checkApplicationStatus(int opportunityId) async {
    try {
      emit(const ApplicationState.checking());

      final applications = await _repository.fetchAll();
      final existingApplication = applications.data.cast<Application?>().firstWhere(
        (app) => app?.opportunity.id == opportunityId.toString(),
        orElse: () => null,
      );

      if (existingApplication != null) {
        emit(ApplicationState.alreadyApplied(existingApplication));
      } else {
        emit(const ApplicationState.canApply());
      }
    } catch (e) {
      emit(ApplicationState.error(e.toString()));
    }
  }

  /// Reset state
  void reset() {
    emit(const ApplicationState.initial());
  }
}
