import 'package:accommodation_core/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  final config = createTestConfig();

  return MaterialApp(
    theme: buildTenantTheme(config.theme.light, brightness: Brightness.light),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('AppChip', () {
    testWidgets('fills a selected chip with the action colors', (tester) async {
      await tester.pumpWidget(
        _wrap(AppChip(label: 'Lucerne', selected: true, onPressed: () {})),
      );

      final colors = Theme.of(
        tester.element(find.byType(AppChip)),
      ).extension<AccommodationColors>()!;
      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(button.style!.backgroundColor!.resolve({}), colors.surfaceAction);
      expect(button.style!.foregroundColor!.resolve({}), colors.textOnAction);
      expect(
        tester.getSemantics(find.byType(AppChip)),
        isSemantics(isSelected: true, isButton: true, label: 'Lucerne'),
      );
    });

    testWidgets('exposes a custom semantic label and meets the touch target', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          AppChip(
            label: 'Lucerne',
            semanticLabel: 'Remove filter Lucerne',
            trailingIcon: Icons.close,
            onPressed: () {},
          ),
        ),
      );

      expect(find.bySemanticsLabel('Remove filter Lucerne'), findsOneWidget);
      expect(
        tester.getSize(find.byType(OutlinedButton)).height,
        AppChipTokens.height,
      );
    });
  });

  group('AppCoverImage', () {
    testWidgets('shows a labelled placeholder when there is no image', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const SizedBox(
            width: 400,
            child: AppCoverImage(
              url: null,
              semanticLabel: 'Chalet',
              propertyTypeLabel: 'Loft',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
      expect(find.bySemanticsLabel('Chalet'), findsOneWidget);
      expect(tester.getSize(find.byType(AspectRatio)), const Size(400, 300));
    });
  });

  group('AppDateRangeCalendar', () {
    Widget calendar({
      DateTime? rangeStart,
      DateTime? rangeEnd,
      ValueChanged<DateTime>? onDaySelected,
      bool Function(DateTime day)? selectableDayPredicate,
    }) {
      return _wrap(
        SizedBox(
          width: 390,
          child: AppDateRangeCalendar(
            firstDate: DateTime(2030, 3, 10),
            lastDate: DateTime(2030, 5, 31),
            rangeStart: rangeStart,
            rangeEnd: rangeEnd,
            selectableDayPredicate: selectableDayPredicate,
            onDaySelected: onDaySelected ?? (_) {},
          ),
        ),
      );
    }

    testWidgets('reports the tapped day and disables days out of range', (
      tester,
    ) async {
      final selected = <DateTime>[];
      await tester.pumpWidget(
        calendar(
          onDaySelected: selected.add,
          selectableDayPredicate: (day) => day.day != 20,
        ),
      );

      expect(find.text('March 2030'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Friday, March 15, 2030'));
      await tester.tap(find.bySemanticsLabel('Saturday, March 9, 2030'));
      await tester.tap(find.bySemanticsLabel('Wednesday, March 20, 2030'));

      expect(selected, [DateTime(2030, 3, 15)]);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Saturday, March 9, 2030')),
        isSemantics(isButton: true, hasEnabledState: true, isEnabled: false),
      );
    });

    testWidgets('marks the selected range for assistive technology', (
      tester,
    ) async {
      await tester.pumpWidget(
        calendar(
          rangeStart: DateTime(2030, 3, 15),
          rangeEnd: DateTime(2030, 3, 17),
        ),
      );

      for (final day in [15, 16, 17]) {
        final label =
            '${['Friday', 'Saturday', 'Sunday'][day - 15]}, '
            'March $day, 2030';
        expect(
          tester.getSemantics(find.bySemanticsLabel(label)),
          isSemantics(isSelected: true),
        );
      }
      expect(
        tester.getSemantics(find.bySemanticsLabel('Monday, March 18, 2030')),
        isSemantics(isSelected: false),
      );
    });

    testWidgets('pages between months and stops at the bounds', (tester) async {
      await tester.pumpWidget(calendar());

      final previous = find.byTooltip('Previous month');
      expect(
        tester
            .widget<IconButton>(
              find.ancestor(of: previous, matching: find.byType(IconButton)),
            )
            .onPressed,
        isNull,
      );

      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
      expect(find.text('April 2030'), findsOneWidget);

      await tester.tap(find.byTooltip('Next month').last);
      await tester.pumpAndSettle();
      expect(find.text('May 2030'), findsOneWidget);
      expect(
        tester
            .widget<IconButton>(
              find.ancestor(
                of: find.byTooltip('Next month').last,
                matching: find.byType(IconButton),
              ),
            )
            .onPressed,
        isNull,
      );
    });

    testWidgets('strikes through unavailable days and refuses them', (
      tester,
    ) async {
      final selected = <DateTime>[];
      await tester.pumpWidget(
        _wrap(
          SizedBox(
            width: 390,
            child: AppDateRangeCalendar(
              firstDate: DateTime(2030, 3, 10),
              lastDate: DateTime(2030, 5, 31),
              onDaySelected: selected.add,
              unavailableDayPredicate: (day) => day.day == 20,
              unavailableDayLabel: 'Taken',
            ),
          ),
        ),
      );

      final taken = find.bySemanticsLabel('Wednesday, March 20, 2030');
      await tester.tap(taken);

      expect(selected, isEmpty);
      expect(
        tester.getSemantics(taken),
        isSemantics(
          value: 'Taken',
          isButton: true,
          hasEnabledState: true,
          isEnabled: false,
        ),
      );
      expect(
        tester.widget<Text>(find.text('20')).style?.decoration,
        TextDecoration.lineThrough,
      );
      expect(
        tester.widget<Text>(find.text('21')).style?.decoration,
        isNot(TextDecoration.lineThrough),
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Thursday, March 21, 2030')),
        isSemantics(value: '', isEnabled: true),
      );
    });

    testWidgets('shows days without offering them when read-only', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          SizedBox(
            width: 390,
            child: AppDateRangeCalendar(
              firstDate: DateTime(2030, 3, 10),
              lastDate: DateTime(2030, 5, 31),
              unavailableDayPredicate: (day) => day.day == 20,
              unavailableDayLabel: 'Taken',
            ),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.bySemanticsLabel('Thursday, March 21, 2030')),
        isSemantics(
          isButton: false,
          hasEnabledState: false,
          hasTapAction: false,
        ),
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Wednesday, March 20, 2030')),
        isSemantics(value: 'Taken', isButton: false),
      );

      final freeColor = tester.widget<Text>(find.text('21')).style?.color;
      final pastColor = tester.widget<Text>(find.text('9')).style?.color;
      expect(freeColor, isNot(pastColor));
    });

    testWidgets('keeps a full week on a narrow screen', (tester) async {
      await tester.pumpWidget(
        _wrap(
          SizedBox(
            width: 280,
            child: AppDateRangeCalendar(
              firstDate: DateTime(2030, 3, 1),
              lastDate: DateTime(2030, 3, 31),
              onDaySelected: (_) {},
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byType(PageView)).width,
        lessThanOrEqualTo(280),
      );
    });
  });

  group('AppIconButton', () {
    testWidgets('uses the tooltip as its accessible label', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppIconButton(icon: Icons.tune, tooltip: 'Filters', onPressed: () {}),
        ),
      );

      expect(find.byTooltip('Filters'), findsOneWidget);
      expect(
        tester.getSize(find.byType(IconButton)),
        const Size.square(AppIconButtonTokens.size),
      );
    });
  });

  group('AppBadge', () {
    testWidgets('renders a badge with the given label and colors', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          AppBadge(
            label: 'New',
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('New'));
      expect(text.style?.color, Colors.white);
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.blue);
    });
  });
}
