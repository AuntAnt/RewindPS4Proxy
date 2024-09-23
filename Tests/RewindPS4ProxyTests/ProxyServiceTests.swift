//
//  ProxyServiceTests.swift
//
//
//  Created by Anton Kuzmin on 05.09.2024.
//

import XCTest
@testable import RewindPS4Proxy

final class ProxyServiceTests: XCTestCase {
    
    private let proxyService = ProxyServiceImpl.instance
    private let patchLink = "http://gs2.ww.prod.dl.playstation.net/gs2/ppkgo/prod/CUSA03617_00/72/f_6c3faab1ab7f2485076aa29f7a982d99c8acdd4de8822c9072b736cb8e8fbdb9/f/EP1001-CUSA03617_00-MAFIA30000000001-A0109-V0101.json"

    func test_setMode() async {
        do {
            let result = try await proxyService.setMode(1, patchLink)
            print(result)
        } catch {
            print(error)
        }
    }
    
    func test_startProxy() async throws{
        do {
            try await proxyService.startProxy("8080")
        } catch {
            print(error)
        }
        
        proxyService.stopProxy()
    }
}
