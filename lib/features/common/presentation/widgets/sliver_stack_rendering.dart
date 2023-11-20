import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class _SimpleSliverStackParentData extends StackParentData {
  final void Function(Offset value) onOffsetUpdated;

  _SimpleSliverStackParentData(this.onOffsetUpdated);

  @override
  set offset(Offset newOffset) {
    super.offset = newOffset;
    onOffsetUpdated(newOffset);
  }
}

class SliverStackParentData extends ParentData with ContainerParentDataMixin<RenderObject> {
  double? top;
  double? right;
  double? bottom;
  double? left;
  double? width;
  double? height;

  RelativeRect get rect => RelativeRect.fromLTRB(left!, top!, right!, bottom!);

  set rect(RelativeRect value) {
    top = value.top;
    right = value.right;
    bottom = value.bottom;
    left = value.left;
  }

  Offset paintOffset = Offset.zero;

  double mainAxisPosition = 0;
  double crossAxisPosition = 0;

  bool get isPositioned =>
      top != null || right != null || bottom != null || left != null || width != null || height != null;

  @override
  String toString() {
    final List<String> values = <String>[
      if (top != null) 'top=${debugFormatDouble(top)}',
      if (right != null) 'right=${debugFormatDouble(right)}',
      if (bottom != null) 'bottom=${debugFormatDouble(bottom)}',
      if (left != null) 'left=${debugFormatDouble(left)}',
      if (width != null) 'width=${debugFormatDouble(width)}',
      if (height != null) 'height=${debugFormatDouble(height)}',
    ];
    if (values.isEmpty) values.add('not positioned');
    values.add(super.toString());
    return values.join('; ');
  }

  _SimpleSliverStackParentData get _simpleStackParentData =>
      _SimpleSliverStackParentData((value) => paintOffset = value)
        ..top = top
        ..right = right
        ..bottom = bottom
        ..left = left
        ..width = width
        ..height = height
        ..offset = paintOffset;
}

class RenderSliverStack extends RenderSliver
    with ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>>, RenderSliverHelpers {
  AlignmentGeometry get positionedAlignment => _positionedAlignment!;
  AlignmentGeometry? _positionedAlignment;

  set positionedAlignment(AlignmentGeometry value) {
    if (_positionedAlignment != value) {
      _positionedAlignment = value;
      markNeedsLayout();
    }
  }

  TextDirection get textDirection => _textDirection!;
  TextDirection? _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection != value) {
      _textDirection = value;
      _alignment = null;
      markNeedsLayout();
    }
  }

  bool get insetOnOverlap => _insetOnOverlap!;
  bool? _insetOnOverlap;

  set insetOnOverlap(bool value) {
    if (_insetOnOverlap != value) {
      _insetOnOverlap = value;
      markNeedsLayout();
    }
  }

  Alignment? _alignment;

  Iterable<RenderObject> get _children sync* {
    RenderObject? child = firstChild;
    while (child != null) {
      yield child;
      child = childAfter(child);
    }
  }

  Iterable<RenderObject> get _childrenInHitTestOrder sync* {
    RenderObject? child = lastChild;
    while (child != null) {
      yield child;
      child = childBefore(child);
    }
  }

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = SliverStackParentData();
  }

  @override
  void performLayout() {
    if (firstChild == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    final axisDirection = applyGrowthDirectionToAxisDirection(constraints.axisDirection, constraints.growthDirection);
    final double overlapAndScroll = insetOnOverlap ? max(0.0, constraints.overlap + constraints.scrollOffset) : 0;
    final overlap = insetOnOverlap ? max(0.0, constraints.overlap) : 0;

    bool hasVisualOverflow = false;
    double maxScrollExtent = 0;
    double maxPaintExtent = 0;
    double maxMaxPaintExtent = 0;
    double maxLayoutExtent = 0;
    double maxHitTestExtent = 0;
    double maxScrollObstructionExtent = 0;
    double maxCacheExtent = 0;
    double? minPaintOrigin;
    for (final child in _children.whereType<RenderSliver>()) {
      final parentData = child.parentData as SliverStackParentData;
      child.layout(constraints, parentUsesSize: true);
      assert(
        child.geometry != null,
        'Sliver child $child did not set its geometry',
      );
      final childGeometry = child.geometry!;
      if (childGeometry.scrollOffsetCorrection != null) {
        geometry = SliverGeometry(scrollOffsetCorrection: childGeometry.scrollOffsetCorrection);
        return;
      }
      minPaintOrigin = min(
        minPaintOrigin ?? double.infinity,
        childGeometry.paintOrigin,
      );
      maxScrollExtent = max(maxScrollExtent, childGeometry.scrollExtent);
      maxPaintExtent = max(maxPaintExtent, childGeometry.paintExtent);
      maxMaxPaintExtent = max(maxMaxPaintExtent, childGeometry.maxPaintExtent);
      maxLayoutExtent = max(maxLayoutExtent, childGeometry.layoutExtent);
      maxHitTestExtent = max(maxHitTestExtent, childGeometry.hitTestExtent);
      maxScrollObstructionExtent = max(
        maxScrollObstructionExtent,
        childGeometry.maxScrollObstructionExtent,
      );
      maxCacheExtent = max(maxCacheExtent, childGeometry.cacheExtent);
      hasVisualOverflow = hasVisualOverflow || childGeometry.hasVisualOverflow || childGeometry.paintOrigin < 0;
      parentData.mainAxisPosition = 0;
    }
    geometry = SliverGeometry(
      paintOrigin: minPaintOrigin ?? 0,
      scrollExtent: maxScrollExtent,
      paintExtent: maxPaintExtent,
      maxPaintExtent: maxMaxPaintExtent,
      layoutExtent: maxLayoutExtent,
      hitTestExtent: maxHitTestExtent,
      maxScrollObstructionExtent: maxScrollObstructionExtent,
      cacheExtent: maxCacheExtent,
      hasVisualOverflow: hasVisualOverflow,
    );
    for (final child in _children.whereType<RenderSliver>()) {
      final parentData = child.parentData as SliverStackParentData;
      switch (axisDirection) {
        case AxisDirection.up:
          parentData.paintOffset = Offset(
            0,
            geometry!.paintExtent - parentData.mainAxisPosition - child.geometry!.paintExtent,
          );
          break;
        case AxisDirection.right:
          parentData.paintOffset = Offset(parentData.mainAxisPosition, 0);
          break;
        case AxisDirection.down:
          parentData.paintOffset = Offset(0, parentData.mainAxisPosition);
          break;
        case AxisDirection.left:
          parentData.paintOffset = Offset(
            geometry!.paintExtent - parentData.mainAxisPosition - child.geometry!.paintExtent,
            0,
          );
          break;
      }
    }

    final size = constraints.axis == Axis.vertical
        ? Size(
            constraints.crossAxisExtent,
            max(geometry!.maxPaintExtent - overlapAndScroll, geometry!.paintExtent - overlap),
          )
        : Size(
            max(geometry!.maxPaintExtent - overlapAndScroll, geometry!.paintExtent - overlap),
            constraints.crossAxisExtent,
          );
    for (final child in _children.whereType<RenderBox>()) {
      final parentData = child.parentData as SliverStackParentData;
      assert(parentData.isPositioned, 'All non sliver children of SliverStack should be positioned');
      if (!parentData.isPositioned) return;
      child.parentData = parentData._simpleStackParentData;
      final overflows = RenderStack.layoutPositionedChild(
        child,
        child.parentData as StackParentData,
        size,
        _alignment ??= positionedAlignment.resolve(textDirection),
      );
      child.parentData = parentData;
      final paintOffset = constraints.scrollOffset - overlapAndScroll;
      switch (axisDirection) {
        case AxisDirection.up:
          parentData.paintOffset = Offset(
            parentData.paintOffset.dx,
            -geometry!.maxPaintExtent +
                min(geometry!.maxPaintExtent, geometry!.paintExtent + constraints.scrollOffset) +
                parentData.paintOffset.dy,
          );
          parentData.mainAxisPosition = geometry!.paintExtent - parentData.paintOffset.dy - child.size.height;
          parentData.crossAxisPosition = parentData.paintOffset.dx;
          break;
        case AxisDirection.right:
          parentData.paintOffset = parentData.paintOffset - Offset(paintOffset, 0);
          parentData.mainAxisPosition = parentData.paintOffset.dx;
          parentData.crossAxisPosition = parentData.paintOffset.dy;
          break;
        case AxisDirection.down:
          parentData.paintOffset = parentData.paintOffset - Offset(0, paintOffset);
          parentData.mainAxisPosition = parentData.paintOffset.dy;
          parentData.crossAxisPosition = parentData.paintOffset.dx;
          break;
        case AxisDirection.left:
          parentData.paintOffset = Offset(
              -geometry!.maxPaintExtent +
                  min(geometry!.maxPaintExtent, geometry!.paintExtent + constraints.scrollOffset) +
                  parentData.paintOffset.dx,
              parentData.paintOffset.dy);
          parentData.mainAxisPosition = geometry!.paintExtent - parentData.paintOffset.dx - child.size.width;
          parentData.crossAxisPosition = parentData.paintOffset.dy;
          break;
      }
      hasVisualOverflow = hasVisualOverflow || overflows;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (!geometry!.visible) return;
    for (final child in _children) {
      if (child is RenderSliver && child.geometry!.visible || child is RenderBox) {
        final parentData = child.parentData as SliverStackParentData;
        context.paintChild(child, offset + parentData.paintOffset);
      }
    }
  }

  @override
  void applyPaintTransform(covariant RenderObject child, Matrix4 transform) {
    if (child is RenderSliver && child.geometry!.visible || child is RenderBox) {
      final parentData = child.parentData as SliverStackParentData;
      transform.translate(parentData.paintOffset.dx, parentData.paintOffset.dy);
    }
  }

  double _computeChildMainAxisPosition(RenderObject child, double parentMainAxisPosition) {
    final childParentData = child.parentData as SliverStackParentData;
    return parentMainAxisPosition - childParentData.mainAxisPosition;
  }

  @override
  double childMainAxisPosition(covariant RenderObject child) {
    final childParentData = child.parentData as SliverStackParentData;
    return childParentData.mainAxisPosition;
  }

  @override
  double childCrossAxisPosition(covariant RenderObject child) {
    final childParentData = child.parentData as SliverStackParentData;
    return childParentData.crossAxisPosition;
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    final boxResult = BoxHitTestResult.wrap(result);
    for (final child in _childrenInHitTestOrder) {
      if (child is RenderSliver && child.geometry!.visible) {
        final hit = child.hitTest(
          result,
          mainAxisPosition: _computeChildMainAxisPosition(child, mainAxisPosition),
          crossAxisPosition: crossAxisPosition,
        );
        if (hit) return true;
      } else if (child is RenderBox) {
        hitTestBoxChild(boxResult, child, mainAxisPosition: mainAxisPosition, crossAxisPosition: crossAxisPosition);
      }
    }
    return false;
  }
}
