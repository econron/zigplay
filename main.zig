const std = @import("std");

pub fn main() void{
    // const msg = "Hello World";
    // var it = std.mem.tokenize(u8, msg, " ");
    // while(it.next()) |item|{
    //     std.debug.print("{s}\n", .{item});
    // }
    const file = std.fs.cwd().openFile("does_not_exist/foo.txt", .{}) catch |err| label: {
        std.debug.print("unable to open file: {e}\n", .{err});
        const stderr = std.io.getStdErr();
        break: label stderr;
    };
    file.writeAll("all your codebase are belong to us\n") catch return;
}