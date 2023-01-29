import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtap_assesment_test/extension/extension.dart';
import 'package:youtap_assesment_test/presentation/provider/tv_series_detail_notifier.dart';

import '../../../../constant/string.dart';
import '../../../../domain/entities/review.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/state_enum.dart';
import '../../../../widgets/progress_dot.dart';
import '../../../../widgets/review_part.dart';
import '../../../../widgets/scroll_activated_appbar_elevation.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const routeName = '/tv_series_detail_page';

  final int id;

  const TVSeriesDetailPage({super.key, required this.id});

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  var listReview = [
    Review(reviewer: 'Melissa', comment: 'Superb!!', rating: 5),
    Review(
        reviewer: 'John Connor',
        comment: 'Good Movie, so entertaining',
        rating: 4.5),
    Review(reviewer: 'James Doe', comment: 'Beyond belief', rating: 3)
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TVSeriesDetailNotifier>(context, listen: false)
          .getDetailTVSeriesData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollActivatedAppBarElevation(
        builder: (BuildContext context, double appBarElevation) {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.grey),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: appBarElevation,
        ),
        body: Container(
          color: Colors.white,
          child: Consumer<TVSeriesDetailNotifier>(
            builder: (context, data, _) {
              if (data.state == RequestState.Loading) {
                return Center(
                  child: WidgetDotFade(color: Colors.teal[400], size: 20.0),
                );
              } else if (data.state == RequestState.Loaded) {
                final tvSeriesDetail = data.tvSeriesDetail;
                var genreList = '';
                for (var genre in data.tvSeriesDetail.genres) {
                  genreList = '$genreList${genre.name}, ';
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          elevation: 8,
                          color: Colors.teal,
                          shadowColor: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '$BASE_IMAGE_URL${tvSeriesDetail.backdropPath}',
                              placeholder: (context, url) => const SizedBox(
                                width: 400,
                                height: 200,
                                child: Center(
                                  child: WidgetDotFade(
                                      color: Colors.white, size: 20.0),
                                ),
                              ),
                              errorWidget: (context, url, error) => SizedBox(
                                width: 400,
                                height: 200,
                                child: Center(
                                  child: Text(
                                    StringConstants.canNotLoadImage,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          data.tvSeriesDetail.name,
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                  size: 25,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  tvSeriesDetail.firstAirDate
                                      .stringDateToString(
                                          StringConstants.dateFormatTimezone,
                                          StringConstants
                                              .dateFormatStandardHuman),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 25,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  tvSeriesDetail.voteAverage.toString(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.category,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  genreList,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          tvSeriesDetail.overview,
                          style: GoogleFonts.montserrat(),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          StringConstants.reviews,
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        ReviewPart(listReview)
                      ],
                    ),
                  ),
                );
              } else if (data.state == RequestState.Error) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return const Center(
                  child: Text(''),
                );
              }
            },
          ),
        ),
      );
    });
  }
}
