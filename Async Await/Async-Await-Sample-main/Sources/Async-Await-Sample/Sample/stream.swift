//
//  File.swift
//  
//
//  Created by Takahiro Nishinobu on 2022/05/09.
//

import Foundation

// AsyncStream
func asyncStream() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        // awaitつけないとFor-in loop requires 'AsyncStream<Int>' to conform to 'Sequence'エラー
        for await value in outputIntSleepSerialAsyncStream() {
            print("streamValue: " + value.description)
        }
        print("end " + #function.debugDescription)
    }
}

func asyncStreamParallel() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        for await value in outputIntSleepParallelAsyncStream() {
            print("streamValue: " + value.description)
        }
        print("end " + #function.debugDescription)
    }
}

// AsyncThrowingStream
func asyncThrowingStreamError() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        do {
            for try await value in outputIntAsyncThrowingStream() {
                print("streamValue: " + value.description)
            }
        } catch {
            print("streamError: " + error.localizedDescription)
        }
        print("end " + #function.debugDescription)
    }
}

func asyncStreamFinishTermination() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        for await value in asyncStreamTermination() {
            print("streamValue: " + value.description)
        }
        print("end " + #function.debugDescription)
    }
}

// CancelしてもAsyncStream内の親タスクで実行されているSleep関数の処理はキャンセルされないver.
func asyncStreamCancelTermination() -> Task<Void, Error> {
    let task = Task {
        print("start " + #function.debugDescription)
        for try await value in asyncStreamSleepTermination() {
            print("streamValue: " + value.description)
        }
        print("end " + #function.debugDescription)
    }
    task.cancel()
    return task
}

func asyncStreamCancelTermination2() -> Task<Void, Never> {
    let task = Task {
        print("start " + #function.debugDescription)
        do {
            for try await value in asyncStreamChildTaskCancelTermination() {
                print("streamValue: " + value.description)
            }
        } catch {
            print("streamError: " + error.localizedDescription)
        }
        print("end " + #function.debugDescription)
    }
    // cancel()を呼び出した時点ですぐに抜けて終わる
    task.cancel()
    return task
}


