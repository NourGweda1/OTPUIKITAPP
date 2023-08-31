//
//  MainResonseModel.swift
//  Mimar
//
//  Created by Shimaa on 18/12/2022.
//

import Foundation

struct MainResonseModel: Codable {
    var success: Bool?
    var message: String?

//    func mappingToSuccessModel() -> SuccessModel {
//        return SuccessModel(success: success ?? false, message: message ?? "")
//    }
}
