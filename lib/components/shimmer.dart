import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const borderRadiuss = BorderRadius.all(Radius.circular(10));

class Loadings extends StatelessWidget {
  final double constantWidth;
  final double constantHeight;
  final EdgeInsetsGeometry paddingSize;

  const Loadings({
    super.key,
    this.constantWidth = 0.9,
    this.constantHeight = 0.7,
    this.paddingSize = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingSize,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * constantWidth,
        height: MediaQuery.of(context).size.height * constantHeight,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[900]!,
          highlightColor: Colors.grey[700]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200]!.withOpacity(0.4),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
        )
      ),
    );
  }
}

class LoadingResult extends StatelessWidget {
  final EdgeInsetsGeometry paddingSize;

  const LoadingResult({
    super.key,
    this.paddingSize = const EdgeInsets.all(10),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: paddingSize,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[900]!,
                      highlightColor: Colors.grey[700]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

  }
}