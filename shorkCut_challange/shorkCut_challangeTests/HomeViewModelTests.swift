//
//  HomeViewModelTests.swift
//  shorkCut_challangeTests
//
//  Created by Mina on 10/8/21.
//

import XCTest
@testable import shorkCut_challange

class HomeViewModelTests: XCTestCase {
    
    // MARK: - Setup
    
    var viewModel: HomeViewModel!
    var apiManager: MockAPIManager!
    let storageService: StorageService = StorageService(fileName: Constants.Comic.storageFileName)
    
    override func setUpWithError() throws {
        Constants.Mode.appMode = .mock
        apiManager = MockAPIManager()
        viewModel = HomeViewModel(withAPIManager: apiManager)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // MARK: - Tests
    
    func test_fetchData_WithEmptyComicId() {
        XCTAssertEqual(viewModel.currentComicId, "")
        XCTAssertEqual(viewModel.latestComicId, "")
        XCTAssertEqual(viewModel.title, "")
        
        viewModel.fetchData()
        
        XCTAssertEqual(1, apiManager.fetchComicCalledTimes)
        XCTAssertEqual(viewModel.currentComicId, "2364")
        XCTAssertEqual(viewModel.latestComicId, "2364")
        XCTAssertEqual(viewModel.title, "Comic # 2364")
    }
    
    func test_fetchData_WithComicId_100() {
        viewModel = HomeViewModel(withComicId: "100")
        
        XCTAssertEqual(viewModel.title, "")
        
        viewModel.fetchData()
        
        XCTAssertEqual(viewModel.title, "Comic # 100")
    }
    
    func test_SearchComic_WithComicNumber() {
        XCTAssertEqual(viewModel.title, "")
        
        viewModel.fetchData()
        
        XCTAssertEqual(viewModel.title, "Comic # 2364")
        
    }
    
    func test_SearchComic_WithText() {
        XCTAssertEqual(viewModel.title, "")
        viewModel.fetchData()
        
        XCTAssertEqual(viewModel.title, "Comic # 2364")
        viewModel.searchComic(withText: "abc")
        XCTAssertEqual(viewModel.title, "Comic # 2364")
        
        viewModel.searchComic(withText: "10000")
        XCTAssertEqual(viewModel.title, "Comic # 2364")
        
    }
    
    func test_handleBrowsing_UserInteraction() {
        XCTAssertTrue(viewModel.isLastStrip)
        XCTAssertFalse(viewModel.isFirstStrip)
    }
    
    func test_AddOrRemoveFavorites() {
        viewModel = HomeViewModel(withComicId: "100")
        viewModel.fetchData()
        XCTAssertEqual(viewModel.title, "Comic # 100")
        
        var favorites: [Comic]? = storageService.fetch()
        
        if favorites?.contains(where: { $0.num?.toString() == "100" }) ?? false {
            //Comic found - remove comic
            viewModel.addOrRemoveFavorite()
            favorites = storageService.fetch()
            XCTAssertFalse(favorites?.contains(where: {$0.num?.toString() == "100"}) ?? false)
            //Reset
            viewModel.addOrRemoveFavorite()
            
        } else {
            //Comic not found - add comic
            viewModel.addOrRemoveFavorite()
            favorites = storageService.fetch()
            XCTAssertTrue(favorites?.contains(where: {$0.num?.toString() == "100"}) ?? false)
            //Reset
            viewModel.addOrRemoveFavorite()
        }
    }
}
