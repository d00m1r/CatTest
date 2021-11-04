//
//  CatNetworkService.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import Foundation
import UIKit

class CatNetworkService: NSObject{
    private let imageCache = ImageCache()
    
    static let shared = CatNetworkService()
    
    func getCats(limit: Int = 9, page: Int, onCompletion: @escaping ([Cat]) -> Void) {
        var components = URLComponents(string: K.search_url) ?? URLComponents()
        
        let parameters: [String: String] = [
            "limit": "\(limit)",
            "page": "\(page)"
        ]
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil
            else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                onCompletion(cats)
            } catch {
                print("Decode error:", error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func loadCatImage(url: URL, onCompletion: @escaping (UIImage?) -> Void){
        if let image = self.imageCache.image(for: url){
            onCompletion(image)
            print("\n *** Get image from cache ***\n")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("\n*** Load cat image:", url, "on", Thread.current, "***\n")
            guard
                let data = data,
                error == nil
            else {
                return
            }
            if let image = UIImage(data: data){
                self.imageCache.insertImage(image, for: url)
                onCompletion(image)
            }
        }
        task.resume()
    }
}
