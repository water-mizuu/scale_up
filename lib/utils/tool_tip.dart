import "package:flutter/material.dart";
import "package:super_tooltip/super_tooltip.dart";

class ToolTip extends SuperTooltip {
  ToolTip({
    super.key,
    required super.content,
    super.popupDirection = TooltipDirection.down,
    super.controller,
    super.onLongPress,
    super.onShow,
    super.onHide,
    /**
     * showCloseButton
     * This will enable the closeButton
     */
    super.showCloseButton = false,
    super.closeButtonType = CloseButtonType.inside,
    super.closeButtonColor,
    super.closeButtonSize,
    super.showBarrier,
    super.snapsFarAwayVertically = false,
    super.snapsFarAwayHorizontally = false,
    super.hasShadow,
    // super.shadowColor,
    super.shadowBlurRadius,
    super.shadowSpreadRadius,
    super.shadowOffset,
    super.top,
    super.right,
    super.bottom,
    super.left,
    // TD: Make edgeinsets instead
    super.minimumOutsideMargin = 20.0,
    super.verticalOffset = 0.0,
    super.elevation = 0.0,
    // TD: The native flutter tooltip uses verticalOffset
    //  to space the tooltip from the child. But we'll likely
    // need just offset, since it's 4 way directional
    // super.verticalOffset = 24.0,
    // super.backgroundColor,

    //
    //
    //
    super.decorationBuilder,
    super.child,
    super.constraints = const BoxConstraints(
      minHeight: 0.0,
      maxHeight: double.infinity,
      minWidth: 0.0,
      maxWidth: double.infinity,
    ),
    super.fadeInDuration = const Duration(milliseconds: 150),
    super.fadeOutDuration = const Duration(milliseconds: 0),
    super.arrowTipRadius = 0.0,
    super.arrowTipDistance = 2.0,
    super.touchThroughAreaShape = ClipAreaShape.oval,
    super.touchThroughAreaCornerRadius = 5.0,
    super.touchThroughArea,
    super.borderWidth = 0.0,
    super.borderRadius = 10.0,
    super.overlayDimensions = const EdgeInsets.all(10),
    super.bubbleDimensions = const EdgeInsets.all(10),
    super.hideTooltipOnTap = false,
    super.sigmaX = 5.0,
    super.sigmaY = 5.0,
    super.showDropBoxFilter = false,
    super.hideTooltipOnBarrierTap = true,
    super.toggleOnTap = false,
    super.showOnTap = true,
    super.boxShadows,
  }) : super(
         arrowLength: 8.0,
         arrowBaseWidth: 12.0,
         backgroundColor: Colors.white,
         barrierColor: Colors.transparent,
         borderColor: Colors.transparent,
         shadowColor: Colors.black.withValues(alpha: 0.125),
       );
}
