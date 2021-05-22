const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    var exe_path: [std.fs.MAX_PATH_BYTES:0]u8 = undefined;
    var dir_path = try std.fs.selfExeDirPath(&exe_path);

    var input_path: [std.fs.MAX_PATH_BYTES:0]u8 = undefined;
    _ = try std.fmt.bufPrint(&input_path, "{s}{s}", .{ dir_path, "\\Day4.txt" });

    var input = try std.fs.openFileAbsoluteZ(&input_path, .{});

    var input_buf: [24000]u8 = undefined;
    var bytes_read = try input.readAll(&input_buf);

    print("Bytes Read: {d}\n", .{bytes_read});

    // Part 1
    {
        var toks = std.mem.tokenize(&input_buf, " \n");
        var valid: i32 = 0;
        var count: i32 = 0;

        while (toks.next()) |tok| {
            // print("--------\nToken: {s}\n", .{tok});

            if (tok[0] == '\r') {
                if (count >= 7)
                    valid += 1;
                count = 0;
            } else if (std.mem.startsWith(u8, tok, "byr") or
                std.mem.startsWith(u8, tok, "iyr") or
                std.mem.startsWith(u8, tok, "eyr") or
                std.mem.startsWith(u8, tok, "hgt") or
                std.mem.startsWith(u8, tok, "hcl") or
                std.mem.startsWith(u8, tok, "ecl") or
                std.mem.startsWith(u8, tok, "pid"))
            {
                count += 1;
            }
        }

        print("Result: {d}\n", .{valid});
    }
}
