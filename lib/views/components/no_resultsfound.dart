import 'package:dsd/views/home.dart';
import 'package:dsd/views/pages/rootApp.dart';
import 'package:dsd/views/styles.dart';
import 'package:flutter/material.dart';

Widget noResultsFound(BuildContext context) {
  return Expanded(
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/no_data.jpeg",
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.065,
          right: MediaQuery.of(context).size.width * 0.065,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 13),
                  blurRadius: 25,
                  color: Color(0xFF5666C2).withOpacity(0.17),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'No data found for currect route and day.',
                  style: customerNameTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                  label: const Text('Change Filters'), // <-- Text
                  backgroundColor: Colors.black,
                  icon: const Icon(
                    // <-- Icon
                    Icons.settings,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return RootApp(
                          startIndex: 1,
                        );
                      },
                    ));
                  },
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
