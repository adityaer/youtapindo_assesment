import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtap_assesment_test/widgets/progress_dot.dart';

import '../domain/entities/tvseries.dart';
import '../presentation/pages/tv_series/detail/tv_series_detail_page.dart';
import '../utils/constants.dart';

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvseries;

  const TVSeriesList(this.tvseries, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvserie = tvseries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.routeName,
                  arguments: tvserie.id,
                );
              },
              child: Material(
                  elevation: 5,
                  color: Colors.teal,
                  shadowColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: '$BASE_IMAGE_URL${tvserie.posterPath}',
                      placeholder: (context, url) => const SizedBox(
                        width: 120,
                        child: Center(
                          child: WidgetDotFade(
                              color: Colors.white, size: 15.0),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  )),
            ),
          );
        },
        itemCount: tvseries.length,
      ),
    );
  }
}