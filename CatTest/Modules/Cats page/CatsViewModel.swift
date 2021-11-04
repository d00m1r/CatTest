//
//  CatsViewModel.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import Foundation
import UIKit

final class CatsViewModel: NSObject{
    
    private let queue = DispatchQueue(label: "defaultQueue", qos: .userInitiated)
    private var currentPage: Int = 0
    private var cats: [Cat] = []{
        didSet{
            bindViewModelToController()
        }
    }
    
    public var bindViewModelToController : (() -> ()) = {}
    
    public func fetchCats(){
        guard currentPage < 1181 else {
            return // last page on back
        }
        queue.async { [weak self] in
            guard let strongSelf = self else { return }
            CatNetworkService.shared.getCats(page: strongSelf.currentPage) { cats in
                strongSelf.cats.append(contentsOf: cats)
            }
        }
        currentPage += 1
    }
    
    public func getCats() -> [Cat]{
        cats
    }

}
