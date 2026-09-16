const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{ .default_target = .{ .os_tag = .windows, .cpu_arch = .x86_64 } });
    const optimize = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .ReleaseSmall,
    });

    const java_trans = b.addTranslateC(.{
        .root_source_file = b.path("lib/java.h"),
        .target = target,
        .optimize = optimize,
    });

    if (b.graph.environ_map.get("JAVA_HOME")) |java_home| {
        java_trans.addIncludePath(.{ .cwd_relative = b.fmt("{s}/include", .{java_home}) });
    } else {
        std.log.warn("No JAVA_HOME environment variable specified. Zig may not be able to build against Java's include headers", .{});
    }

    const lib_mod = b.addModule("leaf_lodaer_proxy_native", .{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib_mod.addImport("java", java_trans.createModule());

    const lib = b.addLibrary(.{
        .name = "leaf_loader_proxy_native",
        .linkage = .dynamic,
        .root_module = lib_mod,
    });

    b.installArtifact(lib);

    const lib_check = b.addLibrary(.{
        .name = "leaf_loader_proxy_native",
        .linkage = .dynamic,
        .root_module = lib_mod,
    });

    const check = b.step("check", "Check if the library compiles");
    check.dependOn(&lib_check.step);
}
