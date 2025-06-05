import 'package:get_it/get_it.dart';

import 'core/contracts/posts_repository.dart';
import 'core/contracts/organizations_repository.dart';
import 'core/contracts/locations_repository.dart';
import 'core/contracts/skills_repository.dart';

import 'core/repositories/laravel_posts_repository.dart';
import 'core/repositories/laravel_organizations_repository.dart';
import 'core/repositories/laravel_locations_repository.dart';
import 'core/repositories/laravel_skills_repository.dart';

final GetIt sl = GetIt.instance;

/// Call this early in your app (e.g., in main()) to register all dependencies.
void setupServiceLocator() {
  // Register repositories as lazy singletons (one instance per app)
  sl.registerLazySingleton<PostsRepository>(() => LaravelPostsRepository());
  sl.registerLazySingleton<OrganizationsRepository>(
    () => LaravelOrganizationsRepository(),
  );
  sl.registerLazySingleton<LocationsRepository>(
    () => LaravelLocationsRepository(),
  );
  sl.registerLazySingleton<SkillsRepository>(() => LaravelSkillsRepository());
}
