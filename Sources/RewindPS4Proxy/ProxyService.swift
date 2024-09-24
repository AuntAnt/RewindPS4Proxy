//
//  ProxyService.swift
//
//
//  Created by Anton Kuzmin on 04.09.2024.
//

import Proxy

public protocol ProxyService {
    
    /// Set mode
    func setMode(_ mode: Int, _ url: String) async throws -> [String: Any]
    
    /// Detect connected device
    func detectConnectedClient(_ userAgent: String) -> String
    
    /// Start proxy server
    func startProxy(_ port: String) async throws
    
    /// Stop proxy server
    func stopProxy()
    
    /// Push to log server which mode selected
    func pushModeSelectionLog(_ modeNumber: Int)
}

public final class ProxyServiceImpl: ProxyService {
    
    public static let instance: ProxyService = ProxyServiceImpl()
    
    private let helper: Helper
    
    private init() {
        helper = Helper()
    }
    
    public func startProxy(_ port: String) async throws {
        RewindStartProxy(port)
        
        // wait for the server to try to start
        try? await Task.sleep(for: .seconds(2))
        
        let error = RewindGetLastServerError()
        
        if !error.isEmpty {
            throw RewindError.frameworkError(description: error)
        }
    }
    
    public func stopProxy() {
        RewindStopProxy()
    }
    
    public func setMode(_ mode: Int, _ url: String) async throws -> [String: Any] {
        let response = try helper.handleError(for: mode, url: url, RewindSetMode)
        
        if mode == 1 {
            return try helper.extractJSONFrom(str: response)
        } else {
            return [response: ""]
        }
    }
    
    public func detectConnectedClient(_ userAgent: String) -> String {
        return RewindDetector(userAgent)
    }
    
    public func pushModeSelectionLog(_ modeNumber: Int) {
        RewindOtherLog(modeNumber)
    }
}
