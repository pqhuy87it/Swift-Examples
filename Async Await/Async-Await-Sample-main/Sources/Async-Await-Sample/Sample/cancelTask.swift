//
//  File.swift
//  
//
//  Created by Takahiro Nishinobu on 2022/05/12.
//

import Foundation

func cancelSingleTask() -> Task<Void, Never> {
    let task = Task {
        _ = await serial().result
        if Task.isCancelled {
            // ここは通る
            print("Canceled!!!")
        }
    }
    task.cancel()
    if Task.isCancelled {
        // ここにはこない
        print("Task.isCancelled!!!")
    }
    return task
}

func cancelTask() -> Task<Void, Error> {
    Task {
        serial()
        if Task.isCancelled {
            print("cancel!!")
        }
    }
}

// Task.sleep(nanoseconds: メソッドはキャンセルするとCancellationErrorをthrowする仕様になっている
// public static func sleep(nanoseconds duration: UInt64) async throws
func sleepCancel() -> Task<Void, Error> {
    // taskを保持することでキャンセルや完了を待つことができる
    // 逆にインスタンスとして保持しない場合は投げっぱなしでタスクは実行されたまま
    let task = Task {
        try await sleep(seconds: 3)
    }
    // cancel()を実行することでTaskのresultにCancellationErrorが代入される
    task.cancel()
    return task
}

// 親タスクをキャンセルした時に子タスクのキャンセルもしっかりハンドリングしたい場合
func parentTaskCancel() -> Task<Void, Error> {
    Task {
        let t1 = childTask1()
        let t2 = childTask2()
        let t3 = childTask3()
        
        // withTaskCancellationHandlerを使うとこのTaskのキャンセルを明示的に検知できるので子Taskのキャンセルなども連動できる
        // isCancelやTask.checkCancellation()の処理が要らなくなる可能性もある
        await withTaskCancellationHandler {
            print("withTaskCancellationHandler")
            let (r1, r2, r3) = await (t1.result, t2.result, t3.result)
            switch r1 {
            case .success:
                print("success")
            case .failure(let e):
                print(e.localizedDescription)
            }
            
            switch r2 {
            case .success:
                print("success")
            case .failure(let e):
                print(e.localizedDescription)
            }
            
            switch r3 {
            case .success:
                print("success")
            case .failure(let e):
                print(e.localizedDescription)
            }
        } onCancel: {
            print("onCancel")
            t1.cancel()
            t2.cancel()
            t3.cancel()
        }
        // このTaskがキャンセルされていた場合はCancellationErrorが投げられる
        try Task.checkCancellation()
    }
}

func fetchImageData() -> Task<Data?, Error> {
    Task {
        let imageURL = URL(string: "https://source.unsplash.com/random")!
        // キャンセルをthrowしたいパターンとifでチェックしてクリーンアップしたいパターン
//        try Task.checkCancellation()
//        guard Task.isCancelled == false else {
//            // Perform clean up
//            print("Image request was cancelled")
//            return nil
//        }
        print("Starting network request...")
        let (imageData, _) = try await URLSession.shared.data(from: imageURL)
        print("finishImageData: " + imageData.base64EncodedString())
        // Check for cancellation after the network request
        // to prevent starting our heavy image operations.
        // dataを取得した後にキャンセルされていた場合も考慮して厳密なハンドリングは様々なところでcheckCancellationなどを書く必要もある
        // コードがキャンセル状態を定期的にチェックするように注意する必要がある
        try Task.checkCancellation()
        return imageData
//        return UIImage(data: imageData)
    }
}

func fetchImage() async throws -> Data? {
    let imageTask = Task { () -> Data? in
        let imageURL = URL(string: "https://source.unsplash.com/random")!
        // キャンセルをthrowしたいパターンとifでチェックしてクリーンアップしたいパターン
//        try Task.checkCancellation()
//        guard Task.isCancelled == false else {
//            // Perform clean up
//            print("Image request was cancelled")
//            return nil
//        }
        print("Starting network request...")
        let (imageData, _) = try await URLSession.shared.data(from: imageURL)
        // Check for cancellation after the network request
        // to prevent starting our heavy image operations.
        // dataを取得した後にキャンセルされていた場合も考慮して厳密なハンドリングは様々なところでcheckCancellationなどを書く必要もある
        // コードがキャンセル状態を定期的にチェックするように注意する必要がある
        try Task.checkCancellation()
        return imageData
//        return UIImage(data: imageData)
    }
    imageTask.cancel()
    return try await imageTask.value
}
