// Jean Jacques Avril
// Autogenerated from Pigeon (v17.1.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol MethodChannelPigeon {
  func reverse(input: String) throws -> String
  func add(a: Int64, b: Int64) throws -> Int64
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class MethodChannelPigeonSetup {
  /// The codec used by MethodChannelPigeon.
  /// Sets up an instance of `MethodChannelPigeon` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: MethodChannelPigeon?) {
    let reverseChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.reverse", binaryMessenger: binaryMessenger)
    if let api = api {
      reverseChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let inputArg = args[0] as! String
        do {
          let result = try api.reverse(input: inputArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      reverseChannel.setMessageHandler(nil)
    }
    let addChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.pigeon_example_package.MethodChannelPigeon.add", binaryMessenger: binaryMessenger)
    if let api = api {
      addChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let aArg = args[0] is Int64 ? args[0] as! Int64 : Int64(args[0] as! Int32)
        let bArg = args[1] is Int64 ? args[1] as! Int64 : Int64(args[1] as! Int32)
        do {
          let result = try api.add(a: aArg, b: bArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addChannel.setMessageHandler(nil)
    }
  }
}
