const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;

test "create file , write, seek to, read" {
    const file = try std.fs.cwd().createFile(
        "junk_file.txt",
        .{ .read = true }
    );
    defer file.close();

    const bytes_written = try file.writeAll("Hello World");

    _ = bytes_written;

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

    try expect(eql(u8, buffer[0..bytes_read], "Hello World"));
}

test "file stat" {
    const file = try std.fs.cwd().createFile(
        "junk_file2.txt",
        .{ .read = true }
    );

    defer file.close();

    const stat = try file.stat();

    try expect(stat.size == 0);
    try expect(stat.kind == .File);
    try expect(stat.ctime <= std.time.nanoTimestamp());
    try expect(stat.mtime <= std.time.nanoTimestamp());
    try expect(stat.atime <= std.time.nanoTimestamp());
}
