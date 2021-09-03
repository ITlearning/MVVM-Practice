//
//  ViewController.swift
//  MVVM-Practice
//
//  Created by IT learning on 2021/09/03.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

protocol BaseViewControllerAttributes { // 기본적으로 사용되어야 하는 함수들을 프로토콜로 선언
    func setUI() // 뷰의 레이아웃 구성하기
    func setAttributes() // 뷰의 옵션값 설정
    func bindRx() // Rx 적용
}


class LoginViewController: UIViewController {
    
    let idTextField = UITextField()
    let pwTextField = UITextField()
    let loginButton = UIButton()
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setAttributes()
        bindRx()
        // Do any additional setup after loading the view.
    }

    
}


extension LoginViewController: BaseViewControllerAttributes {
    func setAttributes() {
        self.idTextField.layer.borderColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.idTextField.layer.borderWidth = 1
        
        self.pwTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.pwTextField.layer.borderWidth = 1
        
        self.loginButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.loginButton.setTitle("로그인", for: .normal)
        self.loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.loginButton.titleLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.loginButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.loginButton.layer.borderWidth = 1
    }
    
    func bindRx() {
        idTextField.rx.text.orEmpty.bind(to: viewModel.idTextFieldValueChanged).disposed(by: disposeBag)
        pwTextField.rx.text.orEmpty.bind(to: viewModel.pwTextFieldValueChanged).disposed(by: disposeBag)
        
        loginButton.rx.tap.bind(to: viewModel.loginButtonTouched).disposed(by: disposeBag)
        
        viewModel.loginUser.subscribe(onNext: { (user) in
            print(user!)
            print("Login SUCCESS")
        }).disposed(by: disposeBag)
    }
    
    func setUI() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(idTextField)
        self.view.addSubview(pwTextField)
        self.view.addSubview(loginButton)
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(150)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(100)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-100)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(50)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(100)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-100)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(50)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(150)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-150)
        }
        
    }
}
