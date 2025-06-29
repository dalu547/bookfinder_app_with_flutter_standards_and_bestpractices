import 'package:bookfinder/presentation/screens/booksearch/widgets/thubmnail_fallback.dart';
import 'package:flutter/material.dart';

class RotatingNetworkImageWithFallback extends StatefulWidget {
  final String imageUrl;
  final String fallbackAsset;
  final double width;
  final double height;
  final bool animate;

  const RotatingNetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.fallbackAsset,
    required this.width,
    required this.height,
    required this.animate,
  });

  @override
  State<RotatingNetworkImageWithFallback> createState() =>
      _RotatingNetworkImageWithFallbackState();
}

class _RotatingNetworkImageWithFallbackState
    extends State<RotatingNetworkImageWithFallback>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    if (widget.animate) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant RotatingNetworkImageWithFallback oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.forward();
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = NetworkImageWithFallback(
      imageUrl: widget.imageUrl,
      fallbackAsset: widget.fallbackAsset,
      width: widget.width,
      height: widget.height,
    );

    return widget.animate
        ? RotationTransition(turns: _controller, child: imageWidget)
        : imageWidget;
  }
}
