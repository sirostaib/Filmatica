//
//  NetworkHelper.swift
//  Filmatica
//
//  Created by Siros Taib on 7/11/24.
//

import Foundation
import RxSwift

class URLBuilder {
    private let baseURL: URL
    private let apiKey: String

    init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }

    func buildURL(endpoint: String) -> URL? {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return urlComponents?.url
    }

}
