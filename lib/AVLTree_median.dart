import 'package:dart_narak/AVLTree.dart';

void main() {

  var root = AVLTree();
//  var list = [3, 1, 2 ,4, 5, 6];
  var list = List.generate(100, (index) => index + 1);
//  list.shuffle();
  print(list);
  list.forEach((item) => root = root.insert(Item(key: item, value: item)));
//  root.inorder();
  print(median(root));


}