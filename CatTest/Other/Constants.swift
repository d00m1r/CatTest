//
//  Constants.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import UIKit

//MARK: - Core
struct K {
    static let search_url = "https://api.thecatapi.com/v1/images/search"
    static let cache_size: Int = 100
}

//MARK: - UI
struct Const {
    static let detailImageHeight: CGFloat = 180.0
    static let font: UIFont = .systemFont(ofSize: 16.0)
    static let topBottomPadding: CGFloat = 16.0
    static let leadingTrailingPadding: CGFloat = 24.0
    
    //MARK: - CatTVC
    struct CatTVC{
        static let imageHeight: CGFloat = 50.0
        static let padding: CGFloat = 16.0
    }
}
