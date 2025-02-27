import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserShimmer extends StatelessWidget {
  const UserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: 6, // Display 6 shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              title: Row(
                children: [
                  Container(
                    height: 20,
                    width: 50,
                    margin: EdgeInsets.only(top: 2),
                    color: Colors.white,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Container(
                    height: 16,
                    width: 100,
                    margin: EdgeInsets.only(top: 2),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
