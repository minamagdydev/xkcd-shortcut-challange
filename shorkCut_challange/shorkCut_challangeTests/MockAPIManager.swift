//
//  File.swift
//  shorkCut_challangeTests
//
//  Created by Mina on 10/8/21.
//

import Foundation
@testable import shorkCut_challange

class MockAPIManager: APIManager {

    var fetchComicCalledTimes: Int = 0
    var fetchComicThrowsException = false
    var fetchComicReturn: Comic?

    var callThrough = true
    
    override func fetchComic(withId identifier: String, completion: @escaping (Comic?, String?) -> Void) {
        fetchComicCalledTimes += 1
        
        if callThrough {
            super.fetchComic(withId: "", completion: completion)
        } else {
            if fetchComicThrowsException {
                completion(nil, "Failed")
            } else {
                completion(fetchComicReturn, nil)
            }
        }
    }
}
