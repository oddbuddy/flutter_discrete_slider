import 'package:flutter/material.dart';
import 'package:discrete_slider/discrete_slider.dart';

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
  DiscreteSliderController _controller = DiscreteSliderController();
  DiscreteSliderController _sliderController = DiscreteSliderController();

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
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: DiscreteSlider(
                steps: 2,
                labels: ["Low", "Medium", "High"],
                onChanged: (i) {},
                labelTextStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 100),
            DiscreteSlider(
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: change,
                      child: Text("Change to 2"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DiscreteSlider(
                controller: _sliderController,
                steps: 6,
                onChanged: (i) {
                  setState(() {
                    print(i);
                  });
                },
                trackWidth: 10,
                labelTextStyle: TextStyle(fontSize: 14),
                inActiveColor: Colors.red.shade300,
                inActiveTrackColor: Colors.grey.shade300,
                activeTrackColor: Colors.red,
                activeColor: Colors.red.shade900,
                labelBorderRadius: 12,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DiscreteSlider(
                steps: 3,
                labels: ["Off", "Low", "Medium", "High"],
                onChanged: (level) {
                  print("Volume level: $level");
                },
                trackWidth: 8,
                height: 40,
                labelBorderRadius: 20,
                activeTrackColor: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DiscreteSlider(
                controller: _controller,
                steps: 4,
                labels: ["Start", "25%", "50%", "75%", "Complete"],
                onChanged: (_) {}, // Read-only in this case
                activeTrackColor: Colors.blue,
                inActiveTrackColor: Colors.grey.shade300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: DiscreteSlider(
                steps: 4,
                labels: ["Poor", "Fair", "Good", "Great", "Excellent"],
                onChanged: (rating) {
                  print("Rating: ${rating + 1} stars");
                },
                activeTrackColor: Colors.amber,
                labelTextStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.amber.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
