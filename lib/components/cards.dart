import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const borderRadiuss = BorderRadius.all(Radius.circular(10));

class MovieCards extends StatelessWidget {
  final BorderRadius borderRadius;
  final VoidCallback onClick;
  final String image;
  final String title;
  // final String herotags;
  final double constantWidth;
  final double constantHeight;

  const MovieCards({
    super.key,
    required this.onClick,
    required this.image,
    required this.title,
    // required this.herotags,
    this.borderRadius = borderRadiuss,
    this.constantWidth = 0.9,
    this.constantHeight = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(
            onTap: onClick,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * constantWidth,
              height: MediaQuery.of(context).size.height * constantHeight,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(
                        color: Colors.purple[300]!.withOpacity(0.5),
                          child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: LinearGradient(
                        begin: const Alignment(0, 0.2),
                        end: const Alignment(0, 0.9),
                        colors: [
                          Colors.transparent,
                          Colors.purple.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultsCards extends StatelessWidget {
  final String image;
  final VoidCallback onClick;

  const ResultsCards({
    super.key,
    required this.image,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: onClick,
              child: ClipRRect(
                borderRadius: borderRadiuss,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}