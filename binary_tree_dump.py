import gdb

'''
struct Node {
  Node *left, *right;
}
'''
class BinaryTreeDump(gdb.Command):
    """Prints the ListNode from our example in a nice format!"""

    def __init__(self):
        super(BinaryTreeDump, self).__init__("binary_tree_dump", gdb.COMMAND_USER)

    def complete(self, text, word):
        # We expect the argument passed to be a symbol so fallback to the
        # internal tab-completion handler for symbols
        return gdb.COMPLETE_SYMBOL

    def tranverse(self, node_ptr, level):
        if node_ptr:
            print(level * ' ' + 'x')
            self.tranverse(node_ptr['left'], level + 1)
            self.tranverse(node_ptr['right'], level + 1)

    def invoke(self, args, from_tty):
        # We can pass args here and use Python CLI utilities like argparse
        # to do argument parsing
        print("Args Passed: %s" % args)

        root_ptr = gdb.parse_and_eval(args)

        self.tranverse(root_ptr, 0)

BinaryTreeDump()
