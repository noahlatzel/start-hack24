import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_hack/features/map/presentation/forecast_widget.dart';
import 'package:start_hack/features/map/presentation/policy_analysis_widget.dart';
import 'package:start_hack/features/map/repository/latlong_provider.dart';

import '../repository/extended_view_provider.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({super.key});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  List<bool> _selections = [true, false];

  @override
  Widget build(BuildContext context) {
    final extendedViewProvider =
        Provider.of<ExtendedViewProvider>(context, listen: false);
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            extendedViewProvider.toggle();
          },
          onVerticalDragStart: (data) {
            extendedViewProvider.toggle();
          },
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Divider(
                      thickness: 5,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ],
          ),
        ),
        ToggleButtons(
          borderRadius: BorderRadius.circular(18),
          isSelected: _selections,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 80) / 2,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lightbulb,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Forecast',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 80) / 2,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gavel,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Policy Analysis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onPressed: (index) {
            if (index == 0) {
              setState(() {
                _selections = [true, false];
              });
            }
            if (index == 1) {
              setState(() {
                _selections = [false, true];
              });
            }
          },
        ),
        if (_selections[0])
          Consumer<LatLongProvider>(
            builder:
                (BuildContext context, LatLongProvider value, Widget? child) {
              return const ForecastWidget();
            },
          ),
        if (_selections[1]) const PolicyAnalysisWidget(),
      ],
    );
  }
}
