import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_event.dart';
import 'package:unj_digital_test/core/constants/app_strings.dart';
import 'package:unj_digital_test/core/constants/routes.dart';
import 'package:unj_digital_test/core/theme/app_theme.dart';
import 'package:unj_digital_test/data/data_sources/api_service.dart';
import 'package:unj_digital_test/data/data_sources/local_storage.dart';
import 'package:unj_digital_test/data/repositories/user_repository.dart';
import 'package:unj_digital_test/presentation/screens/add_user_screen.dart';
import 'package:unj_digital_test/presentation/screens/edit_user_screen.dart';
import 'package:unj_digital_test/presentation/screens/home_screen.dart';
import 'package:unj_digital_test/presentation/screens/user_details_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider<UserBloc>(
      create:
          (context) => UserBloc(
            userRepository: UserRepository(
              apiService: ApiService(),
              localStorage: LocalStorage(),
            ),
          ),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routes: {
          homeRoute: (context) => const HomeScreen(),
          addUserRoute: (context) => const AddUserScreen(),
          userDetailsRoute: (context) => const UserDetailsScreen(),
          editUserRoute: (context) => const EditUserScreen(),
        },
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(FetchUsersEvent(page: 1));
    return HomeScreen();
  }
}
