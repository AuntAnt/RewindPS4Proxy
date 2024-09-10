//
//  Helper.swift
//
//
//  Created by Anton Kuzmin on 05.09.2024.
//

import Foundation

typealias FuncWithString = (String, NSErrorPointer) -> String
typealias FuncWithIntAndString = (Int, String, NSErrorPointer) -> String


enum RewindError: Error {
    case invalidUrl
    case jsonParseError
    case frameworkError(description: String)
}


final class Helper {
    
    func handleError(with url: String, _ funcWithError: FuncWithString) throws -> String {
        var error: NSError?
        
        let result = funcWithError(url, &error)
        
        if let error {
            throw RewindError.frameworkError(description: error.localizedDescription)
        }
        
        return result
    }
    
    func handleError(for mode: Int, url: String, _ funcWithError: FuncWithIntAndString) throws -> String {
        var error: NSError?
        
        let result = funcWithError(mode, url, &error)
        
        if let error {
            throw RewindError.frameworkError(description: error.localizedDescription)
        }
        
        return result
    }
    
    func extractJSONFrom(str: String) throws -> [String: Any] {
        let data = Data(str.utf8)
        
        if let result = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return result
        } else {
            throw RewindError.jsonParseError
        }
    }
}
