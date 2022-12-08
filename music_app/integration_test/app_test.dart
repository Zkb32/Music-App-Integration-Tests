import 'dart:ffi';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_app/core/utils.dart';
import 'package:music_app/main.dart' as app;
import 'package:music_app/presentation/pages/search_page.dart';
import 'package:music_app/presentation/widgets/album_widget.dart';
import 'package:music_app/presentation/widgets/state_widget.dart';

//Test Data
var textFieldItem="Alexandra";
var scrollerSearchableItem="Lorez Alexandria";
var scrollerSearchableItemSecond="Only Happy";
var albumScreen="Album";
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Music App testing',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();
          //Find search Icon
          final Finder searchIcon = find.byIcon(Icons.search);
          //Tap on search Icon
          await tester.tap(searchIcon);
          await tester.pumpAndSettle();
          //Find Text Field and enter test data
          await tester.enterText(find.byType(TextField), textFieldItem);
          await tester.pumpAndSettle();
          //Tap on search Icon
          await tester.tap(searchIcon);
          await tester.pumpAndSettle();
          //Find Grid View
          var gridView=find.byType(GridView);
          //Make sure grid view is shown
          expect(gridView, findsOneWidget);
          // Scroll test until specific value
          await tester.dragUntilVisible(find.text(scrollerSearchableItem), gridView, const Offset(0, -100));
         //Verification that scroll works and value appears
          expect(find.text(scrollerSearchableItem), findsOneWidget);
          await tester.pumpAndSettle();
          // Find next page card button
          final Finder cardBtn=find.text(scrollerSearchableItem);
          // Tap on Card button
          await tester.tap(cardBtn);
          await tester.pumpAndSettle();
          //Scroll test on next screen
          await tester.dragUntilVisible(find.text(scrollerSearchableItemSecond), gridView, const Offset(0, -100));
          await tester.pumpAndSettle();
          // Find card on next screen
          final Finder secondaryCardBtn=find.text(scrollerSearchableItemSecond);
          //Tap on card button
          await tester.tap(secondaryCardBtn);
          await tester.pumpAndSettle();
          //Make sure album screen appears after tapping
          expect(find.text(albumScreen), findsOneWidget);
          //Find and tap on back button
          await tester.tap(find.byIcon(Icons.arrow_back));
          await tester.pumpAndSettle();
          //Find favorite button and tap on last item favorite button
          await tester.tap(find.byType(FavoriteButton).last);
          await tester.pumpAndSettle();

        });
  });
}




