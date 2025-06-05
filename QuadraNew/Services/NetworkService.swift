//
//  NetworkService.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 10/06/2024.
//

import Foundation
import UIKit

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case noInternetConnection
    
    var errorDescription: String {
        return switch self {
            case .invalidURL:
                TextConstants.incorrectUrl
            case .noInternetConnection:
                TextConstants.checkInternetConnection
            case .requestFailed:
                TextConstants.somethingWentWrong
            case .decodingFailed:
                TextConstants.somethingWentWrong
        }
    }
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func isReadyForRequest(urlString: String) -> Result<URLRequest, APIError> {
        guard NetworkMonitor.shared.isConnected else { return .failure(.noInternetConnection) }
        
        guard
            isValidUrl(urlString: urlString),
            let url = URL(string: urlString)
        else {
            return .failure(.invalidURL)
        }
        
        return .success(URLRequest(url: url))
    }
    
    func sendRequest(_ request: URLRequest) async throws -> Data {
        let (responseData, _) = try await URLSession.shared.data(for: request)
        return responseData
    }
    
    func fetch<T: Decodable>(urlString: String) async throws -> T {
        switch isReadyForRequest(urlString: urlString) {
            case .failure(let error):
                throw error
            case .success(let request):
                let data = try await sendRequest(request)
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw APIError.decodingFailed
                }
        }
    }
    
    func fetch(urlString: String) async throws -> Data {
        switch isReadyForRequest(urlString: urlString) {
            case .failure(let error):
                throw error
            case .success(let request):
                return try await sendRequest(request)
        }
    }

    func isValidUrl(urlString: String) -> Bool {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return false }

        return UIApplication.shared.canOpenURL(url)
    }
}


