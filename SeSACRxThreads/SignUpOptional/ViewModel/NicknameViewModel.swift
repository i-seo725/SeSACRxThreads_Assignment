//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by 이은서 on 11/2/23.
//

import Foundation
import RxSwift

class NicknameViewModel {
    
    let nickname = BehaviorSubject(value: "")
    let buttonHidden = BehaviorSubject(value: true)
    
    let disposeBag = DisposeBag()
    
    init() {
        nickname.map { $0.count > 2 && $0.count <= 6 }
            .subscribe(with: self) { owner, value in
                owner.buttonHidden.onNext(!value)
            }
            .disposed(by: disposeBag)
    }
    
}
