//
//  User.swift
//  MVVM-Practice
//
//  Created by IT learning on 2021/09/03.
//

import Foundation


// 로그인이 성공했을 때 나오는 정보들

struct User: Codable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
