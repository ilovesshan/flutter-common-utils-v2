import 'package:flutter/material.dart';

class CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double maxExtent;
 
  @override
  double minExtent;

  Widget child;

  CustomSliverPersistentHeaderDelegate({required this.child, required this.maxExtent, required this.minExtent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        child: child
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
