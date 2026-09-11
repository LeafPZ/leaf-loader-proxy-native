const std = @import("std");
const win = std.os.windows;

const java = @import("java");

extern "kernel32" fn AddDllDirectory(NewDirectory: win.PCWSTR) callconv(.winapi) *opaque {};

pub export fn Agent_OnLoad(_: [*c][*c]const java.struct_JNIInvokeInterface_, _: [*c]u8, _: ?*anyopaque) java.jint {
    std.debug.print("Agent loaded\n", .{});
    return java.JNI_OK;
}

pub export fn Agent_OnUnload() void {
    std.debug.print("Agent unloaded\n", .{});
}
