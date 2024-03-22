import 'package:flutter/material.dart';

class PolicyAnalysisWidget extends StatefulWidget {
  const PolicyAnalysisWidget({super.key});

  @override
  State<PolicyAnalysisWidget> createState() => _PolicyAnalysisWidgetState();
}

class _PolicyAnalysisWidgetState extends State<PolicyAnalysisWidget> {
  double _currentSliderValue1 = 0.3;
  double _currentSliderValue2 = 0.6;
  List<bool> _isSelected = [false, false, false, false];

  AssetImage getBadgeImage() {
    double sum = _currentSliderValue1 + _currentSliderValue2;
    if (sum > 1.8) return const AssetImage('images/siegel_gruen_transp.png');
    if (sum > 1.0) return const AssetImage('images/siegel_orange_transp.png');
    return const AssetImage('images/siegel_rot_transp.png');
  }

  String getBadgeString() {
    double sum = _currentSliderValue1 + _currentSliderValue2;
    if (sum > 1.8) return "golden";
    if (sum > 1.0) return "silver";
    return "bronze";
  }

  String getNextBadgeString() {
    double sum = _currentSliderValue1 + _currentSliderValue2;
    if (sum > 1.8) return "Great! You achieved the best badge.";
    if (sum > 1.0) {
      return "Achieve ${(((1.8 / sum) - 1) * 100).toStringAsFixed(0)} % more to get a golden badge!";
    }
    return "Achieve ${(((1.0 / sum) - 1) * 100).toStringAsFixed(0)} % more to get a silver badge!";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundImage: getBadgeImage(),
                      radius: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                          "Your selected field is granted a ${getBadgeString()} badge."),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getNextBadgeString()),
              ],
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.local_florist),
            SizedBox(
              width: 4,
            ),
            Text("Crop Type"),
          ],
        ),
        ToggleButtons(
            isSelected: _isSelected,
            borderRadius: BorderRadius.circular(18),
            onPressed: (index) {
              if (index == 0) {
                setState(() {
                  _isSelected = [true, false, false, false];
                });
              }
              if (index == 1) {
                setState(() {
                  _isSelected = [false, true, false, false];
                });
              }
              if (index == 2) {
                setState(() {
                  _isSelected = [false, false, true, false];
                });
              }
              if (index == 3) {
                setState(() {
                  _isSelected = [false, false, false, true];
                });
              }
            },
            children: const [
              Text(
                'Wheat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Corn',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Barley',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Oats',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.water_drop_outlined),
            SizedBox(
              width: 4,
            ),
            Text("Water Irrigation"),
          ],
        ),
        Slider(
          value: _currentSliderValue1,
          onChanged: (value) {
            setState(() {
              _currentSliderValue1 = value;
            });
          },
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.yard),
            SizedBox(
              width: 4,
            ),
            Text("Crop Density"),
          ],
        ),
        Slider(
          value: _currentSliderValue2,
          onChanged: (value) {
            setState(() {
              _currentSliderValue2 = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "How will this affect my CO2 emissions and crop yield?",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.rocket_launch),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
