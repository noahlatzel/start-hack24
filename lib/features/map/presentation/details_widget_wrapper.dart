import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_hack/features/map/presentation/details_widget.dart';

import '../repository/extended_view_provider.dart';

class DetailsWidgetWrapper extends StatefulWidget {
  const DetailsWidgetWrapper({super.key});

  @override
  State<DetailsWidgetWrapper> createState() => _DetailsWidgetWrapperState();
}

class _DetailsWidgetWrapperState extends State<DetailsWidgetWrapper> {
  @override
  Widget build(BuildContext context) {
    final extendedViewProvider = Provider.of<ExtendedViewProvider>(context);
    return Stack(
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height *
                (extendedViewProvider.extendedResults ? 0.1 : 0.87),
          ),
          width: MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: const DetailsWidget(),
        ),
      ],
    );
  }
}
