import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_bloc.dart';
import 'package:unj_digital_test/application/bloc/user/user_event.dart';
import 'package:unj_digital_test/application/bloc/user/user_state.dart';
import 'package:unj_digital_test/core/constants/routes.dart';
import 'package:unj_digital_test/data/models/user_model.dart';
import 'package:unj_digital_test/presentation/widgets/detail_screen_shimmer.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          context.read<UserBloc>().add(FetchUsersEvent(page: 1));
          setState(() {
            canPop = true;
          });
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("User Details")),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoadingState) {
              return const DetailScreenShimmer();
            } else if (state is UserFetchedState) {
              final UserModel user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${user.name}", style: _textStyle()),
                    Text("Email: ${user.email}", style: _textStyle()),
                    Text("Phone: ${user.phone}", style: _textStyle()),
                    Text("Address: ${user.address}", style: _textStyle()),
                    if (user.company != null)
                      Text(
                        "Company: ${user.company!.name}",
                        style: _textStyle(),
                      ),
                    if (user.website != null)
                      Text("Website: ${user.website}", style: _textStyle()),
                    if (user.geoLocation != null)
                      Text(
                        "Location: ${user.geoLocation!.latitude}, ${user.geoLocation!.longitude}",
                        style: _textStyle(),
                      ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _navigateToEditScreen(context, user),
                        child: const Text("Edit"),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserErrorState) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No user data available"));
          },
        ),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, UserModel user) {
    Navigator.pushNamed(
      context,
      editUserRoute,
      arguments: user, // Pass the UserModel object as an argument
    );
  }

  TextStyle _textStyle() =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
}
