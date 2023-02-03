import 'package:dsd/views/components/constants/text_style.dart';
import 'package:flutter/material.dart';

class NoSearchResultFound extends StatelessWidget {
  const NoSearchResultFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/user_profile.jpg',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.6,
        ),
        Positioned(
          bottom: 260,
          left: 30,
          child: Text(
            'No Results',
            style: kTitleTextStyle.copyWith(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          left: 30,
          child: Text(
            'Sorry, there are no results for\nthis search, please try another phrase.',
            style: kSubtitleTextStyle.copyWith(
              color: Colors.white54,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Positioned(
            bottom: 100,
            left: 30,
            right: 30,
            child: SizedBox(
              height: 60,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: kSubtitleTextStyle.copyWith(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
