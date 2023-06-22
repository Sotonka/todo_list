// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons extends StatelessWidget {
  static const _add = '${_defaultPath}add.svg';
  static const _alert = '${_defaultPath}alert.svg';
  static const _arrowBack = '${_defaultPath}arrow_back.svg';
  static const _arrowDown = '${_defaultPath}arrow_down.svg';
  static const _check = '${_defaultPath}check.svg';
  static const _close = '${_defaultPath}close.svg';
  static const _delete = '${_defaultPath}delete.svg';
  static const _infoOutline = '${_defaultPath}info_outline.svg';
  static const _visibility = '${_defaultPath}visibility.svg';
  static const _visibilityOff = '${_defaultPath}visibility_off.svg';

  static const String _defaultPath = 'res/icons/';

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  const AppIcons({
    required this.assetPath,
    this.width,
    this.height,
    this.fit,
    this.color,
    Key? key,
  }) : super(key: key);

  factory AppIcons.add({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _add,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.alert({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _alert,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.arrowBack({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _arrowBack,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.arrowDown({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _arrowDown,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.check({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _check,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.close({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _close,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.delete({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _delete,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.infoOutline({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _infoOutline,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.visibility({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _visibility,
        color: color,
        height: height,
        width: width,
      );

  factory AppIcons.visibilityOff({
    final Color? color,
    final double? height,
    final double? width,
  }) =>
      AppIcons(
        assetPath: _visibilityOff,
        color: color,
        height: height,
        width: width,
      );

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        color: color,
        key: key,
      );
}
