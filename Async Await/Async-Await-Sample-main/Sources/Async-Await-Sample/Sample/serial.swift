//
//  File.swift
//  
//
//  Created by Takahiro Nishinobu on 2022/04/27.
//

import Foundation

// async/await 直列実行パターン
func serial() -> Task<Void, Error> {
    Task {
        print("start " + #function.debugDescription)
        let _ = try await sleep(seconds: 3)
        let outputResult = try await outputIntArray()
        print("result: " + outputResult.description)
        print("end " + #function.debugDescription)
    }
}

