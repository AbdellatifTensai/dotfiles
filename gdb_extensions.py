from gdb.printing import PrettyPrinter, register_pretty_printer
import gdb

class StringPrettyPrinter:
    def __init__(self, val):
        self.val = val

    def to_string(self):
        return "".join(["'", self.val["Data"].string(length=self.val["Length"]), "'"])

class NodePrettyPrinter:
    def __init__(self, val):
        self.val = val
        self.node_types = gdb.lookup_type("node_type")

    def to_string(self):
        node_type = self.val["NodeType"]
        if node_type == self.node_types["NODE_TYPE_NUM"].enumval:
            return str(self.val["Num"])
        else:
            # return "".join(["'", self.val["Op"]["Data"].string(length=self.val["Op"]["Length"]), "'"])
            return StringPrettyPrinter(self.val["Op"]).to_string()

class VectorPrettyPrinter:
    def __init__(self, val):
        self.val = val

    def to_string(self):
        return f"( {self.val['x']}, {self.val['y']} )"


class CustomPrettyPrinterLocator(PrettyPrinter):
    def __init__(self):
        super(CustomPrettyPrinterLocator, self).__init__(
            "my_pretty_printers", []
        )

    def __call__(self, val):
        typename = gdb.types.get_basic_type(val.type).tag
        if typename is None:
            typename = val.type.name

        if typename == "str8":
            return StringPrettyPrinter(val)
        elif typename == "str8_buff32":
            return StringPrettyPrinter(val)
        elif typename == "node":
            return NodePrettyPrinter(val)
        elif typename == "v2i":
            return VectorPrettyPrinter(val)

register_pretty_printer(None, CustomPrettyPrinterLocator(), replace=True)
