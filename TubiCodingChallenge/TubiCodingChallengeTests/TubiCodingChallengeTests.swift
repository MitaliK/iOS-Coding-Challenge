//
//  TubiCodingChallengeTests.swift
//  TubiCodingChallengeTests
//
//  Created by Mitali Kulkarni on 4/22/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import XCTest
@testable import TubiCodingChallenge

class TubiCodingChallengeTests: XCTestCase {

    // Test generic cache
    private var cache: LRUCache<Int, String>!
    
    override func setUp() {
        super.setUp()
        cache = LRUCache<Int, String>(5)
    }

    override func tearDown() {
        cache = nil
        super.tearDown()
    }

    // MARK: - Test get() of LRU cache
    func testLRUCacheGet() {
        // When
        cache.add(1, "A")
        
        // Then
        XCTAssertEqual(cache.get(1), "A")
    }
    
    // MARK: - Test isValid of LRU Cache
    func testLRUCacheisValid() {
        // When
        cache.add(1, "A")
        cache.add(2, "B")
        cache.add(3, "C")
        cache.add(4, "D")
        cache.add(5, "E")
        cache.add(6, "F")
        
        // Then
        XCTAssertEqual(cache.isValid(1), false)
    }
}
