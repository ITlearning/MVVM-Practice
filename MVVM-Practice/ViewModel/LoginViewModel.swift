//
//  LoginViewModel.swift
//  MVVM-Practice
//
//  Created by IT learning on 2021/09/03.
//

// LoginViewModel 은 비지니스 로직을 담당한다.

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewBindable {
    var loginButtonTouched: PublishRelay<Void> { get }
    var idTextFieldValueChanged: PublishRelay<String?> { get }
    var pwTextFieldValueChanged: PublishRelay<String?> { get }
    var loginUser: PublishSubject<User?> { get }
}


class LoginViewModel: LoginViewBindable {

    var loginUser: PublishSubject<User?> = PublishSubject<User?>()
    var loginButtonTouched: PublishRelay<Void> = PublishRelay<Void>()
    var pwTextFieldValueChanged: PublishRelay<String?> = PublishRelay<String?>()
    var idTextFieldValueChanged: PublishRelay<String?> = PublishRelay<String?>()
    
    let disposeBag = DisposeBag()
    
    var loginInfo: Observable<LoginInfo> {
        return Observable.combineLatest(idTextFieldValueChanged, pwTextFieldValueChanged) {
            id, pw in
            
            return LoginInfo.init(id: id, pw: pw)
        }
    }
    
    init(model: LoginModel = LoginModel()) {
        
        loginButtonTouched.withLatestFrom(loginInfo).flatMapLatest {
            return model.login(info: $0).materialize()
        }.subscribe(onNext: { [unowned self] (event) in
            switch event {
            case .next(let user):
                self.loginUser.onNext(user)
            case .error(_):
                self.loginUser.onNext(nil)
            case .completed:
                print("COMPLETED")
            }
        }).disposed(by: disposeBag)
    }
}

