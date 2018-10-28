import 'package:dart_narak/BSTree.dart';

void main() {
  var list = List.generate(10, (index) => index);
  var newList = List.generate(10, (index) => index + 10);

  var tree = BSTree();
  list.forEach((item) => tree.insert(Item(key: item,value: item)));
  print(tree.getAllItems().map((item) => item.key));

  var newTree = BSTree();
  newList.forEach((item) => newTree.insert(Item(key: item,value: item)));
  print(newTree.getAllItems().map((item) => item.key));

  tree.merge(newTree);
  print(tree.getAllItems().map((item) => item.key));
}