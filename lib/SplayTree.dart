import 'dart:io';

class SplayTree {
  dynamic item;
  SplayTree left, right;

  SplayTree([item = null]): left = null, right = null, item = item;

  SplayTree _leftRotate(SplayTree root) {
    SplayTree newRoot = root.right;
    root.right = newRoot.left;
    newRoot.left = root;
    return newRoot;
  }

  SplayTree _rightRotate(SplayTree root) {
    SplayTree newRoot = root.left;
    root.left = newRoot.right;
    newRoot.right = root;
    return newRoot;
  }

  SplayTree _splay(SplayTree root, dynamic item) {
    if(root?.item == null || root.item == item)
      return root;

    //    Item is in the left subtree
    if(root.item > item) {

      //    Item is not in the tree
      if(root.left == null) return root;

      //    Zig-Zig
      if(root.left.item > item) {

        root.left.left = _splay(root.left.left, item);
        root = _rightRotate(root);


      }
      //        Zig-Zag
      else if(root.left.item < item) {
        root.left.right = _splay(root.left.right, item);
        if(root.left.right != null) {
          root.left = _leftRotate(root.left);
        }

      }

      return (root.left == null) ? root : _rightRotate(root);

    }

    //    Item is in the right subtree
    else if(root.item < item){

      if(root.right == null) return root;

      //      Zag-Zig
      if(root.right.item > item) {

        root.right.left = _splay(root.right.left, item);
        if(root.right.left != null)root.right = _rightRotate(root.right);

      }

      //      Zag-Zag
      else if(root.right.item < item){
        root.right.right = _splay(root.right.right, item);
        root = _leftRotate(root);
      }

      return (root.right == null) ? root : _leftRotate(root);
    }

    return root;
  }

  SplayTree search(SplayTree root, dynamic item) {
    return _splay(root, item);
  }

  SplayTree insert(SplayTree root, dynamic item) {
    if(root.item == null) {
      root.item = item;
      return root;
    }

    root = _splay(root, item);

    if(root.item == item) return root;

    var newNode = SplayTree(item);

    if(root.item > item) {
      newNode.right = root;
      newNode.left = root.left;
      root.left = null;
    } else {
      newNode.left = root;
      newNode.right = root.right;
      root.right= null;
    }

    return newNode;
  }

  SplayTree remove(SplayTree root, dynamic item) {
    root = _splay(root, item);

    if(root.item != item) {
      throw Exception('Key not found');
    }

    if(root.left == null)return root.right;
    else {
      var newnode = root.right;
      root = root.left;
      root = _splay(root, item);
      root.right = newnode;
      return root;
    }
  }

  void preorder(SplayTree root) {
    if(root == null)return;
    stdout.write('${root.item} ');
    root.preorder(root.left);
    root.preorder(root.right);
  }

}

main() {
  SplayTree root = SplayTree();
  root = root.insert(root, 3);
  root = root.insert(root, 10);
  root = root.insert(root, 4);
  root = root.insert(root, 11);
  
  root = root.search(root, 3);
  print('Search for 3: ${root.item == 3 ? 3 : 'Not Found'} ');
  root.preorder(root);
  print('');
  root = root.insert(root, 8);
  root = root.insert(root, 5);
  root = root.insert(root, 6);

  root = root.search(root, 7);
  print('Search for 7: ${root.item == 7 ? 7 : 'Not Found'}');

  root.preorder(root);
  print('');

  print('Remove 10:');
  root = root.remove(root, 10);
  root.preorder(root);
  print('');

  root = root.search(root, 5);
  print('Search for 5: ${root.item == 5 ? 5 : 'Not Found'}');
  root.preorder(root);
  print('');
  print('Remove 5:');
  root = root.remove(root, 5);
  root.preorder(root);
  print('');

}


