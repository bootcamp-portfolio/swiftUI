//
//  LampData.swift
//  Navigation
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI
internal import Combine //<<<<<<<<<<<<<<<<

//데이터 모델 정의
//shareddata sharelampstatus
class LampData: ObservableObject{
    @Published var sharedData: String = ""
    @Published var sharedLampStatus: String = "lamp_on"//초기값
}//전체 사용 변수//get storage구성
