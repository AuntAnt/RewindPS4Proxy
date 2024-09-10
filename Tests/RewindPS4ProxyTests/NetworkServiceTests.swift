//
//  NetworkServiceTests.swift
//  
//
//  Created by Anton Kuzmin on 05.09.2024.
//

import XCTest
@testable import RewindPS4Proxy

// Shame on me for tests like this
final class NetworkServiceTests: XCTestCase {

    private let networkService = NetworkServiceImpl.instance
    private let patchLink = "http://gs2.ww.prod.dl.playstation.net/gs2/ppkgo/prod/CUSA03617_00/72/f_6c3faab1ab7f2485076aa29f7a982d99c8acdd4de8822c9072b736cb8e8fbdb9/f/EP1001-CUSA03617_00-MAFIA30000000001-A0109-V0101.json"
    
    func test_getLocalIp() async {
        let expectedLocalIp = "192.168.1.102"
        let actualIP = await networkService.getLocalIP()
        
        XCTAssertEqual(actualIP, expectedLocalIp)
    }
    
    func test_FreePort() {
        let port = 8080
        XCTAssertFalse(networkService.validatePort(port), "expected port \(port) is free, but used")
    }
    
    func test_UsedPort() {
        let port = 443
        XCTAssertTrue(networkService.validatePort(port), "expected port \(port) is used, but free")
    }
    
    func test_validateJSON() {
        XCTAssertTrue(networkService.validateJSON(url: patchLink))
    }
    
    func test_getMappedData() {
        do {
            let result = try networkService.getMappedData(from: patchLink)
            print(result)
        } catch {
            print(error)
        }
    }
    
    func test_fetchGameDetails() async {
        do {
            let result = try await networkService.fetchGameDetails(from: patchLink)
            print(result)
        } catch  {
            print(error)
        }
    }
    
    func test_fetchGameImageCover() async {
        do {
            let result = try await networkService.fetchGameImageCover(from: patchLink)
            print(result)
        } catch {
            print(error)
        }
    }
    
    func test_getGameVersion() {
        let expected = "01.09"
        let actual = networkService.getGameVersion(from: patchLink)
        
        XCTAssert(actual == expected, "expected: \(expected), but actual:\(actual)")
    }

}
