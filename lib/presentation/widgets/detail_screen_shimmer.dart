import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreenShimmer extends StatelessWidget {
  const DetailScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Row(
              children: [Container(height: 20, width: 80, color: Colors.white)],
            ),
            Row(
              children: [
                Container(
                  height: 16,
                  width: 120,
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 16,
                  width: 100,
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 16,
                  width: 120,
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
