const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{ .default_target = .{ .os_tag = .windows, .cpu_arch = .x86_64 } });
    const optimize = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .ReleaseSmall,
    });

    const lib = b.addLibrary(.{
        .name = "leaf_loader_proxy_native",
        .linkage = .dynamic,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{},
        }),
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

    lib.root_module.addImport("java", java_trans.createModule());

    b.installArtifact(lib);
}
