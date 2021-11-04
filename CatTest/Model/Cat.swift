//
//  Cat.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import Foundation

struct Cat: Codable{
    let id: String
    let url: String
    let breeds: [Breed]
    
    let width: Int?
    let height: Int?
    
    let original_filename: String?
    let created_at: String?
    let sub_id: String?
    let categories: [Category]?
    
    let breed_ids: String?
    
}
