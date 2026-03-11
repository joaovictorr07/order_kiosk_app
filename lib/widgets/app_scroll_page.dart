import 'package:flutter/material.dart';

import '../core/theme/app_spacing.dart';

class AppScrollPage extends StatelessWidget {
  const AppScrollPage({
    super.key,
    required this.child,
    this.maxWidth = 420,
    this.centerContent = false,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final bool centerContent;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final resolvedPadding =
        padding ??
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        );

    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: resolvedPadding.add(
                EdgeInsets.only(bottom: keyboardInset),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: centerContent
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [child],
                          )
                        : child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}