//
//  NetworkApisProtocol.swift
//  Mimar
//
//  Created by Shimaa on 18/12/2022.
//

import Foundation

public protocol NetworkApis {
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethods { get }
    var header: [String: String] { get }
    var parameters: ParametersType { get }
}

extension NetworkApis {
    var request: URLRequest {
        let targetUrl = self.baseURL.appendingPathComponent(self.path)
        var request = URLRequest(url: targetUrl)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = self.header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setRequestParameters(parametersType: parameters)
        request.timeoutInterval = 30
        return request
    }
}

extension URLRequest {
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"

        var cURL = "curl "
        var header = ""
        var data: String = ""

        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key, value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }

        if let bodyData = self.httpBody,
           let bodyString = String(data: bodyData, encoding: .utf8),
            !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }

        cURL += method + url + header + data
        return cURL
    }
}
