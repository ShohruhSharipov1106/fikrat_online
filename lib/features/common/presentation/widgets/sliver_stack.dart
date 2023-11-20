import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fikrat_online/features/common/presentation/widgets/sliver_stack_rendering.dart';

class SliverStack extends MultiChildRenderObjectWidget {
  const SliverStack({
    Key? key,
    required List<Widget> children,
    this.textDirection,
    this.positionedAlignment = Alignment.center,
    this.insetOnOverlap = false,
  }) : super(key: key, children: children);

  final AlignmentGeometry positionedAlignment;
  final TextDirection? textDirection;
  final bool insetOnOverlap;

  @override
  RenderSliverStack createRenderObject(BuildContext context) {
    return RenderSliverStack()
      ..positionedAlignment = positionedAlignment
      ..textDirection = textDirection ?? Directionality.of(context)
      ..insetOnOverlap = insetOnOverlap;
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderSliverStack renderObject) {
    renderObject
      ..positionedAlignment = positionedAlignment
      ..textDirection = textDirection ?? Directionality.of(context)
      ..insetOnOverlap = insetOnOverlap;
  }
}

class SliverPositioned extends ParentDataWidget<SliverStackParentData> {
  const SliverPositioned({
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required Widget child,
  })  : assert(left == null || right == null || width == null),
        assert(top == null || bottom == null || height == null),
        super(key: key, child: child);
  SliverPositioned.fromRect({
    Key? key,
    required Rect rect,
    required Widget child,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null,
        super(key: key, child: child);
  SliverPositioned.fromRelativeRect({
    Key? key,
    required RelativeRect rect,
    required Widget child,
  })  : left = rect.left,
        top = rect.top,
        right = rect.right,
        bottom = rect.bottom,
        width = null,
        height = null,
        super(key: key, child: child);
  const SliverPositioned.fill({
    Key? key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    required Widget child,
  })  : width = null,
        height = null,
        super(key: key, child: child);
  factory SliverPositioned.directional({
    Key? key,
    required TextDirection textDirection,
    double? start,
    double? top,
    double? end,
    double? bottom,
    double? width,
    double? height,
    required Widget child,
  }) {
    double? left;
    double? right;
    switch (textDirection) {
      case TextDirection.rtl:
        left = end;
        right = start;
        break;
      case TextDirection.ltr:
        left = start;
        right = end;
        break;
    }
    return SliverPositioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: child,
    );
  }
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is SliverStackParentData);
    final parentData = renderObject.parentData as SliverStackParentData;
    bool needsLayout = false;

    if (parentData.left != left) {
      parentData.left = left;
      needsLayout = true;
    }

    if (parentData.top != top) {
      parentData.top = top;
      needsLayout = true;
    }

    if (parentData.right != right) {
      parentData.right = right;
      needsLayout = true;
    }

    if (parentData.bottom != bottom) {
      parentData.bottom = bottom;
      needsLayout = true;
    }

    if (parentData.width != width) {
      parentData.width = width;
      needsLayout = true;
    }

    if (parentData.height != height) {
      parentData.height = height;
      needsLayout = true;
    }

    if (needsLayout) {
      final Object? targetParent = renderObject.parent;
      if (targetParent is RenderObject) targetParent.markNeedsLayout();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('left', left, defaultValue: null));
    properties.add(DoubleProperty('top', top, defaultValue: null));
    properties.add(DoubleProperty('right', right, defaultValue: null));
    properties.add(DoubleProperty('bottom', bottom, defaultValue: null));
    properties.add(DoubleProperty('width', width, defaultValue: null));
    properties.add(DoubleProperty('height', height, defaultValue: null));
  }

  @override
  Type get debugTypicalAncestorWidgetClass => SliverStack;
}
