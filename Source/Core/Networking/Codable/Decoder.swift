//
//  Decoder.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol DecoderProtocol {
    func decodeObject<T: Decodable>(objectType: T.Type, data: Data) throws -> T
    func decodeAPIError(data: Data) throws -> String 

}

struct JSONDataDecoder: DecoderProtocol {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func decodeObject<T>(objectType: T.Type, data: Data) throws -> T where T: Decodable {
        return try decoder.decode(T.self, from: data)
    }
    
    func decodeAPIError(data: Data) throws -> String {
        let errorResponse = try decoder.decode([String: String].self, from: data)
        if let errorMessage = errorResponse["error"] {
            return errorMessage
        } else {
            throw AppError.invalidResponse
        }
    }
}
