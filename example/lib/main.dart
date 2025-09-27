import 'package:flutter/material.dart';
import 'package:step_slider/step_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  StepSliderController _controller = StepSliderController();
  StepSliderController _sliderController = StepSliderController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  change() {
    _controller.moveTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StepSlider(
                steps: 2,
                labels: ["Low", "Medium", "High"],
                onChanged: (i) {},
                labelTextStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            StepSlider(
              controller: _controller,
              steps: 4,
              onChanged: (i) {
                setState(() {
                  print(i);
                });
              },
              trackWidth: 20,
              labelTextStyle: TextStyle(fontSize: 20),
              inActiveTrackColor: Colors.grey.shade300,
              activeTrackColor: Colors.grey.shade500,
              labelBorderRadius: 18,
            ),
            SizedBox(height: 30),
            StepSlider(
              controller: _sliderController,
              steps: 6,
              onChanged: (i) {
                setState(() {
                  print(i);
                });
              },
              trackWidth: 10,
              labelTextStyle: TextStyle(fontSize: 14),
              inActiveTrackColor: Colors.grey.shade300,
              activeTrackColor: Colors.blue,
              labelBorderRadius: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: change,
                      child: Text("Change"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
