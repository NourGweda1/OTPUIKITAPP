//
//  DictionaryExtension.swift
//  Mimar
//
//  Created by Shimaa on 18/12/2022.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var outputString: String = "?"
        for (key, value) in self {
            outputString += "\(key)=\(value)&".urlEncoded
        }
        outputString = String(outputString.dropLast())
        return outputString
    }

    var subueryString: String {
        var outputString: String = "&"
        for (key, value) in self {
            outputString += "\(key)=\(value)&".urlEncoded
        }
        outputString = String(outputString.dropLast())
        return outputString
    }
}
