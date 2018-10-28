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
  int internalElements;

  AVLTree([this.item = null]) : right = null, left = null, height = -1, internalElements = 1;


  int _height(AVLTree tree) {
    return tree.height;
  }

  int _max(int x, int y) {
    return x > y ? x : y;
  }

  int _internalElements(AVLTree tree) {
    if(tree == null || tree?.item == null)return 0;
    return tree.internalElements;
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

    int leftElements = _internalElements(this.left);
    int rightElements = _internalElements(this.right);

    this.height = _max(leftHeight, rightHeight) + 1;
    this.internalElements = leftElements + rightElements + 1;
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
    root.internalElements = _internalElements(root.left) + _internalElements(root.right) + 1;
    newRoot.internalElements = _internalElements(newRoot.left) + _internalElements(newRoot.right) + 1;
    return newRoot;
  }

  AVLTree leftRotate(AVLTree root) {
    var newRoot = root.right;
    root.right = newRoot.left;
    newRoot.left = root;
    root.height = _max(_height(root.left), _height(root.right)) + 1;
    newRoot.height = _max(_height(newRoot.right), _height(newRoot.left)) + 1;
    root.internalElements = _internalElements(root.left) + _internalElements(root.right) + 1;
    newRoot.internalElements = _internalElements(newRoot.left) + _internalElements(newRoot.right) + 1;
    return newRoot;
  }


  void inorder() {
    if(this.item == null)return ;
    this.left.inorder();
    print("${this.item} Height: ${this.height} Internals: ${this.internalElements}");
    this.right.inorder();
  }

}

void main() {

  var root = AVLTree();
  var list = [3, 1, 2 ,4, 5, 6];
//  list.shuffle();
  print(list);
  list.forEach((item) => root = root.insert(Item(key: item, value: item)));
  root.inorder();
}