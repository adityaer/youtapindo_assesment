import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/entities/review.dart';

class ReviewPart extends StatelessWidget {
  final List<Review> reviews;

  const ReviewPart(this.reviews, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              RatingBarIndicator(
                rating: review.rating ?? 0.0,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 25.0,
                direction: Axis.horizontal,
              ),
              Text(review.comment ?? '',
                  style: GoogleFonts.montserrat(fontStyle: FontStyle.italic)),
              Text(review.reviewer ?? '',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))
            ],
          ),
        );
      },
      itemCount: reviews.length,
    );
  }
}
