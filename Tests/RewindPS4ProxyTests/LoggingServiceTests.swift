//
//  LoggingServiceTests.swift
//
//
//  Created by Anton Kuzmin on 09.09.2024.
//

import XCTest
@testable import RewindPS4Proxy

// I'm sorry for that tests
final class LoggingServiceTests: XCTestCase {
    
    private let service = LoggingServiceImpl.instance
    
    func test_fetchClientStatus() async {
        
        do {
            let result = try await service.fetchClientStatus()
            
            let str = String(data: result, encoding: .utf8)
            print(str ?? "ERROR")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func test_fetchLogs() async {
        do {
            let result = try await service.fetchLogs()
            
            let str = String(data: result, encoding: .utf8)
            print(str ?? "ERROR")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func test_fetchLastServerError() async {
        let result = try? await service.fetchLastServerError()
        
        print(result ?? "nothing")
    }
}
