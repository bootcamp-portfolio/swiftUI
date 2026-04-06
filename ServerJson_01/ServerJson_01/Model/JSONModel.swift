//
//  JSONModel.swift
//  ServerJson_01
//
//  Created by electrozone on 3/31/26.
//

import Foundation

struct StudentJSON: Decodable{//상속 제이슨을 리스트로
    let code: String
    let phone: String
    let name: String
    let dept: String
}

extension StudentJSON: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}
