//
//  ApiClient.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol APIClientProtocol {
    
    var decoder: DecoderProtocol { get set }
    func getDataFromServer<T: Decodable>(
        urlRequest: URLRequest,
        responseType: T.Type
    ) async -> Result<T, AppError>
}

struct APIClient: APIClientProtocol {
    var decoder: DecoderProtocol
    
    init(decoder: DecoderProtocol = JSONDataDecoder()) {
        self.decoder = decoder
    }
    
    func getDataFromServer<T: Decodable>(
        urlRequest: URLRequest,
        responseType: T.Type
    ) async -> Result<T, AppError> {
        
        do {
            // Fetch data from the server
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(AppError.invalidResponse)
            }
            
            let statusCode = httpResponse.statusCode
            
            if !(200...299).contains(statusCode) {
                if let errorMessage = try? decoder.decodeAPIError(data: data) {
                    return .failure(AppError.apiError(message: errorMessage))
                } else {
                    // Fallback to a generic HTTP error message
                    return .failure(.httpError(statusCode: statusCode))
                }
            }
            
            if data.isEmpty {
                return .failure(.httpError(statusCode: statusCode))
            }
            
            do {
                let model = try decoder.decodeObject(objectType: T.self, data: data)
                return .success(model)
            } catch {
                return .failure(AppError.decodingError(error: error))
            }
        } catch {
            return .failure(AppError.networkError(error: error))
        }
    }
}
