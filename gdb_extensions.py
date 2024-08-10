from gdb.printing import PrettyPrinter, register_pretty_printer
import gdb

class StringPrettyPrinter(object):
    def __init__(self, val):
        self.val = val

    def to_string(self):
        return "TODO: Implement"

class CustomPrettyPrinterLocator(PrettyPrinter):
    def __init__(self):
        super(CustomPrettyPrinterLocator, self).__init__(
            "my_pretty_printers", []
        )

    def __call__(self, val):
        typename = gdb.types.get_basic_type(val.type).tag
        if typename is None:
            typename = val.type.name

        if typename == "string":
            return StringPrettyPrinter(val)

register_pretty_printer(None, CustomPrettyPrinterLocator(), replace=True)
