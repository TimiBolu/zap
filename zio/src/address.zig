const std = @import("std");
const zio = @import("../zio.zig");

pub const Address = struct {
    pub const Incoming = struct {
        inner: zio.backend.Incoming,

        pub fn new(address: Address) @This() {
            return @This() { .inner = zio.backend.Incoming.new(address) };
        }

        pub fn getSocket(self: @This()) zio.Socket {
            return zio.Socket { .inner = self.inner.getSocket() };
        }

        pub fn getAddressPtr(self: *const @This()) *const Address {
            return self.inner.getAddressPtr();
        }
    };

    length: c_int,
    sockaddr: zio.backend.SockAddr align(@alignOf(usize)),

    pub fn isIpv4(self: @This()) bool {
        return self.length == @sizeOf(zio.backend.SockAddr.Ipv4);
    }

    pub fn isIpv6(self: @This()) bool {
        return self.length == @sizeOf(zio.backend.SockAddr.Ipv6);
    }

    pub fn fromIpv4(address: u32, port: u16) @This() {
        return @This() {
            .length = @sizeOf(zio.backend.SockAddr.Ipv4),
            .sockaddr = zio.backend.SockAddr.fromIpv4(address, port),
        };
    }

    pub fn fromIpv6(address: u128, port: u16, flowinfo: u32, scope: u32) @This() {
        return @This() {
            .length = @sizeOf(zio.backend.SockAddr.Ipv6),
            .sockaddr = zio.backend.SockAddr.fromIpv6(address, port, flowinfo, scope),
        };
    }

    pub fn parseIpv4(input: []const u8) ?u32 {
        if (std.mem.eql(u8, input, "localhost"))
            return parseIpv4("127.0.0.1");

        var string = input;
        var result = u32(0);
        for ([_]void{{}} ** 4) {
            // TODO
        }
    }

    pub fn parseIpv6(input: []const u8) ?u128 { 
        return null; // TODO
    }
};