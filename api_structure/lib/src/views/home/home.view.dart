import 'package:flutter/material.dart';

import '../../data/entity/entity.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, this.entity});

  final LoginResponseEntity? entity;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Welcome ${widget.entity?.firstName} ${widget.entity?.lastName}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: constraints.maxWidth / 1.05,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Here is all the data returned from the API ${widget.entity?.toJson()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
