//
//  ImageCacheType.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 05.11.2021.
//

import UIKit

protocol ImageCacheType: AnyObject {
    func image(for url: URL) -> UIImage?

    func insertImage(_ image: UIImage?, for url: URL)

    func removeAllImages()
    
}
