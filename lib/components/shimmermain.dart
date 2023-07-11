import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMain extends StatelessWidget {
  const ShimmerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FB),
      body: Shimmer.fromColors(
        period: const Duration(milliseconds: 1000),
        baseColor: (Colors.grey[200])!,
        highlightColor: (Colors.grey[100])!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 55.0, right: 10.0, left: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17.0),
                          bottomLeft: Radius.circular(17.0),
                          topRight: Radius.circular(17.0),
                          bottomRight: Radius.circular(17.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 25.0, right: 10.0, left: 10.0),
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17.0),
                ),
              ),
            ),
            const SizedBox(
              height: 73.0,
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(17.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(17.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 21.0,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
