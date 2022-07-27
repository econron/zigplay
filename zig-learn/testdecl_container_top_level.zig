const std = @import("std");
const expect = std.testing.expect;

const imported_file = @import("introducing_zig_test.zig");

test {
    std.testing.refAllDecls(@This());

    _ = S;
    _ = U;
    _ = @import("introducing_zig_test.zig");
}

const S = struct {
    // 利用されてないものはテストされない
    se: SE,

    test "S demo test" {
        try expect(true);
    }

    const SE = enum {
        V,

        test "This Test Won't run" {
            try expect(true);
        }
    };
};

const U = union {
    s: US,
    const US = struct {
        test "U.US demo test" {
            try expect(true);
        }
    };

    test "U demo test" {
        try expect(true);
    }
};

test "this will be skipped" {
    return error.SkipZigTest;
}

test "async skip test" {
    var frame = async func();
    const result = await frame;
    try std.testing.expect(result == 1);
}

fn func() i32 {
    suspend {
        resume @frame();
    }
    return 1;
}

// report memory leaks
test "detect leak" {
    var list = std.ArrayList(u21).init(std.testing.allocator);
    try list.append('☔');
    try std.testing.expect(list.items.len == 1);
}

const builtin = @import("builtin");

test "builtin.is_test" {
    try expect(isATest());
}

fn isATest() bool {
    return builtin.is_test;
}