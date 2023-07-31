//
//  File.swift
//  
//
//  Created by Takahiro Nishinobu on 2022/04/27.
//

import Foundation

// async/await 並列実行パターン

// async let版
func asyncletParallel() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        async let num1 = outputIntArray()[0]
        async let num2 = outputIntArray()[1]
        let result = try await num1 + num2
        print("result: " + result.description)
    }
}

// withThrowingTaskGroup版
func withThrowingTaskGroupParallel() -> Task<Int, Error> {
    Task {
        print("start " + #function.debugDescription)
        return try await withThrowingTaskGroup(of: [Int].self) { group in
            for _ in 0..<3 {
                group.addTask {
                    try await outputIntArray()
                }
            }
            let result = try await group.reduce(into: 0) { result, nums in
                result = result + nums.reduce(0, +)
            }
            print("result: " + result.description)
            return result
        }
    }
}

// withThrowingTaskGroupは並列で動くがgroupの中を更に並列で動かしたい場合
func withThrowingTaskGroupChildTaskParallel() -> Task<Int, Error> {
    Task {
        print("start " + #function.debugDescription)
        return try await withThrowingTaskGroup(of: Int.self) { group in
            for _ in 0..<3 {
                group.addTask {
                    async let nums1 = outputIntArray()
                    async let nums2 = outputIntArray()
                    return try await nums1.reduce(0, +) + nums2.reduce(0, +)
                }
                // addTaskの中でasync letを使わなくても返り値が同じ型の場合は下記のように書くと並列で動く
//                group.addTask {
//                    outputIntArray()
//                }
//                group.addTask {
//                    outputIntArray()
//                }
            }
            let result = try await group.reduce(into: 0) { result, num in
                result += num
            }
            print("result: " + result.description)
            return result
        }
    }
}

// withThrowingTaskGroup前に宣言しているasync letを実行するにはwithThrowingTaskGroupのクロージャでキャプチャしないとエラーになる
func withThrowingTaskGroupCapturing() -> Task<Int, Error> {
    Task {
        print("start " + #function.debugDescription)
        async let nums = outputIntArray()
        return try await withThrowingTaskGroup(of: Int.self) { [nums] group in
            // [nums]でキャプチャしないと `Capturing 'async let' variables is not supported` エラーが出る
            for _ in 0..<2 {
                group.addTask {
                    // [nums]でキャプチャしたのでtry awaitも不要になる
                    nums.reduce(0, +)
                }
            }
            return try await group.reduce(into: 0) { result, num in
                result += num
            }
        }
    }
}

func badPatternAsynclet() -> Task<Int, Error> {
    Task {
        print("start " + #function.debugDescription)
        // この書き方をしても並列には実行してくれない（直列実行になる）
        async let (num1, num2) = (outputIntArray()[0], outputIntArray()[1])
        let result = try await num1 + num2
        print("result " + result.description)
        return result
    }
}
