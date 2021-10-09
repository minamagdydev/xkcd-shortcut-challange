//
//  FavoritesViewModel.swift
//  shorkCut_challange
//
//  Created by Mina on 10/8/21.
//

import Foundation
import UIKit

struct FavoriteItem {
    var title: String
    var disclosureImage: UIImage = UIImage(appImage: .disclosure_indicator)
}

class FavoritesViewModel {
    
    var title: String = "Favorite"
    
    // Subscription methods: To be subscribed by view controller
    var pushController: ((UIViewController) -> Void)?
    var refreshFavorites: (() -> Void)?
    
    private let comicStorageService = StorageService(fileName: Constants.Comic.storageFileName)
    var favoriteComics: [Comic]?
    
    var favoriteItems: [FavoriteItem] = []
    
    init() {}
    
    func updateFavorites() {
        favoriteComics = comicStorageService.fetch()
        favoriteItems.removeAll()
        favoriteComics?.forEach({ _ in
            favoriteItems.append(FavoriteItem(title: "Home"))
        })
        refreshFavorites?()
    }
}

// MARK: User Actions

extension FavoritesViewModel {
    func loadComicDetails(atIndex index: Int) {
        let homeViewModel = HomeViewModel(withComicId: favoriteComics?[index].num?.toString() ?? "", shouldAllowBrowsing: false)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        pushController?(homeViewController)
    }
}
