import 'package:get_it/get_it.dart';
import 'package:ngo/features/notifications/cubit/notifications_cubit.dart';
import 'package:ngo/features/organization/cubit/organization_cubit.dart';
import 'package:ngo/features/post/logic/post_cubit.dart';
import 'package:ngo/features/user_management/cubit/user_management_cubit.dart';

import 'core/contracts/auth_repository.dart';
import 'core/contracts/locations_repository.dart';
import 'core/contracts/notification_repository.dart';
import 'core/contracts/organizations_repository.dart';
import 'core/contracts/skills_repository.dart';
import 'core/contracts/user_management_regpository.dart';
import 'core/repositories/laravel_auth_repository.dart';
import 'core/repositories/laravel_locations_repository.dart';
import 'core/repositories/laravel_notification_repository.dart';
import 'core/repositories/laravel_organizations_repository.dart';
import 'core/repositories/laravel_skills_repository.dart';
import 'core/repositories/laravel_user_management_repository.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/post/data/repo/laravel_posts_repository.dart';
import 'features/post/data/repo/posts_repository.dart';

final GetIt sl = GetIt.instance;

/// Call this early in your app (e.g., in main()) to register all dependencies.
void setupServiceLocator() {
  // Register repositories as lazy singletons (one instance per app)
  sl.registerLazySingleton<AuthRepository>(() => LaravelLoginRepository());
  sl.registerLazySingleton<PostsRepository>(() => LaravelPostsRepository());
  sl.registerLazySingleton<OrganizationsRepository>(
    () => LaravelOrganizationsRepository(),
  );
  sl.registerLazySingleton<LocationsRepository>(
    () => LaravelLocationsRepository(),
  );
  sl.registerLazySingleton<SkillsRepository>(() => LaravelSkillsRepository());
  sl.registerLazySingleton<NotificationRepository>(
    () => LaravelNotificationRepository(),
  );
  sl.registerLazySingleton<UserManagementRepository>(
    () => LaravelUserManagementRepository(),
  );

  // Register cubits as factories (new instance per injection)
  sl.registerFactory(() => AuthCubit(sl<AuthRepository>()));
  sl.registerFactory(() => PostCubit(postsRepository: sl<PostsRepository>()));
  sl.registerFactory(() => OrganizationCubit(sl<OrganizationsRepository>()));
  sl.registerFactory(() => NotificationsCubit(sl<NotificationRepository>()));
  sl.registerFactory(() => UserManagementCubit(sl<UserManagementRepository>()));
}
