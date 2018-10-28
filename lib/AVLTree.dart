

class Item {
  int key;
  dynamic value;
  Item({this.key, this.value});

  bool operator==(other) {
    return this.key == other.key;
  }

  bool operator<(other) {
    return this.key < other.key;
  }

  bool operator>(other) {
    return this.key > other.key;
  }

  bool operator<=(other) {
    return this.key < other.key || this == other;
  }

  bool operator>=(other) {
    return this.key > other.key || this == other;
  }

  @override
  String toString() {
    return 'Item{key: $key, value: $value}';
  }


}

class AVLTree {
  Item item;
  AVLTree left, right;
  int height;
  int children;

  AVLTree([this.item = null]) : right = null, left = null, height = -1, children = 1;


  int _height(AVLTree tree) {
    return tree.height;
  }

  int _max(int x, int y) {
    return x > y ? x : y;
  }

  int _children(AVLTree tree) {
    if(tree == null || tree?.item == null)return 0;
    return tree.children;
  }

  AVLTree insert(Item item) {
    if(this.item == null) {
      this.item = item;
      this.left = AVLTree();
      this.right = AVLTree();
      this.height = 0;
      return this;
    }

    if(this.item < item) {
      this.right  = this.right.insert(item);
    }
    else if(this.item > item) {
      this.left = this.left.insert(item);
    }

    int leftHeight = _height(this.left);
    int rightHeight = _height(this.right);

    int leftElements = _children(this.left);
    int rightElements = _children(this.right);

    this.height = _max(leftHeight, rightHeight) + 1;
    this.children = leftElements + rightElements + 1;
    int balance = leftHeight - rightHeight;

    if(balance > 1) {
      if(_height(this.left.left) >= _height(this.left.right)) {
        return rightRotate(this);
      } else {
        this.left = leftRotate(this.left);
        return rightRotate(this);
      }
    } else if(balance < -1) {
      if(_height(this.right.right) >= _height(this.right.left)) {
        return leftRotate(this);
      } else {
        this.right = rightRotate(this.right);
        return leftRotate(this);
      }
    }
    return this;
  }

  AVLTree rightRotate(AVLTree root) {
    var newRoot = root.left;
    root.left = newRoot.right;
    newRoot.right = root;
    root.height = _max(_height(root.left), _height(root.right)) + 1;
    newRoot.height = _max(_height(newRoot.right), _height(newRoot.left)) + 1;
    root.children = _children(root.left) + _children(root.right) + 1;
    newRoot.children = _children(newRoot.left) + _children(newRoot.right) + 1;
    return newRoot;
  }

  AVLTree leftRotate(AVLTree root) {
    var newRoot = root.right;
    root.right = newRoot.left;
    newRoot.left = root;
    root.height = _max(_height(root.left), _height(root.right)) + 1;
    newRoot.height = _max(_height(newRoot.right), _height(newRoot.left)) + 1;
    root.children = _children(root.left) + _children(root.right) + 1;
    newRoot.children = _children(newRoot.left) + _children(newRoot.right) + 1;
    return newRoot;
  }

  void inorder() {
    if(this.item == null)return ;
    this.left.inorder();
    print("${this.item} Height: ${this.height} Internals: ${this.children}");
    this.right.inorder();
  }

  Item median(int k) {
//    print("${this.item}");
    if(k == _children(this.left) + 1) 
      return this.item;
    else if(k <= _children(this.left))
      return this.left.median(k);
    else 
      return this.right.median(k - _children(this.left) - 1);
  }

}

Item median(AVLTree tree) {
  int nodes = tree.children;
  return tree.median((nodes / 2).ceil());
}



