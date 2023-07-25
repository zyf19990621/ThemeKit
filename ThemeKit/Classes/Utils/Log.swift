//
//  Log.swift
//  ThemeKit
//
//  Created by did on 2022/11/11.
//

import Foundation

public extension Theme {

    enum Log { }
}

public extension Theme.Log {

    enum Level {
        case info, error
    }

    typealias Output = (_ level: Level, _ message: String, _ scope: String, _ file: StaticString, _ line: Int) -> Void

    static func output(_ output: @escaping Output) {
        _output.value = output
    }

    @inlinable
    static func i(_ message: String, in scope: String, file: StaticString = #file, line: Int = #line) {
        log(.info, message: message, scope: scope, file: file, line: line)
    }

    @inlinable
    static func e(_ message: String, in scope: String, file: StaticString = #file, line: Int = #line) {
        log(.error, message: message, scope: scope, file: file, line: line)
    }

    @inlinable
    static func log(_ level: Level, message: String, scope: String, file: StaticString = #file, line: Int = #line) {
        _output.value?(level, message, scope, file, line)
    }

    @usableFromInline
    internal static let _output: Atom<Output?> = .init(nil)
}

internal typealias Log = Theme.Log


// MARK: - Atom

@usableFromInline
internal final class Atom<Value> {

    @inlinable
    var value: Value {
        get { _lock { _value } }
        set { _lock { _value = newValue }}
    }

    @inlinable
    @discardableResult
    func with<T>(_ body: (inout Value) throws -> T) rethrows -> T {
        try _lock { try body(&_value) }
    }

    init(_ value: Value) {
        _value = value
    }

    @usableFromInline
    internal var _value: Value
    @usableFromInline
    internal let _semaphore = DispatchSemaphore(value: 1)
}

internal extension Atom {

    @usableFromInline
    @discardableResult
    func _lock<T>(_ body: () throws -> T) rethrows -> T {
        _semaphore.wait(); defer { _semaphore.signal() }
        return try body()
    }
}
