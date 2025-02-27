import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_event.dart';
import 'package:unj_digital_test/application/bloc/user/user_state.dart';
import 'package:unj_digital_test/core/constants/app_strings.dart';
import 'package:unj_digital_test/core/constants/routes.dart';
import 'package:unj_digital_test/data/models/user_model.dart';
import 'package:unj_digital_test/presentation/widgets/users_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool isFetching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _fetchUsers() {
    context.read<UserBloc>().add(FetchUsersEvent(page: currentPage));
  }

  void _onScroll() {
    final state = context.read<UserBloc>().state;
    final hasMore = state is UsersLoadedState && state.hasMore;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        hasMore &&
        !isFetching) {
      setState(() => isFetching = true);
      currentPage++;
      _fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.homeTitle)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, addUserRoute).then((_) {
            _scrollController.jumpTo(0);
          });
        },
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          isFetching = false;
          if (state is UsersLoadedState) {
            currentPage = state.page;
          }
          if (state.users.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              controller: _scrollController,
              itemCount:
                  state is UsersLoadedState && state.hasMore
                      ? state.users.length + 1
                      : state.users.length,
              itemBuilder: (context, index) {
                if (index >= state.users.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                UserModel user = state.users[index];
                return ListTile(
                  onTap: () {
                    context.read<UserBloc>().add(
                      FetchUserByIdEvent(state.users[index].id),
                    );
                    Navigator.pushNamed(context, userDetailsRoute).then((_) {
                      _scrollController.jumpTo(0);
                    });
                  },
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          } else if (state is! UsersLoadingState && state.users.isEmpty) {
            return const Center(child: Text('No users found'));
          } else if (state is UsersLoadingState && state.users.isEmpty) {
            return UserShimmer();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
