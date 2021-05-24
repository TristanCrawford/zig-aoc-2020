const std = @import("std");
const print = std.debug.print;

fn checkByr(value: []const u8) bool {
    const num = std.fmt.parseInt(i32, value[0..], 10) catch |err| {
        return false;
    };

    return (num >= 1920 and num <= 2002);
}

fn checkIyr(value: []const u8) bool {
    const num = std.fmt.parseInt(i32, value[0..], 10) catch |err| {
        return false;
    };

    return (num >= 2010 and num <= 2020);
}

fn checkEyr(value: []const u8) bool {
    const num = std.fmt.parseInt(i32, value[0..], 10) catch |err| {
        return false;
    };

    return (num >= 2020 and num <= 2030);
}

fn checkHgt(value: []const u8) bool {
    var idx = std.mem.indexOf(u8, value, "cm") orelse 0;
    if (idx == 0) idx = std.mem.indexOf(u8, value, "in") orelse return false;

    const num = std.fmt.parseInt(i32, value[0..idx], 10) catch |err| {
        return false;
    };

    const checkCm = (value[idx] == 'c' and (num >= 150 and num <= 193));
    const checkIn = (value[idx] == 'i' and (num >= 59 and num <= 76));

    return checkCm or checkIn;
}

fn checkHcl(value: []const u8) bool {
    if (value[0] == '#') {
        for (value[1..]) |char| {
            const isNum = (char >= '0' and char <= '9');
            const isAlpha = (char >= 'a' and char <= 'f');
            if (!isNum and !isAlpha) {
                return false;
            }
        }
    } else {
        return false;
    }

    return true;
}

pub fn checkEcl(value: []const u8) bool {
    return (std.mem.eql(u8, value, "amb") or
        std.mem.eql(u8, value, "blu") or
        std.mem.eql(u8, value, "brn") or
        std.mem.eql(u8, value, "gry") or
        std.mem.eql(u8, value, "grn") or
        std.mem.eql(u8, value, "hzl") or
        std.mem.eql(u8, value, "oth"));
}

pub fn checkPid(value: []const u8) bool {
    return (value.len == 9);
}

pub fn main() !void {
    const input_buf = @embedFile("data/Day4.txt");

    // Part 2
    {
        var toks = std.mem.tokenize(input_buf, " \n");
        var valid: i32 = 0;
        var count: i32 = 0;

        while (toks.next()) |tok| {
            // print("Token: {s}\n", .{tok});

            if (tok[0] == '\r') {
                // print("New Entry!\n", .{});

                if (count >= 7)
                    valid += 1;

                count = 0;
                continue;
            }

            var map = std.mem.tokenize(tok, ":");

            var key = map.next() orelse continue;
            var value = map.next() orelse continue;

            if (value[value.len - 1] == '\r') {
                value = value[0 .. value.len - 1];
            }

            if (std.mem.eql(u8, key, "byr")) {
                if (checkByr(value)) {
                    count += 1;
                }
            } else if (std.mem.eql(u8, key, "iyr")) {
                if (checkIyr(value)) {
                    count += 1;
                }
            } else if (std.mem.eql(u8, key, "eyr")) {
                if (checkEyr(value)) {
                    count += 1;
                }
            } else if (std.mem.eql(u8, key, "hgt")) {
                if (checkHgt(value)) {
                    count += 1;
                }
            } else if (std.mem.eql(u8, key, "hcl")) {
                if (checkHcl(value)) {
                    count += 1;
                }
            } else if (std.mem.eql(u8, key, "ecl")) {
                if (checkEcl(value)) {
                    count += 1;
                }
            } else if (std.mem.eql(u8, key, "pid")) {
                if (checkPid(value)) {
                    count += 1;
                }
            }
        }

        print("Result: {d}\n", .{valid});
    }
}
