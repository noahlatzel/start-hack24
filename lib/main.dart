import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:start_hack/features/map/presentation/details_widget_wrapper.dart';
import 'package:start_hack/features/map/presentation/map.dart';
import 'package:start_hack/features/map/repository/forecast_result_provider.dart';
import 'package:start_hack/utils/api/syngenta_api.dart';

import 'features/map/repository/extended_view_provider.dart';
import 'features/map/repository/syngenta_api_repository.dart';
import 'package:http/http.dart' as http;

final MapController mapController = MapController();

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ExtendedViewProvider>(
        create: (context) => ExtendedViewProvider(),
      ),
      ChangeNotifierProvider<HttpSyngentaRepository>(
          create: (context) =>
              HttpSyngentaRepository(api: SyngentaAPI(), client: http.Client())),
      ChangeNotifierProvider<ForecastResultProvider>(create: (context) => ForecastResultProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'START Hack | Syngenta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'START Hack | Syngenta'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          FelderMap(mapController: mapController),
          const DetailsWidgetWrapper(),
        ],
      ),
    );
  }
}
