import 'package:dart_narak/BSTree.dart';

void main() {
    var list = List.generate(11, (index) => index + 1);
    var tree = BSTree();
    list.shuffle();
    list.forEach((item) => tree.insert(Item(key: item,value: item)));
    print(tree.median());
}