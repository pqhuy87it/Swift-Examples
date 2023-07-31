//
//  File.swift
//  
//
//  Created by Takahiro Nishinobu on 2022/05/12.
//

import Foundation

func asyncThrows() -> Task<Void, Error> {
    Task {
        async let e1 = throwsE1()
        async let e2 = throwsE2()
        // e1, e2共にエラーになる場合、優先されるのは手前に書いた方のタスクのエラーが優先される
        // e1が成功しe2がエラーになった場合、e2のエラーがTaskに入る
        // 仮にe1の処理時間が3秒で正常、e2が1秒でError Throwだった場合でもe1の処理待ちをしてからe2エラーが投げられる
        try await (e1, e2)
    }
}
