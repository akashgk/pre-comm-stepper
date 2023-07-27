import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no/widgets/form_body.dart';

import '../providers/list_pro.dart';
import 'lister.dart';

class Body extends ConsumerWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 2,
            child: Row(
              children: [
                Flexible(
                    child: Listerrs(
                  stages:
                      ref.watch(ref.watch(list1ManagerProvider).stageProvider),
                )),
                const Flexible(child: FormBody()),
              ],
            ),
          ),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.cyan[100],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 2,
            child: Row(
              children: [
                Flexible(
                    child: Listerrs(
                        stages: ref.watch(
                            ref.watch(list2ManagerProvider).stageProvider))),
                const Flexible(child: FormBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
