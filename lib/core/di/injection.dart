import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/chat/data/datasources/chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';
import '../services/push_notification_service.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance)
    ..registerLazySingleton(() => PushNotificationService(getIt()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSource(getIt()),
    )
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    ..registerFactory(() => AuthBloc(getIt()))
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => FirebaseChatRemoteDataSource(getIt()),
    )
    ..registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt()))
    ..registerFactory(() => ChatBloc(getIt()));
}
