import 'package:flutter/material.dart';

class FixedGrid extends StatelessWidget {
  const FixedGrid({
    super.key,
    required this.children,
    this.childAspectRatio = 1.0,
    this.crossAxisCount,
    this.mainAxisCount,
    this.spacing = 0.0,
  });

  final List<Widget> children;
  final double childAspectRatio;
  final int? crossAxisCount;
  final int? mainAxisCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return Container();
    // One and only one axis count must be null
    assert(crossAxisCount != null || mainAxisCount != null);
    assert((crossAxisCount == null) != (mainAxisCount == null));
    assert(children.isNotEmpty);

    if (crossAxisCount != null) {
      final columnsCount = (children.length / crossAxisCount!).ceil();
      final horizontalSpacingsCount = crossAxisCount! - 1;
      final verticalSpacingsCount = columnsCount - 1;

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List<Widget>.generate(
          columnsCount + verticalSpacingsCount,
          (rawY) {
            if (rawY % 2 != 0) {
              return SizedBox(height: spacing);
            }
            final y = rawY ~/ 2;

            return Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  crossAxisCount! + horizontalSpacingsCount,
                  (rawX) {
                    if (rawX % 2 != 0) {
                      return SizedBox(width: spacing);
                    }

                    final x = rawX ~/ 2;
                    final index = x + y * crossAxisCount!;

                    return Flexible(
                      child: AspectRatio(
                        aspectRatio: childAspectRatio,
                        child: index < children.length
                            ? children[index]
                            : Container(),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    if (mainAxisCount != null) {
      final rowsCount = (children.length / mainAxisCount!).ceil();
      final verticalSpacingsCount = mainAxisCount! - 1;
      final horizontalSpacingsCount = rowsCount - 1;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          mainAxisCount! + verticalSpacingsCount, //include spacings
          (rawY) {
            if (rawY % 2 != 0) {
              return SizedBox(height: spacing);
            }

            final y = rawY ~/ 2;

            return Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  rowsCount + horizontalSpacingsCount,
                  (rawX) {
                    if (rawX % 2 != 0) {
                      return SizedBox(width: spacing);
                    }

                    final x = rawX ~/ 2;
                    final index = x + y * rowsCount;

                    return Flexible(
                      child: AspectRatio(
                        aspectRatio: childAspectRatio,
                        child: index < children.length
                            ? children[index]
                            : Container(),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    }
    return Container();
  }
}
