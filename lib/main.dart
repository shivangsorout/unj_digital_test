import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_event.dart';
import 'package:unj_digital_test/application/bloc/user/user_state.dart';
import 'package:unj_digital_test/core/constants/routes.dart';
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
    MaterialApp(
      title: 'Unj Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        homeRoute: (context) => const HomeScreen(),
        addUserRoute: (context) => const AddUserScreen(),
        userDetailsRoute: (context) => const UserDetailsScreen(),
        editUserRoute: (context) => const EditUserScreen(),
      },
      home: BlocProvider<UserBloc>(
        create:
            (context) => UserBloc(
              userRepository: UserRepository(
                apiService: ApiService(),
                localStorage: LocalStorage(),
              ),
            ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(FetchUsersEvent(page: 1));
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UsersLoadedState) {
          return const HomeScreen();
        } else {
          return Scaffold(body: Container());
        }
      },
    );
  }
}
