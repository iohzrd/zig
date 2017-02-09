const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const io = @import("std").io;

const ET = enum {
    SINT: i32,
    UINT: u32,

    pub fn print(a: &const ET, buf: []u8) -> %usize {
        return switch (*a) {
            ET.SINT => |x| { io.bufPrintInt(buf, x, 10, false, 0) },
            ET.UINT => |x| { io.bufPrintInt(buf, x, 10, false, 0) },
        }
    }
};

fn enumWithMembers() {
    @setFnTest(this);

    const a = ET.SINT { -42 };
    const b = ET.UINT { 42 };
    var buf: [20]u8 = undefined;

    assert(%%a.print(buf) == 3);
    assert(mem.eql(buf[0...3], "-42"));

    assert(%%b.print(buf) == 2);
    assert(mem.eql(buf[0...2], "42"));
}
