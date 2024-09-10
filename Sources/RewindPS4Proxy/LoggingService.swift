//
//  LoggingService.swift
//
//
//  Created by Anton Kuzmin on 09.09.2024.
//

import Foundation

private enum URLPath {
    static let clientStatus = "client-status"
    static let logs = "logs"
    static let lastServerError = "last-server-error"
}

public protocol LoggingService {
    /// Receive connected device
    func fetchClientStatus() async throws -> Data
    
    /// Receive logs
    func fetchLogs() async throws -> Data
    
    /// Receive last server error
    func fetchLastServerError() async throws -> String?
}

public final class LoggingServiceImpl: LoggingService {
    
    private let baseURL = "http://localhost:29090/"
    
    public static let instance: LoggingService = LoggingServiceImpl()
    
    private init() {}
    
    public func fetchClientStatus() async throws -> Data {
        guard let url = URL(string: baseURL + URLPath.clientStatus) else {
            throw RewindError.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    public func fetchLogs() async throws -> Data {
        guard let url = URL(string: baseURL + URLPath.logs) else {
            throw RewindError.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    public func fetchLastServerError() async throws -> String? {
        guard let url = URL(string: baseURL + URLPath.lastServerError) else {
            throw RewindError.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = String(data: data, encoding: .utf8)
        
        return result
    }
}
