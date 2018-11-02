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

  List preorder(SplayTree root) {
    if(root == null)return [];
    return [root.item] + root.preorder(root.left) + root.preorder(root.right);
  }

  List inorder(SplayTree root) {
    if(root == null) return [];
    return root.inorder(root.left) + [root.item] + root.inorder(root.right);
  }
}


