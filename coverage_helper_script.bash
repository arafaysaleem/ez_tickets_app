#!/bin/bash

file=test/coverage_helper_test.dart
echo "/// *** GENERATED FILE - ANY CHANGES WOULD BE OBSOLETE ON NEXT GENERATION *** ///\n" > $file
echo "// Helper file to make coverage work for all dart files\n" > $file
echo "// ignore_for_file: unused_import" >> $file
packageName="$(cat pubspec.yaml| grep '^name: ' | awk '{print $2}')"
find lib '!' -path '*generated*/*' '!' -name '*.g.dart' '!' -name '*.freezed.dart' '!' -name '*.gr.dart' '!' -name '*.part.dart' '!' -name '*.mocks.dart' -name '*.dart' | cut -c4- | awk -v package="$packageName" '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $file
echo "\nvoid main(){}" >> $file