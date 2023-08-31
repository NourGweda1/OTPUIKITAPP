//
//  NetworkHandler.swift
//  Mimar
//
//  Created by Shimaa on 18/12/2022.
//

import Foundation
import Combine
import Alamofire
// swiftlint:disable all
public class NetworkHandler {
    public static let shared = NetworkHandler()

    private init() {}

    public func requestAsync<T: Codable>(target: NetworkApis, model: T.Type) async throws
    -> Any? {
        let result: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: target.request)
        if let httpResponse = result.response as? HTTPURLResponse {
            if 200...299 ~= httpResponse.statusCode {
                let decoder = JSONDecoder()
                let responseModel = try decoder.decode(T.self, from: result.data)
                debugPrint(String(data: result.data, encoding: .utf8) ?? "")
                return responseModel
            } else {
                if httpResponse.statusCode == 401 {
                   // UserManager.shared.deleteUser()
                }
                var error: ApiErrors
                let responseModel = try JSONDecoder().decode(MainResonseModel.self, from: result.data)
                if let errorMsg = responseModel.message {
                    error = ApiErrors.custom(errorMsg: errorMsg)
                } else {
                    error = ApiErrors.getErrorType(with: httpResponse.statusCode)
                }
                throw error
            }
        }
        return nil
    }
}
