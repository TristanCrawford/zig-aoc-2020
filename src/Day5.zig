const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const input = @embedFile("data/Day5.txt");

    var highest: usize = 0;

    var seat_idx: usize = 0;
    var seat_ids = [_]usize{0} ** 814;

    var toks = std.mem.tokenize(input, "\n");
    while (toks.next()) |line| {
        var row_lower: usize = 0;
        var row_upper: usize = 127;

        var col_lower: usize = 0;
        var col_upper: usize = 7;

        for (line) |char| {
            switch (char) {
                'F' => {
                    row_upper = @divFloor(row_upper - row_lower, 2) + row_lower;
                },
                'B' => {
                    row_lower = @divFloor(row_upper - row_lower, 2) + row_lower;
                },
                'L' => {
                    col_upper = @divFloor(col_upper - col_lower, 2) + col_lower;
                },
                'R' => {
                    col_lower = @divFloor(col_upper - col_lower, 2) + col_lower;
                },
                else => {},
            }
        }

        const seat = row_upper * 8 + col_upper;

        if (seat > highest)
            highest = seat;

        seat_ids[seat_idx] = seat;
        seat_idx += 1;
    }

    std.sort.sort(usize, &seat_ids, {}, comptime std.sort.asc(usize));

    var missing: usize = undefined;
    var prev_id: usize = seat_ids[0];

    for (seat_ids) |id| {
        const diff = id - prev_id;
        if (diff > 1) {
            missing = id - 1;
        }
        prev_id = id;
    }

    print("Highest: {d}\n", .{highest});
    print("Missing: {d}\n", .{missing});
}
