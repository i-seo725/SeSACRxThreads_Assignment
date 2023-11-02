//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 이은서 on 11/2/23.
//

import Foundation
import RxSwift

class BirthdayViewModel {
    
    let birthDay = BehaviorSubject(value: Date.now)
    
    let year = BehaviorSubject(value: 1998)
    let month = BehaviorSubject(value: 7)
    let day = BehaviorSubject(value: 25)
    
    let buttonEnalbed = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    init() {
       
        birthDay
            .subscribe(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                owner.year.onNext(component.year!)
                owner.month.onNext(component.month!)
                owner.day.onNext(component.day!)
            }
            .disposed(by: disposeBag)
        
    }

    
}
