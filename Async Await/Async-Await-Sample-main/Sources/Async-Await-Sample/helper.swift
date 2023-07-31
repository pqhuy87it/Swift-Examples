//
//  File.swift
//  
//
//  Created by Takahiro Nishinobu on 2022/04/27.
//

import Foundation

enum MyError: Error {
    case e1
    case e2
}

func sleep(seconds: Int = 1) async throws {
    print("start " + #function.debugDescription)
    try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    print("end " + #function.debugDescription)
}

func cancelHandleSleep(seconds: Int = 1) async throws {
    print("start " + #function.debugDescription)
    try await withTaskCancellationHandler {
        try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    } onCancel: {
        print("operation cancel!!!")
    }
    print("start " + #function.debugDescription)
}

func outputInt(num: Int) async -> Int {
    print("outputInt")
    return num
}

func outputIntArray() async throws -> [Int] {
    print("start " + #function.debugDescription)
    try await Task.sleep(nanoseconds: 2_000_000_000)
    print("outputIntArray sleep finish")
    return [1, 2, 3, 4]
}

func throwsE1() throws {
    throw MyError.e1
}

func throwsE1() async throws {
    try await sleep(seconds: 1)
    throw MyError.e1
}

func throwsE2() async throws {
    try await sleep(seconds: 2)
    throw MyError.e2
}

func outputIntAsyncStream() -> AsyncStream<Int> {
    .init { continuation in
        continuation.yield(0)
        continuation.yield(1)
        continuation.yield(2)
        continuation.yield(3)
        continuation.finish()
        // 以降は流れてこない
        continuation.yield(4)
        continuation.yield(5)
        continuation.finish()
    }
}

func outputIntAsyncThrowingStream() -> AsyncThrowingStream<Int, Error> {
    .init { continuation in
        continuation.yield(0)
        continuation.yield(1)
        continuation.yield(2)
        continuation.finish(throwing: MyError.e1)
    }
}

func outputIntSleepSerialAsyncStream() -> AsyncStream<Int> {
    .init { continuation in
        Task {
            for num in [3, 2, 1] {
                // この中は直列に走るので全てが終わるまで6秒かかる
                try! await sleep(seconds: num)
                continuation.yield(num)
            }
            continuation.finish()
        }
    }
}

func fetchAsyncStreamImageData() -> AsyncThrowingStream<Data, Error> {
    .init { continuation in
        Task {
            let imageURL = URL(string: "https://source.unsplash.com/random")!
            // この書き方だと直列に処理される
            for num in [1, 2, 3] {
                do {
                    let (data, _) = try await URLSession.shared.data(from: imageURL)
                    print("num: " + num.description)
                    continuation.yield(data)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}

func outputIntSleepParallelAsyncStream() -> AsyncStream<Int> {
    .init { continuation in
        Task {
            // 並列に走らせるにはasync let もしくはwithTaskGroupを使う
            await withTaskGroup(of: Void.self) { group in
                [3, 2, 1].forEach { num in
                    group.addTask {
                        let imageURL = URL(string: "https://source.unsplash.com/random")!
                        let (data, _) = try! await URLSession.shared.data(from: imageURL)
//                        try! await sleep(seconds: num)
                        print("num: " + num.description + data.description)
                        continuation.yield(num)
                    }
                }
            }
            continuation.finish()
        }
    }
}

func asyncStreamTermination() -> AsyncStream<Int> {
    .init { continuation in
        // public var onTermination: (@Sendable (AsyncStream<Element>.Continuation.Termination) -> Void)? { get nonmutating set }
        continuation.onTermination = { termination in
            switch termination {
            case .finished:
                print("finished!!")
            case .cancelled:
                print("cancelled!!")
            @unknown default:
                break
            }
        }
        // 特に非同期実行でもないawaitしない処理であるこの３行を全てonTermination=よりも前に書いてしまうとterminationはcancelledで評価されてしまうので注意
        continuation.yield(0)
        continuation.yield(1)
        continuation.finish()
    }
}

func asyncStreamSleepTermination() -> AsyncStream<Int> {
    .init { continuation in
        Task {
            for num in [3, 2, 1] {
                try! await sleep(seconds: num)
                continuation.yield(num)
            }
            continuation.finish()
        }
        
        continuation.onTermination = { termination in
            switch termination {
            case .finished:
                print("finished!!")
            case .cancelled:
                print("cancelled!!")
            @unknown default:
                break
            }
        }
    }
}

func asyncStreamChildTaskCancelTermination() -> AsyncThrowingStream<Int, Error> {
    .init { continuation in
        let task = Task {
            for num in [3, 2, 1] {
                do {
                    try await sleep(seconds: num)
                    continuation.yield(num)
                } catch {
                    // このエラーはキャンセル元には伝わらない
                    continuation.finish(throwing: MyError.e2)
                }
            }
            continuation.finish()
        }
        
        continuation.onTermination = { termination in
            switch termination {
            case .finished:
                print("finished!!")
            case .cancelled:
                print("cancelled!!")
                // キャンセル時に明示的にcontinuation.finish(throwing:を呼ぶことでキャンセル元にエラーが伝わる
                continuation.finish(throwing: MyError.e1)
                task.cancel()
            @unknown default:
                break
            }
        }
    }
}
