import 'package:flutter_svg/svg.dart';
import 'package:clinica_flow/core/utils/mixins/device_info_mixin.dart';
import 'package:flutter/material.dart';

class OnboardPage extends StatelessWidget with DeviceInfoMixin {
  const OnboardPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundAsset,
    this.assetTop,
    this.assetLeft,
    this.assetBottom,
    this.assetRight,
  });

  final String title;
  final String subtitle;
  final String backgroundAsset;

  final double? assetTop;
  final double? assetLeft;
  final double? assetBottom;
  final double? assetRight;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: assetTop,
        left: assetLeft,
        bottom: assetBottom,
        right: assetRight,
        child: SvgPicture.asset(
          backgroundAsset,
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.contain,
        ),
      ),
      Positioned(
        bottom: screenDimensions(context).height * 0.3,
        left: 20,
        right: 20,
        child: Column(
          children: [
            const SizedBox(height: 20), // Spacer
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10), // Spacer
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ]);
  }
}
