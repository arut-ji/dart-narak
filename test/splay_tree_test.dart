import 'package:test/test.dart';
import 'package:dart_narak/SplayTree.dart';

void main() {

  test('Tree init', () {
    SplayTree root = SplayTree();
    expect(root.item, null);
  });

  test('Tree insertion', () {
    SplayTree root = SplayTree();
    root = root.insert(root, 3);
    expect(root.item, 3);
  });

  test('Tree nodes insertion', () {
    SplayTree root = SplayTree();
    root = root.insert(root, 3);
    root = root.insert(root, 10);
    root = root.insert(root, 4);
    root = root.insert(root, 11);
    expect(root.preorder(root), [11, 10, 4, 3]);
  });

  test('Tree nodes removal', () {
    SplayTree root = SplayTree();
    root = root.insert(root, 3);
    root = root.insert(root, 10);
    root = root.insert(root, 4);
    root = root.insert(root, 11);

    root = root.remove(root, 3);
    expect(root.preorder(root), [10, 4, 11]);
  });

  test('Tree key searching with key found', () {
    SplayTree root = SplayTree();
    root = root.insert(root, 3);
    root = root.insert(root, 10);
    root = root.insert(root, 4);
    root = root.insert(root, 11);

    root = root.search(root, 3);
    expect(root.item, 3);
  });

  test('Tree key searching with key not found', () {
    SplayTree root = SplayTree();
    root = root.insert(root, 3);
    root = root.insert(root, 10);
    root = root.insert(root, 4);
    root = root.insert(root, 11);

    root = root.search(root, 7);
    expect(root.item, 10);
  });
}
