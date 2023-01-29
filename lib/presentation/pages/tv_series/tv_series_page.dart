import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtap_assesment_test/presentation/provider/tv_series_notifier.dart';

import '../../../constant/string.dart';
import '../../../utils/state_enum.dart';
import '../../../widgets/progress_dot.dart';
import '../../../widgets/tvseries_card_list.dart';

class TVSeriesPage extends StatefulWidget {
  static const routeName = '/tv_series';

  const TVSeriesPage({super.key});

  @override
  _TVSeriesPageState createState() => _TVSeriesPageState();
}

class _TVSeriesPageState extends State<TVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TVSeriesNotifier>(context, listen: false)
      ..fetchOnTheAirTVSeries()
      ..fetchPopularTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(StringConstants.tvSeries,
            style: GoogleFonts.montserrat(color: Colors.black)),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringConstants.onTheAir,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                Consumer<TVSeriesNotifier>(builder: (context, data, child) {
                  final state = data.stateOTA;
                  if (state == RequestState.Loading) {
                    return SizedBox(
                      height: 150,
                      child: WidgetDotFade(color: Colors.teal[400], size: 20.0),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TVSeriesList(data.otaTVSeries);
                  } else {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(StringConstants.canNotLoadData),
                      ),
                    );
                  }
                }),
                const SizedBox(height: 5,),
                Text(StringConstants.popular,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                Consumer<TVSeriesNotifier>(builder: (context, data, child) {
                  final state = data.statePopular;
                  if (state == RequestState.Loading) {
                    return SizedBox(
                      height: 150,
                      child: WidgetDotFade(color: Colors.teal[400], size: 20.0),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TVSeriesList(data.popularTVSeries);
                  } else {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(StringConstants.canNotLoadData),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
