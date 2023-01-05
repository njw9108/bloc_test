import 'package:bloc_test_2/old/bloc/count_bloc.dart';
import 'package:bloc_test_2/old/components/count_view.dart';
import 'package:bloc_test_2/old/ui/temp_screen.dart';
import 'package:flutter/material.dart';

class BlocDisplayWidget extends StatefulWidget {
  const BlocDisplayWidget({super.key});

  @override
  State<BlocDisplayWidget> createState() => _BlocDisplayWidgetState();
}

class _BlocDisplayWidgetState extends State<BlocDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bloc 패턴"),
      ),
      body: const CountView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TempScreen(),
            ),
          );
        },
      ),
    );
  }
}
