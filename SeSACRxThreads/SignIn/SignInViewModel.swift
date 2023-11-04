//
//  SignInViewModel.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel {
    
    var email: ControlProperty<String>?
    var password: ControlProperty<String>?
    
    lazy var validation = Observable.combineLatest(email!, password!) { first, second in
        return first.count > 5 && second.count > 8
    }
    
}
