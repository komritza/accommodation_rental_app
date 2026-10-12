import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

class AppDateRangeCalendar extends StatefulWidget {
  const AppDateRangeCalendar({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.onDaySelected,
    this.rangeStart,
    this.rangeEnd,
    this.selectableDayPredicate,
    this.unavailableDayPredicate,
    this.unavailableDayLabel,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;

  final ValueChanged<DateTime>? onDaySelected;

  final bool Function(DateTime day)? selectableDayPredicate;

  final bool Function(DateTime day)? unavailableDayPredicate;

  final String? unavailableDayLabel;

  @override
  State<AppDateRangeCalendar> createState() => _AppDateRangeCalendarState();
}

class _AppDateRangeCalendarState extends State<AppDateRangeCalendar> {
  late final PageController _controller = PageController(
    initialPage: _initialPage,
  );

  DateTime get _firstMonth =>
      DateTime(widget.firstDate.year, widget.firstDate.month);

  int get _monthCount =>
      math.max(1, DateUtils.monthDelta(widget.firstDate, widget.lastDate) + 1);

  int get _initialPage {
    final start = widget.rangeStart;
    if (start == null) return 0;
    return DateUtils.monthDelta(
      widget.firstDate,
      start,
    ).clamp(0, _monthCount - 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showPage(int page) {
    _controller.animateToPage(
      page,
      duration: Durations.medium2,
      curve: Easing.standard,
    );
  }

  bool _isInRange(DateTime day) {
    return _dayKey(day) >= _dayKey(widget.firstDate) &&
        _dayKey(day) <= _dayKey(widget.lastDate);
  }

  bool _isUnavailable(DateTime day) {
    return _isInRange(day) &&
        (widget.unavailableDayPredicate?.call(day) ?? false);
  }

  bool _isSelectable(DateTime day) {
    return _isInRange(day) &&
        !_isUnavailable(day) &&
        (widget.selectableDayPredicate?.call(day) ?? true);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final daySize = math.min(
          AppCalendarTokens.daySize,
          constraints.maxWidth / DateTime.daysPerWeek,
        );

        return Center(
          child: SizedBox(
            width: daySize * DateTime.daysPerWeek,
            height:
                AppButtonTokens.height +
                AppCalendarTokens.weekdayHeight +
                daySize * AppCalendarTokens.weeksPerMonth,
            child: PageView.builder(
              controller: _controller,
              itemCount: _monthCount,
              itemBuilder: (context, page) => _MonthPage(
                month: DateUtils.addMonthsToMonthDate(_firstMonth, page),
                daySize: daySize,
                rangeStart: widget.rangeStart,
                rangeEnd: widget.rangeEnd,
                isSelectable: _isSelectable,
                isUnavailable: _isUnavailable,
                unavailableDayLabel: widget.unavailableDayLabel,
                onDaySelected: widget.onDaySelected,
                onPrevious: page > 0 ? () => _showPage(page - 1) : null,
                onNext: page < _monthCount - 1
                    ? () => _showPage(page + 1)
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

int _dayKey(DateTime day) => day.year * 10000 + day.month * 100 + day.day;

class _MonthPage extends StatelessWidget {
  const _MonthPage({
    required this.month,
    required this.daySize,
    required this.rangeStart,
    required this.rangeEnd,
    required this.isSelectable,
    required this.isUnavailable,
    required this.unavailableDayLabel,
    required this.onDaySelected,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final double daySize;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final bool Function(DateTime day) isSelectable;
  final bool Function(DateTime day) isUnavailable;
  final String? unavailableDayLabel;
  final ValueChanged<DateTime>? onDaySelected;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;
    final offset = DateUtils.firstDayOffset(
      month.year,
      month.month,
      localizations,
    );
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final today = DateUtils.dateOnly(DateTime.now());

    Widget dayAt(int cell) {
      final dayNumber = cell - offset + 1;
      if (dayNumber < 1 || dayNumber > daysInMonth) {
        return SizedBox.square(dimension: daySize);
      }
      final day = DateTime(month.year, month.month, dayNumber);
      final selectable = isSelectable(day);
      final onDaySelected = this.onDaySelected;
      final unavailable = isUnavailable(day);
      return _Day(
        day: day,
        size: daySize,
        position: _positionOf(day),
        isToday: DateUtils.isSameDay(day, today),
        isAvailable: selectable,
        isUnavailable: unavailable,
        unavailableLabel: unavailable ? unavailableDayLabel : null,
        readOnly: onDaySelected == null,
        onTap: selectable && onDaySelected != null
            ? () => onDaySelected(day)
            : null,
      );
    }

    return Column(
      children: [
        SizedBox(
          height: AppButtonTokens.height,
          child: Row(
            children: [
              IconButton(
                onPressed: onPrevious,
                tooltip: localizations.previousMonthTooltip,
                icon: const Icon(Icons.chevron_left, size: AppIconSizes.md),
              ),
              Expanded(
                child: Text(
                  localizations.formatMonthYear(month),
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium,
                ),
              ),
              IconButton(
                onPressed: onNext,
                tooltip: localizations.nextMonthTooltip,
                icon: const Icon(Icons.chevron_right, size: AppIconSizes.md),
              ),
            ],
          ),
        ),
        ExcludeSemantics(
          child: SizedBox(
            height: AppCalendarTokens.weekdayHeight,
            child: Row(
              children: [
                for (var i = 0; i < DateTime.daysPerWeek; i++)
                  SizedBox(
                    width: daySize,
                    child: Text(
                      localizations.narrowWeekdays[(localizations
                                  .firstDayOfWeekIndex +
                              i) %
                          DateTime.daysPerWeek],
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        for (var week = 0; week < AppCalendarTokens.weeksPerMonth; week++)
          Row(
            children: [
              for (var weekday = 0; weekday < DateTime.daysPerWeek; weekday++)
                dayAt(week * DateTime.daysPerWeek + weekday),
            ],
          ),
      ],
    );
  }

  _RangePosition _positionOf(DateTime day) {
    final start = rangeStart;
    if (start == null) return _RangePosition.none;

    final end = rangeEnd;
    final key = _dayKey(day);
    if (end == null || _dayKey(end) <= _dayKey(start)) {
      return key == _dayKey(start)
          ? _RangePosition.single
          : _RangePosition.none;
    }
    if (key == _dayKey(start)) return _RangePosition.start;
    if (key == _dayKey(end)) return _RangePosition.end;
    if (key > _dayKey(start) && key < _dayKey(end)) {
      return _RangePosition.middle;
    }
    return _RangePosition.none;
  }
}

enum _RangePosition {
  none,
  single,
  start,
  middle,
  end;

  bool get isEndpoint => this == single || this == start || this == end;
}

class _Day extends StatelessWidget {
  const _Day({
    required this.day,
    required this.size,
    required this.position,
    required this.isToday,
    required this.isAvailable,
    required this.isUnavailable,
    required this.unavailableLabel,
    required this.readOnly,
    required this.onTap,
  });

  final DateTime day;
  final double size;
  final _RangePosition position;
  final bool isToday;

  final bool isAvailable;
  final bool isUnavailable;
  final String? unavailableLabel;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final localizations = MaterialLocalizations.of(context);
    final interactive = onTap != null;

    final Color textColor;
    if (position.isEndpoint) {
      textColor = colors.textOnAction;
    } else if (isAvailable) {
      textColor = colors.textDefault;
    } else {
      textColor = colors.textMuted.withValues(
        alpha: AppButtonTokens.disabledOpacity,
      );
    }

    final band = switch (position) {
      _RangePosition.start => AlignmentDirectional.centerEnd,
      _RangePosition.end => AlignmentDirectional.centerStart,
      _RangePosition.middle => AlignmentDirectional.center,
      _RangePosition.none || _RangePosition.single => null,
    };

    return SizedBox.square(
      dimension: size,
      child: Stack(
        children: [
          if (band != null)
            Align(
              alignment: band,
              child: FractionallySizedBox(
                widthFactor: position == _RangePosition.middle ? 1 : 0.5,
                heightFactor: 1,
                child: ColoredBox(color: colors.surfaceSecondary),
              ),
            ),
          MergeSemantics(
            child: Semantics(
              button: !readOnly,
              enabled: readOnly ? null : interactive,
              selected: position != _RangePosition.none,
              label: localizations.formatFullDate(day),
              value: unavailableLabel,
              // Ink paints on the nearest Material; without this one the
              // range band would cover the endpoint circle.
              child: Material(
                type: MaterialType.transparency,
                child: InkResponse(
                  onTap: onTap,
                  customBorder: const CircleBorder(),
                  child: Ink(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: isToday && !position.isEndpoint
                            ? BorderSide(
                                color: colors.borderPrimary,
                                width: AppBorderWidths.regular,
                              )
                            : BorderSide.none,
                      ),
                      color: position.isEndpoint ? colors.surfaceAction : null,
                    ),
                    child: Center(
                      child: ExcludeSemantics(
                        child: Text(
                          localizations.formatDecimal(day.day),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: textColor,
                                fontWeight: position.isEndpoint || isToday
                                    ? AppTypography.weightSemibold
                                    : null,
                                decoration: isUnavailable
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor: textColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
