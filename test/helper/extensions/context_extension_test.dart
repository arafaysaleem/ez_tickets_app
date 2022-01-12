import 'package:ez_ticketz_app/helper/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'context_extension_test.mocks.dart';

@GenerateMocks([BuildContext])
void main() {
  group('ContextUtils', () {
    group('extensions related to MediaQuery', () {
      BuildContext _mockContextWithMediaQuery(Size size) {
        final context = MockBuildContext();
        final mediaQuery = MediaQuery(
          data: MediaQueryData(size: size),
          child: const SizedBox.shrink(),
        );
        when(context.widget).thenReturn(const SizedBox.shrink());
        when(context.findAncestorWidgetOfExactType()).thenReturn(mediaQuery);
        when(context.dependOnInheritedWidgetOfExactType<MediaQuery>())
            .thenReturn(mediaQuery);
        when(context.getElementForInheritedWidgetOfExactType<MediaQuery>())
            .thenReturn(mediaQuery.createElement());
        return context;
      }

      group('screenWidth', () {
        test(
          'GIVEN a Size created with a screen width '
          'AND a BuildContext with MediaQuery '
          'AND that MediaQuery has that Size '
          'WHEN extension method `.screenWidth` is called '
          'THEN a double is returned '
          'AND is equal to that screen width',
          () {
            //given
            const screenWidth = 500.0;
            const size = Size.fromWidth(screenWidth);
            final context = _mockContextWithMediaQuery(size);

            //when
            final actual = context.screenWidth;

            //then
            expect(actual, isA<double>());
            expect(actual, screenWidth);
          },
        );
      });

      group('screenHeight', () {
        test(
          'GIVEN a Size created with a screen height '
          'AND a BuildContext with MediaQuery '
          'AND that MediaQuery has that Size '
          'WHEN extension method `.screenHeight` is called '
          'THEN a double is returned '
          'AND is equal to that screen height',
          () {
            //given
            const screenHeight = 650.0;
            const size = Size.fromHeight(screenHeight);
            final context = _mockContextWithMediaQuery(size);

            //when
            final actual = context.screenHeight;

            //then
            expect(actual, isA<double>());
            expect(actual, screenHeight);
          },
        );
      });
    });
  });
}
