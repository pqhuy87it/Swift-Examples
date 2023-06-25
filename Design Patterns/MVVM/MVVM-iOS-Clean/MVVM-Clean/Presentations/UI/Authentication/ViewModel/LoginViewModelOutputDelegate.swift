//
//  LoginViewModelOutputDelegate.swift
//  MVVM-Clean
//
//  Created by Alessandro Marcon on 04/08/2020.
//  Copyright © 2020 Alessandro Marcon. All rights reserved.
//

import Foundation
import Combine

protocol LoginViewModelOutputDelegate {
    var status: CurrentValueSubject<LoginViewModelStatus, Never> { get set }
    var error: CustomError? { get }
}
