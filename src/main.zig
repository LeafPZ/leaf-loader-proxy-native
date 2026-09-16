const std = @import("std");
const win = std.os.windows;

const java = @import("java");

const W = std.unicode.utf8ToUtf16LeStringLiteral;

extern "kernel32" fn SetDllDirectoryW(lpPathName: ?win.LPCSTR) callconv(.winapi) win.BOOL;

extern "user32" fn MessageBoxW(hWnd: ?win.HWND, lpText: ?win.LPCWSTR, lpCaption: ?win.LPCWSTR, uType: win.UINT) callconv(.winapi) c_int;

pub export fn Agent_OnLoad(_: [*c][*c]const java.struct_JNIInvokeInterface_, options: [*c]u8, _: ?*anyopaque) java.jint {
    var ret: win.BOOL = win.BOOL.FALSE;
    if (options != null and std.mem.len(options) != 0) {
        ret = SetDllDirectoryW(options);
    } else {
        ret = SetDllDirectoryW(".\\jre64\\bin");
    }

    if (ret == win.BOOL.FALSE) {
        std.log.info("Failed to add DLL directory '{s}'", .{options});
        _ = MessageBoxW(null, W("Agent failed to add the dll directory"), W("Leaf Native"), 0);
        return java.JNI_ERR;
    }

    std.log.info("Agent loaded\n", .{});
    return java.JNI_OK;
}

pub export fn Agent_OnUnload() void {
    std.log.info("Agent unloaded\n", .{});
}
