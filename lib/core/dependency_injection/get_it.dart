import 'package:get_it/get_it.dart';

import '../../data/data_source/chats/chat_details_requests.dart';
import '../../features/chats/repository/chat_details_repository.dart';
import '../app_router/app_router.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static void init() {
    /// Bloc
    // sl.registerFactory(() => MoviesBloc(sl(), sl(), sl()));
    // sl.registerFactory(() => MovieDetailsBloc(sl(),sl()));

    /// Repository
    sl.registerLazySingleton<ChatDetailsRepository>(() => ChatDetailsRepository(sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<ChatDetailsRequests>(() => ChatDetailsRequests());

    /// ROUTING
    sl.registerLazySingleton<AppRouter>(() => AppRouter());
  }
}
