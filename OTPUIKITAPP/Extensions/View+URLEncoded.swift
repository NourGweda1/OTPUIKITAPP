//
//  View+URLEncoded.swift
//  OTPUIKITAPP
//
//  Created by Nour Gweda on 30/08/2023.
//

import Foundation

extension String {
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
