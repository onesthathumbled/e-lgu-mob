import 'package:flutter/material.dart';
import '../../theme/shadcn_theme.dart';

/// Shadcn-inspired component library for Flutter
/// Small, composable widgets following shadcn/ui patterns

/// A shadcn-style button component
class ShadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ShadButtonVariant variant;
  final ShadButtonSize size;
  final bool isLoading;
  final Widget? icon;
  final bool fullWidth;

  const ShadButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ShadButtonVariant.primary,
    this.size = ShadButtonSize.default_,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: size.iconSize,
            height: size.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ShadButtonVariant.primary 
                  ? ShadcnTheme.primaryForeground 
                  : ShadcnTheme.foreground,
              ),
            ),
          ),
          const SizedBox(width: ShadcnTheme.space2),
        ] else if (icon != null) ...[
          icon!,
          const SizedBox(width: ShadcnTheme.space2),
        ],
        Text(text),
      ],
    );

    switch (variant) {
      case ShadButtonVariant.primary:
        return SizedBox(
          width: fullWidth ? double.infinity : null,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ShadcnTheme.primary,
              foregroundColor: ShadcnTheme.primaryForeground,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.horizontalPadding,
                vertical: size.verticalPadding,
              ),
              minimumSize: Size(0, size.height),
            ),
            child: buttonChild,
          ),
        );
      case ShadButtonVariant.secondary:
        return SizedBox(
          width: fullWidth ? double.infinity : null,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ShadcnTheme.secondary,
              foregroundColor: ShadcnTheme.secondaryForeground,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.horizontalPadding,
                vertical: size.verticalPadding,
              ),
              minimumSize: Size(0, size.height),
            ),
            child: buttonChild,
          ),
        );
      case ShadButtonVariant.outline:
        return SizedBox(
          width: fullWidth ? double.infinity : null,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: ShadcnTheme.foreground,
              side: const BorderSide(color: ShadcnTheme.border, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.horizontalPadding,
                vertical: size.verticalPadding,
              ),
              minimumSize: Size(0, size.height),
            ),
            child: buttonChild,
          ),
        );
      case ShadButtonVariant.ghost:
        return SizedBox(
          width: fullWidth ? double.infinity : null,
          child: TextButton(
            onPressed: isLoading ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: ShadcnTheme.foreground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.horizontalPadding,
                vertical: size.verticalPadding,
              ),
              minimumSize: Size(0, size.height),
            ),
            child: buttonChild,
          ),
        );
    }
  }
}

enum ShadButtonVariant { primary, secondary, outline, ghost }

enum ShadButtonSize {
  sm(32, 6, 2, 16),
  default_(40, 8, 2, 16),
  lg(44, 10, 2, 18),
  icon(40, 8, 8, 16);

  const ShadButtonSize(this.height, this.horizontalPadding, this.verticalPadding, this.iconSize);
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double iconSize;
}

/// A shadcn-style card component
class ShadCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool isClickable;

  const ShadCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: ShadcnTheme.card,
        borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
        border: Border.all(color: ShadcnTheme.border, width: 0.5),
        boxShadow: ShadcnTheme.shadowSm,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(ShadcnTheme.space6),
        child: child,
      ),
    );

    if (isClickable || onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
        child: card,
      );
    }

    return card;
  }
}

/// A shadcn-style input component
class ShadInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;

  const ShadInput({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: ShadcnTheme.space2),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: placeholder,
            helperText: helperText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            counterText: maxLength != null ? null : '',
          ),
        ),
      ],
    );
  }
}

/// A shadcn-style banner component
class ShadBanner extends StatelessWidget {
  final String title;
  final String? description;
  final ShadBannerVariant variant;
  final Widget? action;
  final VoidCallback? onDismiss;

  const ShadBanner({
    super.key,
    required this.title,
    this.description,
    this.variant = ShadBannerVariant.default_,
    this.action,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    
    return Container(
      padding: const EdgeInsets.all(ShadcnTheme.space4),
      decoration: BoxDecoration(
        color: colors.background,
        border: Border.all(color: colors.border, width: 0.5),
        borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
        boxShadow: ShadcnTheme.shadowSm,
      ),
      child: Row(
        children: [
          Icon(
            _getIcon(),
            color: colors.icon,
            size: 20,
          ),
          const SizedBox(width: ShadcnTheme.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: colors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: ShadcnTheme.space1),
                  Text(
                    description!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.text,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) ...[
            const SizedBox(width: ShadcnTheme.space3),
            action!,
          ],
          if (onDismiss != null) ...[
            const SizedBox(width: ShadcnTheme.space2),
            IconButton(
              onPressed: onDismiss,
              icon: const Icon(Icons.close, size: 16),
              color: colors.icon,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ],
      ),
    );
  }

  _BannerColors _getColors() {
    switch (variant) {
      case ShadBannerVariant.default_:
        return _BannerColors(
          background: ShadcnTheme.background,
          border: ShadcnTheme.border,
          text: ShadcnTheme.foreground,
          icon: ShadcnTheme.foreground,
        );
      case ShadBannerVariant.destructive:
        return _BannerColors(
          background: const Color(0xFFFEF2F2),
          border: const Color(0xFFFECACA),
          text: const Color(0xFF991B1B),
          icon: const Color(0xFFDC2626),
        );
      case ShadBannerVariant.warning:
        return _BannerColors(
          background: const Color(0xFFFFFBEB),
          border: const Color(0xFFFED7AA),
          text: const Color(0xFF92400E),
          icon: const Color(0xFFF59E0B),
        );
      case ShadBannerVariant.success:
        return _BannerColors(
          background: const Color(0xFFF0FDF4),
          border: const Color(0xFFBBF7D0),
          text: const Color(0xFF166534),
          icon: const Color(0xFF22C55E),
        );
    }
  }

  IconData _getIcon() {
    switch (variant) {
      case ShadBannerVariant.default_:
        return Icons.info_outline;
      case ShadBannerVariant.destructive:
        return Icons.error_outline;
      case ShadBannerVariant.warning:
        return Icons.warning_outlined;
      case ShadBannerVariant.success:
        return Icons.check_circle_outline;
    }
  }
}

enum ShadBannerVariant { default_, destructive, warning, success }

class _BannerColors {
  final Color background;
  final Color border;
  final Color text;
  final Color icon;

  _BannerColors({
    required this.background,
    required this.border,
    required this.text,
    required this.icon,
  });
}

/// A loading skeleton component
class ShadSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ShadSkeleton({
    super.key,
    this.width,
    this.height = 20,
    this.borderRadius,
  });

  @override
  State<ShadSkeleton> createState() => _ShadSkeletonState();
}

class _ShadSkeletonState extends State<ShadSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: ShadcnTheme.muted,
            borderRadius: widget.borderRadius ?? 
                BorderRadius.circular(ShadcnTheme.radiusSm),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? 
                  BorderRadius.circular(ShadcnTheme.radiusSm),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ShadcnTheme.muted,
                  ShadcnTheme.muted.withValues(alpha: 0.5),
                  ShadcnTheme.muted,
                ],
                stops: [
                  _animation.value - 0.3,
                  _animation.value,
                  _animation.value + 0.3,
                ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A service card component for the LGU app
class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String estimatedTime;
  final VoidCallback? onTap;
  final bool isAvailable;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.estimatedTime,
    this.onTap,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      onTap: isAvailable ? onTap : null,
      isClickable: isAvailable,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ShadcnTheme.space2,
                  vertical: ShadcnTheme.space1,
                ),
                decoration: BoxDecoration(
                  color: _getCategoryColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ShadcnTheme.radiusSm),
                ),
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: _getCategoryColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: ShadcnTheme.space2),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ShadcnTheme.mutedForeground,
            ),
          ),
          const SizedBox(height: ShadcnTheme.space3),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: ShadcnTheme.mutedForeground,
              ),
              const SizedBox(width: ShadcnTheme.space1),
              Text(
                estimatedTime,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ShadcnTheme.mutedForeground,
                ),
              ),
              const Spacer(),
              if (!isAvailable)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ShadcnTheme.space2,
                    vertical: ShadcnTheme.space1,
                  ),
                  decoration: BoxDecoration(
                    color: ShadcnTheme.destructive.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ShadcnTheme.radiusSm),
                  ),
                  child: Text(
                    'Unavailable',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: ShadcnTheme.destructive,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor() {
    switch (category.toLowerCase()) {
      case 'business':
        return ShadcnTheme.taskBlue;
      case 'property':
        return ShadcnTheme.primary;
      case 'civil registry':
        return ShadcnTheme.taskOrange;
      case 'identification':
        return ShadcnTheme.taskPurple;
      case 'health':
        return ShadcnTheme.taskPink;
      case 'social services':
        return ShadcnTheme.primary;
      case 'community':
        return ShadcnTheme.taskBlue;
      default:
        return ShadcnTheme.primary;
    }
  }
}

/// Modern progress card component matching the design
class ProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final Color progressColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const ProgressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.progressColor,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      onTap: onTap,
      isClickable: onTap != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ShadcnTheme.radiusMd),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: ShadcnTheme.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ShadcnTheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ShadcnTheme.space2,
                  vertical: ShadcnTheme.space1,
                ),
                decoration: BoxDecoration(
                  color: progressColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ShadcnTheme.radiusSm),
                ),
                child: Text(
                  '${(progress * 100).round()}%',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: progressColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: ShadcnTheme.space4),
          ClipRRect(
            borderRadius: BorderRadius.circular(ShadcnTheme.radiusSm),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: ShadcnTheme.muted,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

/// Modern task list item component
class TaskListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? timeIndicator;
  final bool isCompleted;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;

  const TaskListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.timeIndicator,
    this.isCompleted = false,
    this.icon,
    this.iconColor,
    this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ShadcnTheme.space2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
          child: Container(
            padding: const EdgeInsets.all(ShadcnTheme.space4),
            decoration: BoxDecoration(
              color: ShadcnTheme.background,
              borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
              border: Border.all(color: ShadcnTheme.border, width: 0.5),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCompleted ? ShadcnTheme.primary : ShadcnTheme.border,
                        width: 2,
                      ),
                      color: isCompleted ? ShadcnTheme.primary : Colors.transparent,
                    ),
                    child: isCompleted
                        ? const Icon(
                            Icons.check,
                            color: ShadcnTheme.primaryForeground,
                            size: 16,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: ShadcnTheme.space3),
                if (icon != null) ...[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: (iconColor ?? ShadcnTheme.primary).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(ShadcnTheme.radiusSm),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? ShadcnTheme.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: ShadcnTheme.space3),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                          color: isCompleted ? ShadcnTheme.mutedForeground : ShadcnTheme.foreground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: ShadcnTheme.space1),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ShadcnTheme.mutedForeground,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (timeIndicator != null) ...[
                  const SizedBox(width: ShadcnTheme.space2),
                  Text(
                    timeIndicator!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ShadcnTheme.mutedForeground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(width: ShadcnTheme.space2),
                Icon(
                  Icons.more_vert,
                  color: ShadcnTheme.mutedForeground,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
