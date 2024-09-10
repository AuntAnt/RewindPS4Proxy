//
//  ProxyService.swift
//
//
//  Created by Anton Kuzmin on 04.09.2024.
//

import Proxy

public protocol ProxyService {
    func getLastError() -> String
    
    /// Set mode
    func setMode(_ mode: Int, _ url: String) async throws -> [String: Any]
    
    /// Detect connected device
    func detectConnectedClient(_ userAgent: String) -> String
    
    /// Start proxy server
    func startProxy(_ port: String)
    
    /// Stop proxy server
    func stopProxy()
}

public final class ProxyServiceImpl: ProxyService {
    
    public static let instance: ProxyService = ProxyServiceImpl()
    
    private let helper: Helper
    
    private init() {
        helper = Helper()
    }
    
    public func getLastError() -> String {
        return RewindGetLastServerError()
    }
    
    public func startProxy(_ port: String) {
        RewindStartProxy(port)
    }
    
    public func stopProxy() {
        RewindStopProxy()
    }
    
    public func setMode(_ mode: Int, _ url: String) async throws -> [String: Any] {
        let response = try helper.handleError(for: mode, url: url, RewindSetMode)
        
        return try helper.extractJSONFrom(str: response)
    }
    
    public func detectConnectedClient(_ userAgent: String) -> String {
        return RewindDetector(userAgent)
    }
}
