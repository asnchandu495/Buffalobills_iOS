//
//  ErrorRootResponse.swift
//  chatGPT
//
//

import Foundation

struct ErrorRootResponse: Decodable {
    let error: ErrorResponse
}

struct ErrorResponse: Decodable {
    let message: String
    let type: String?
}
