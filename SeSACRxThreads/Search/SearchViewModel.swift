//
//  SearchViewModel.swift
//  SeSACRxThreads
//
//  Created by 이은서 on 11/5/23.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    var data = ["A", "AB", "AC", "B", "BD", "DC", "DA", "C"]
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    var searchButtonClickedEvent: ControlEvent<Void>?
    var searchBarText: ControlProperty<String>?
    
    
    func searchButtonClicked(event: ControlEvent<Void>, text: ControlProperty<String>) {
        
        event
            .withLatestFrom(text) { _, text in
                return text
            }
            .subscribe(with: self) { owner, text in
                owner.data.insert(text, at: 0)
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
    }
    
    func searchTextSearched(keyword: ControlProperty<String>) {
       
        keyword
           .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
           .distinctUntilChanged()
           .subscribe(with: self) { owner, text in
               let result = text == "" ? owner.data : owner.data.filter { $0.contains(text) }
               owner.items.onNext(result)
               print("실시간 검색 중 == \(text)")
           }
           .disposed(by: disposeBag)
    }
   
}
