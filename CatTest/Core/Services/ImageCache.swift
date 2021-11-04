//
//  ImageCache.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 05.11.2021.
//

import UIKit

final class ImageCache {

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()

    private let lock = NSLock()
    private let config: Config

    struct Config {
        let countLimit: Int

        static let defaultConfig = Config(countLimit: K.cache_size)
    }

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}


extension ImageCache: ImageCacheType {
    func image(for url: URL) -> UIImage? {
//        lock.lock(); defer { lock.unlock() }
        
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            return decodedImage
        }
        return nil
    }
    
    func removeAllImages() {
//        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return }
        let decodedImage = image.decodedImage()

//        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decodedImage, forKey: url as AnyObject)
    }

}
