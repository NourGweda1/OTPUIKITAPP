//
//  ParametersTypeEnum.swift
//  Mimar
//
//  Created by Shimaa on 18/12/2022.
//

import Foundation

public enum ParametersType {
    case requestBody(parameters: [String: Any])
    case requestQuery(parameters: [String: Any])
    case requestPlain
}
