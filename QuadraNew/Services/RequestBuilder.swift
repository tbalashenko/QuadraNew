//
//  RequestBuilder.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 05/06/2025.
//

import Foundation

#warning("Remove apiKey before commit")

final class RequestBuilder {

    #warning("Insert your apiKey here")
    private var apiKey: String = ""
    
    func buildRequest(prompt: String, url: URL?) -> URLRequest? {
        guard let apiUrl = url else { return nil }
        var request = URLRequest(url: apiUrl)
        
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue ("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "model": "o4-mini",
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return nil }
        request.httpBody = jsonData
        return request
    }
}

