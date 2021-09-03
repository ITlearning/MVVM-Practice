//
//  LoginModel.swift
//  MVVM-Practice
//
//  Created by IT learning on 2021/09/03.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginModel {
    func login(info: LoginInfo) -> Observable<User> {
        
        return Observable.create( { (observer) -> Disposable in
            print("LOGIN") // 비즈니스 로직 (네트워크를 타고 온 것들)
            
            observer.onNext(User(name: info.id ?? ""))
            
            return Disposables.create()
        })
    }
}

struct LoginInfo {
    var id: String?
    var pw: String?
}

