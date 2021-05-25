const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const input = @embedFile("data/Day5.txt");

    // const input =
    // \\BFFFBBFRRR
    // \\FFFBBBFRRR
    // \\BBFFBBFRLL
    // ;

    var toks = std.mem.tokenize(input, "\n");

    var highest: i32 = 0;

    while (toks.next()) |line| {
        var row_lower: usize = 0;
        var row_upper: usize = 127;

        var col_lower: usize = 0;
        var col_upper: usize = 7;

        var last_row: u8 = undefined;
        var last_col: u8 = undefined;

        for (line) |char| {
            switch (char) {
                'F' => {
                    row_upper = @divFloor(row_upper - row_lower, 2) + row_lower;
                    last_row = char;
                },
                'B' => {
                    row_lower = @divFloor(row_upper - row_lower, 2) + row_lower;
                    last_row = char;
                },
                'L' => {
                    col_upper = @divFloor(col_upper - col_lower, 2) + col_lower;
                    last_col = char;
                },
                'R' => {
                    col_lower = @divFloor(col_upper - col_lower, 2) + col_lower;
                    last_col = char;
                },
                else => {},
            }
        }

        const seat = row_upper * 8 + col_upper;

        if (seat > highest)
            highest = @intCast(i32, seat);

        // print("{s}\n", .{line});
        // print("Row: {d}..{d}\n", .{ row_lower, row_upper });
        // print("Col: {d}..{d}\n", .{ col_lower, col_upper });
        // print("Seat: {d}\n", .{seat});
    }

    print("Highest: {d}\n", .{highest});
}
