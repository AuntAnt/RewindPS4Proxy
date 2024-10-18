//
//  NetworkService.swift
//  
//
//  Created by Anton Kuzmin on 04.09.2024.
//

import ProxyServer

public protocol NetworkService {
    
    /// Get user local IP address
    func getLocalIP() async -> String
    
    /// Get game version from patch URL
    func getGameVersion(from url: String) -> String
    
    /// :nodoc:
    func getMappedData(from str: String) throws -> String
    
    /// Get game info details - name, CUSA, last version
    func fetchGameDetails(from url: String) async throws -> [String: Any]
    
    /// Get game image cover
    func fetchGameImageCover(from url: String) async throws -> String
    
    /// Validate that port is free
    func validatePort(_ port: Int) -> Bool
    
    /// Validate that link to JSON patch is correct
    func validateJSON(url: String) -> Bool
}

public final class NetworkServiceImpl: NetworkService {
    
    public static let instance: NetworkService = NetworkServiceImpl()
    
    private let helper: Helper
    
    private init() {
        helper = Helper()
    }
    
    public func getLocalIP() async -> String {
        return RewindLocalIP()
    }
    
    public func getGameVersion(from url: String) -> String {
        return RewindExtractVersion(url)
    }
    
    public func getMappedData(from str: String) throws -> String {
        return try helper.handleError(with: str, RewindMapper)
    }
    
    public func fetchGameDetails(from url: String) async throws -> [String: Any] {
        let response = try helper.handleError(with: url, RewindDetails)
        
        return try helper.extractJSONFrom(str: response)
    }
    
    public func fetchGameImageCover(from url: String) async throws -> String {
        return try helper.handleError(with: url, RewindTitleMetadataInfo)
    }
    
    public func validatePort(_ port: Int) -> Bool {
        return RewindCheckPort(port)
    }
    
    public func validateJSON(url: String) -> Bool {
        return RewindIsValidJSONURL(url)
    }
}
