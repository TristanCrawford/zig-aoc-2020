const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const input = @embedFile("data/Day6.txt");

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var map = std.AutoHashMap(u8, u32).init(&gpa.allocator);
    defer map.deinit();

    var count: u32 = 0;
    var lines = std.mem.split(input, "\r\n");
    while (lines.next()) |line| {
        if (line.len == 0) {
            map.clearAndFree();
        }

        for (line) |q| {
            if (q == '\r') continue;
            const prev = map.get(q) orelse blk: {
                count += 1;
                break :blk 0;
            };
            map.put(q, prev + 1) catch {};
        }
    }

    print("{d}\n", .{count});
}
