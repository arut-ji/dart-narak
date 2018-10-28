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

class BSTree {
  Item item;
  BSTree left, right;

  BSTree([this.item]): left = null, right = null;

  void insert(Item item) {
    if(this.item == null) {
      this.item = item;
      this.left = BSTree();
      this.right = BSTree();
      return ;
    }

    if(item.key < this.item.key) this.left.insert(item);
    else if(item.key > this.item.key) this.right.insert(item);
  }

  List getAllItems() {
    if(this.item == null) return [];
    return this.left.getAllItems() + [this.item] + this.right.getAllItems();
  }

  Item median() {
    var items = this.getAllItems();
    return items[items.length ~/ 2];
  }

  void merge(BSTree tree) {
    var list = tree.getAllItems();
    list.forEach((item) => this.insert(item));
  }

  void inorder() {
    if(this.item == null)return;
    this.left.inorder();
    print(this.item);
    this.right.inorder();
  }

}