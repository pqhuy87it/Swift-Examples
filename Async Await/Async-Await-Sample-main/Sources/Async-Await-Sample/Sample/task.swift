//
//  File.swift
//  
//
//  Created by Takahiro Nishinobu on 2022/05/09.
//

import Foundation

// タスクとは、プログラムの一部として非同期で実行できる作業の単位です。すべての非同期コードは、何らかのタスクの一部として実行されます。

// セッションでは、構造化されたタスク、構造化されていないタスク、そして分離されたタスクの分類について以下の表のように整理されています[13]。上 2 つの、async let
// により作成されるタスクとタスクグループに含まれるタスクのみが、ライフサイクルやキャンセルが管理されている構造化されたタスクにあたります。
// 逆に Task 型のイニシャライザや Task.detached 関数などを用いて作成した Task 型の値を直接扱っている場合は、
// そのライフサイクルをプログラマ自身が管理しなければいけないという意味で「構造化されていない（"structured" ではない）」ことになる、という点に留意してください。
// 実際、タスクグループは構造化されている性質を保つために、あえて子タスクに直接アクセスできないようにしている、とプロポーザルでも述べられています。

// 親子関係のタスク（構造化）であれば親のキャンセルは子に伝搬される
// 親子関係を作るにはasync letやwithThrowingTaskGroupを用いることで作ることができる
// Taskの中でTaskのイニシャライザを書いた場合は親子関係にはならず独立している
// この場合、大元のTaskをキャンセルしたときに中のTaskをキャンセルしたい場合はwithTaskCancellationHandlerやTask.checkCancellation()などを用いて自身で管理する必要がある

// Taskは生成後すぐに実行され明示的な開始は必要ない

func singleTask() {
    Task {
        try await sleep(seconds: 1)
        print("finish")
    }
}

// Taskとは並行処理の単位である
func twoTask() {
    print("start " + #function.debugDescription)
    Task {
        try await sleep(seconds: 2)
        print("finish sleep 2")
    }
    Task {
        try await sleep(seconds: 1)
        print("finish sleep 1")
    }
    print("end " + #function.debugDescription)
}

// 3つの並行処理
// async は私を呼び出す時には必ずawaitを付けることを強制させるものであって、awaitをつけたからといってそのメソッドの中身でTaskを作って並列実行して待ち合わせしてない場合は
// 非同期の同期にならない。
// ただしasync付きの関数呼び出しの際はその中の処理は子タスクとして扱われるのでキャンセルが伝搬される
func multiTasks() async -> Int {
    print("start " + #function.debugDescription)
    // ここで呼び出しているメソッドはTaskを返すがasyncなメソッドでないので非同期の同期はできない
    // それぞれ勝手に処理が走って勝手に終わるだけでできるのはtaskのキャンセルなどだけ
    _ = serial()
    _ = asyncletParallel()
    _ = asyncStream()
    print("end " + #function.debugDescription)
    // 呼び出している３つの非同期処理が終わる前にendと返り値の3が呼び出し元に返される
    return 3
}

// 3つの並行処理の完了を待ってから値を返したい場合
func asyncTask() async -> Int {
    print("start " + #function.debugDescription)
    // Taskにはそのタスクの結果であるresultというプロパティが存在していて、これがasyncの設計になっている
    // public var result: Result<Success, Failure> { get async }
    // もしくはResult<Success, Failure>のSuccessの方を取得するvalueプロパティが存在しておりvalueが取れない場合はErrorがthrowされる
    // public var value: Success { get async throws }
    _ = await serial().result
    _ = await asyncletParallel().result
    _ = await asyncStream().result
    print("end " + #function.debugDescription)
    return 3
}

func parentTask() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        // .valueでエラーがthrowされた場合はTaskResultに代入される
        _ = try await serial().value
        _ = try await asyncletParallel().value
        _ = try await asyncStream().value
        print("end " + #function.debugDescription)
    }
}

// async letすると子タスクが生成されて実行される検証
// ただしasync let で実行する処理がTaskを返すような場合は親をキャンセルしても止まらない
// async letで生成するTaskは現在実行しているタスクの子といった紐付けが行われるが、自らTaskを内側に書いたものは子タスクとして関連付けされないみたい
func asyncletChildTask() -> Task<Void, Never> {
    let t = Task {
        // async let は子タスクを作ってその中で処理を実行させるということになる
        async let child1 = sleep(seconds: 1)
        async let child2 = sleep(seconds: 3)
        async let child3 = sleep(seconds: 2)
        // tryでエラーが起きた場合はcatchで処理
        do {
            // ここで取得できる値は子タスクのTask.valueと同じことになる
            try await (child1, child2, child3)
        } catch is CancellationError {
            print("CancellationError!!!!!")
        } catch {
            print("noop")
        }
    }
    // 親タスクをキャンセルすることで子タスクであったchildのタスクもキャンセルされsleepを使っているのでCancellationErrorが投げられる
    // ただしchildTask1()のようなTaskを返すメソッドの場合は子タスクの扱いにならないのか親をキャンセルしても子タスクは止まらない
    t.cancel()
    return t
}

// async letで内部的に生成される子タスクと自らTaskを作ってキャンセルした時の挙動
// やはりasync letで生成した子タスクは親をキャンセルするとキャンセルされるのに対し自前で作った子タスクの方はキャンセルされない
func notChildTask() -> Task<Void, Never> {
    let r = Task {
        let t1 = Task {
            try! await sleep(seconds: 1)
        }
        let t2 = Task {
            try! await sleep(seconds: 2)
        }
        let t3 = Task {
            try! await sleep(seconds: 1)
        }
        await (t1, t2, t3)
    }
    r.cancel()
    return r
}

func childTask1() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        try await sleep(seconds: 1)
        print("end " + #function.debugDescription)
    }
}

func childTask2() -> Task<Int, Error> {
    Task {
        print("start " + #function.debugDescription)
        try await sleep(seconds: 2)
        print("end " + #function.debugDescription)
        return 1
    }
}

func childTask3() -> Task<String, Error> {
    Task {
        print("start " + #function.debugDescription)
        try await sleep(seconds: 1)
        print("end " + #function.debugDescription)
        return "a"
    }
}

// async letやwithThrowingTaskGroupを使った構造的(親子)なTask
func groupTask() async -> Task<Void, Error> {
    Task {
        try await withThrowingTaskGroup(of: Void.self) { group in
            for i in 1..<4 {
                group.addTask {
                    try await sleep(seconds: i)
                }
            }
            print("groupに追加したChildTaskが終わる前に呼び出される")
            try await group.waitForAll()
            print("groupに追加したChildTaskが全て終わってから呼び出される")
        }
    }
}
