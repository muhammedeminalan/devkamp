import 'package:app/features/home/presentation/view/home_view.dart';
import 'package:app/features/profile/presentation/view/profile_view.dart';
import 'package:app/features/saved/presentation/view/saved_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HomeView widget olusturulur', () {
    const Widget view = HomeView();
    expect(view, isA<HomeView>());
  });

  test('SavedView widget olusturulur', () {
    const Widget view = SavedView();
    expect(view, isA<SavedView>());
  });

  test('ProfileView widget olusturulur', () {
    const Widget view = ProfileView();
    expect(view, isA<ProfileView>());
  });
}
