//
//  PersistenceTest.swift
//  ShoppeStore
//
//  Created by Илья Шаповалов on 09.03.2025.
//

import Testing
import ShoppeStore

struct PersistenceTest {
    let sut = ShoppeStore.shared.persistence

    @Test func isOnboarded() async throws {
        sut.isOnboarded = false
        
        #expect(sut.isOnboarded == false)
        
        sut.isOnboarded = true
        
        #expect(sut.isOnboarded == true)
    }

    @Test func favorites() async throws {
        sut.favorites = nil
        
        #expect(sut.favorites == nil)
        
        sut.favorites = [1]
        
        #expect(sut.favorites == [1])
    }
    
    @Test func card() async throws {
        sut.card = nil
        
        #expect(sut.card == nil)
        
        sut.card = [1: 1]
        
        #expect(sut.card == [1: 1])
    }
    
    @Test func searchHistory() async throws {
        sut.searchHistory = nil
        
        #expect(sut.searchHistory == nil)
        
        sut.searchHistory = ["baz"]
        
        #expect(sut.searchHistory == ["baz"])
    }
}
