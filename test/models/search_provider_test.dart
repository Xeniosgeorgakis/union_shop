import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/search_provider.dart';

void main() {
  group('SearchProvider Tests', () {
    late SearchProvider searchProvider;

    setUp(() {
      searchProvider = SearchProvider();
    });

    test('should initialize with search visibility set to false', () {
      // Verify initial state
      expect(searchProvider.isSearchVisible, false);
    });

    test(
        'should set search visibility to true when setSearch is called with true',
        () {
      // Act
      searchProvider.setSearch(true);

      // Assert
      expect(searchProvider.isSearchVisible, true);
    });

    test(
        'should set search visibility to false when setSearch is called with false',
        () {
      // Arrange - first set it to true
      searchProvider.setSearch(true);
      expect(searchProvider.isSearchVisible, true);

      // Act - then set it to false
      searchProvider.setSearch(false);

      // Assert
      expect(searchProvider.isSearchVisible, false);
    });

    test('should toggle search visibility from false to true', () {
      // Initial state should be false
      expect(searchProvider.isSearchVisible, false);

      // Toggle to true
      searchProvider.setSearch(true);
      expect(searchProvider.isSearchVisible, true);
    });

    test('should toggle search visibility from true to false', () {
      // Set to true first
      searchProvider.setSearch(true);
      expect(searchProvider.isSearchVisible, true);

      // Toggle to false
      searchProvider.setSearch(false);
      expect(searchProvider.isSearchVisible, false);
    });

    test('should notify listeners when setSearch is called', () {
      // Arrange
      int listenerCallCount = 0;
      searchProvider.addListener(() {
        listenerCallCount++;
      });

      // Act
      searchProvider.setSearch(true);

      // Assert
      expect(listenerCallCount, 1);
      expect(searchProvider.isSearchVisible, true);
    });

    test(
        'should notify listeners multiple times when setSearch is called multiple times',
        () {
      // Arrange
      int listenerCallCount = 0;
      searchProvider.addListener(() {
        listenerCallCount++;
      });

      // Act
      searchProvider.setSearch(true);
      searchProvider.setSearch(false);
      searchProvider.setSearch(true);

      // Assert
      expect(listenerCallCount, 3);
      expect(searchProvider.isSearchVisible, true);
    });

    test(
        'should allow setting search visibility to the same value multiple times',
        () {
      // Arrange
      int listenerCallCount = 0;
      searchProvider.addListener(() {
        listenerCallCount++;
      });

      // Act - set to true multiple times
      searchProvider.setSearch(true);
      searchProvider.setSearch(true);
      searchProvider.setSearch(true);

      // Assert - listeners should be notified each time
      expect(listenerCallCount, 3);
      expect(searchProvider.isSearchVisible, true);
    });

    test('should maintain state correctly after multiple operations', () {
      // Perform multiple operations
      searchProvider.setSearch(true);
      expect(searchProvider.isSearchVisible, true);

      searchProvider.setSearch(false);
      expect(searchProvider.isSearchVisible, false);

      searchProvider.setSearch(true);
      expect(searchProvider.isSearchVisible, true);

      searchProvider.setSearch(false);
      expect(searchProvider.isSearchVisible, false);
    });

    test('should be able to remove listeners', () {
      // Arrange
      int listenerCallCount = 0;
      void listener() {
        listenerCallCount++;
      }

      searchProvider.addListener(listener);

      // Act - call setSearch with listener attached
      searchProvider.setSearch(true);
      expect(listenerCallCount, 1);

      // Remove listener
      searchProvider.removeListener(listener);

      // Call setSearch again
      searchProvider.setSearch(false);

      // Assert - listener should not be called after removal
      expect(listenerCallCount, 1); // Still 1, not 2
      expect(searchProvider.isSearchVisible, false);
    });

    test('should handle multiple listeners correctly', () {
      // Arrange
      int listener1CallCount = 0;
      int listener2CallCount = 0;

      searchProvider.addListener(() {
        listener1CallCount++;
      });

      searchProvider.addListener(() {
        listener2CallCount++;
      });

      // Act
      searchProvider.setSearch(true);

      // Assert - both listeners should be called
      expect(listener1CallCount, 1);
      expect(listener2CallCount, 1);
      expect(searchProvider.isSearchVisible, true);
    });

    test('should not throw error when setSearch is called with no listeners',
        () {
      // Act & Assert - should not throw
      expect(() => searchProvider.setSearch(true), returnsNormally);
      expect(searchProvider.isSearchVisible, true);
    });

    test('should properly dispose without errors', () {
      // Arrange
      searchProvider.setSearch(true);

      // Act & Assert - should not throw
      expect(() => searchProvider.dispose(), returnsNormally);
    });

    test('should work correctly in a typical use case scenario', () {
      // Simulate typical usage: user clicks search icon
      int uiUpdateCount = 0;

      searchProvider.addListener(() {
        uiUpdateCount++;
      });

      // User opens search
      searchProvider.setSearch(true);
      expect(searchProvider.isSearchVisible, true);
      expect(uiUpdateCount, 1);

      // User closes search
      searchProvider.setSearch(false);
      expect(searchProvider.isSearchVisible, false);
      expect(uiUpdateCount, 2);

      // User opens search again
      searchProvider.setSearch(true);
      expect(searchProvider.isSearchVisible, true);
      expect(uiUpdateCount, 3);
    });
  });
}
