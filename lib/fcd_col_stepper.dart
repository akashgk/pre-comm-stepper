import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double height = 70;

class Modess {
  final List<int> fixed;
  final List<int> scrollable;
  final int tail;
  final Color color;

  Modess(
      {required this.fixed,
      required this.scrollable,
      required this.tail,
      required this.color});
}

List<Modess> modsss = [
  Modess(
      fixed: [1, 2, 3],
      scrollable: [13, 14, 15, 16, 17, 18, 19],
      tail: 41,
      color: Colors.green),
  Modess(
      fixed: [4, 5, 6],
      scrollable: [20, 21, 22, 23, 24, 25, 26],
      tail: 42,
      color: Colors.blueGrey),
  Modess(
      fixed: [7, 8, 9],
      scrollable: [27, 28, 29, 30, 31, 32, 33],
      tail: 43,
      color: Colors.purpleAccent),
  Modess(
      fixed: [10, 11, 12],
      scrollable: [34, 35, 36, 37, 38, 39, 40],
      tail: 44,
      color: Colors.yellow),
];

void main() {
  runApp(const ProviderScope(child: Main()));
}

class Main extends ConsumerStatefulWidget {
  const Main({super.key});

  @override
  ConsumerState<Main> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LayoutBuilder(builder: (context, snapshot) {
          return ConstrainedBox(
            constraints: snapshot,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Body1(),
                    Body2(),
                    Body3(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class Body1 extends StatelessWidget {
  const Body1({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> columnChildrens = [
      ...List.generate(modsss.first.fixed.length, (index) => [])
    ];
    for (int i = 0; i < modsss.length; ++i) {
      for (int k = 0; k < modsss.first.fixed.length; ++k) {
        columnChildrens[k].add(
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: height, minWidth: 120),
            child: Container(
              color: modsss[i].color,
              child: Text(
                modsss[i].fixed[k].toString(),
              ),
            ),
          ),
        );
      }
    }
    return Row(
      children: List.generate(
          modsss.first.fixed.length,
          (index) => Column(
                children: columnChildrens[index],
              )),
    );
  }
}

class Colu extends StatelessWidget {
  final int index;
  const Colu(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: height, minWidth: 120),
          child: Container(
            color: Colors.red,
            child: Text("$index"),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: height, minWidth: 120),
          child: Container(
            color: Colors.green,
            child: Text("$index"),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: height, minWidth: 120),
          child: Container(
            color: Colors.yellow,
            child: Text("$index"),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: height, minWidth: 120),
          child: Container(
            color: Colors.blue,
            child: Text("$index"),
          ),
        ),
      ],
    );
  }
}

class Body2 extends StatelessWidget {
  const Body2({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: modsss.length * height),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 50,
          itemBuilder: (c, i) => Colu(i),
        ),
      ),
    );
  }
}

class Body3 extends StatelessWidget {
  const Body3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Colu(100);
  }
}



// Get the Column tile list from the column provider
// if locked it is in front fixed.
// only action will be in the 
// fronFixedRowWidgets: isShown && isLocked && ColumnKey != Action.
// scrollableWidgets: scrollable:  isShown && isLocked
// backFixedWidget: actions: if ColumnKey == Action.
// Each trade record: [locked shown, locked shown] [shown, shown, shown, shown, shown], action
// List<Model>
// Model has 4 props, tail <widget>, scrollable widget List<Widget>, locked Widget <Widget>, row color, row height, columnWidth
// [3,3,3][1,1,1,1,1,1,1,1,1,][1]
// [3,3,3][1,1,1,1,1,1,1,1,1,][1]
// [3,3,3][1,1,1,1,1,1,1,1,1,][1]
// [3,3,3][1,1,1,1,1,1,1,1,1,][1]
// [3,3,3][1,1,1,1,1,1,1,1,1,][1]
