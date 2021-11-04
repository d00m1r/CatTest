//
//  Breed.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import Foundation
struct Breed: Codable{
    let adaptability : Int?
    let affection_level : Int?
    let bidability : Int?
    let cat_friendly : Int?
    let cfa_url : String?
    let child_friendly : Int?
    let country_code : String?
    let country_codes : String?
    let description : String?
    let dog_friendly : Int?
    let energy_level : Int?
    let experimental : Int?
    let grooming : Int?
    let hairless : Int?
    let health_issues : Int?
    let hypoallergenic : Int?
    let id : String?
    let indoor : Int?
    let intelligence : Int?
    let lap : Int?
    let life_span : String?
    let name : String?
    let natural : Int?
    let origin : String?
    let rare : Int?
    let reference_image_id : String?
    let rex : Int?
    let shedding_level : Int?
    let short_legs : Int?
    let social_needs : Int?
    let stranger_friendly : Int?
    let suppressed_tail : Int?
    let temperament : String?
    let vcahospitals_url : String?
    let vetstreet_url : String?
    let vocalisation : Int?
    let weight : Weight?
    let wikipedia_url : String?
}

struct Weight: Codable{
    let imperial: String
    let metric: String
}
