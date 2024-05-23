import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

class RatingDialog extends StatefulWidget {
  final String homeItemId;

  const RatingDialog({
    super.key,
    required this.homeItemId,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            AppStrings.feedBackHeader.tr(),
            style: AppTextStyles.feedBackHeaderTextStyle(context),
          ),
          Text(
            AppStrings.feedBackSubHead.tr(),
            style: AppTextStyles.feedBackSubHeadTextStyle(context),
          ),
        ],
      ),
      content: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: ColorManager.offwhite),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        return IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _rating = index + 1;
                              },
                            );
                          },
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: index < _rating ? Colors.orange : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submitRating,
            child: Text(AppStrings.submit.tr()),
          ),
        ),
      ],
    );
  }

  Future<void> _submitRating() async {
    setState(() {
      _isLoading = true;
    });

    final user = DataIntent.getUser();

    if (user != null) {
      try {
        final userRatingRef = FirebaseFirestore.instance
            .collection('Homes')
            .doc(widget.homeItemId)
            .collection('ratings')
            .doc(user.uid);

        final userRatingDoc = await userRatingRef.get();

        if (!userRatingDoc.exists) {
          await userRatingRef.set({'rating': _rating});

          await FirebaseFirestore.instance
              .collection('Homes')
              .doc(widget.homeItemId)
              .update({
            'rating': FieldValue.increment(_rating),
            'numberOfRatings': FieldValue.increment(1),
          });

          Navigator.pop(context);
        } else {
          _showAlertDialog(AppStrings.homeRated.tr());
        }
      } catch (error) {
        _showAlertDialog(AppStrings.homeRatederror.tr());
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.ok.tr()),
          ),
        ],
      ),
    );
  }
}
