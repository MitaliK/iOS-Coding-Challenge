//
//  MovieDetails.swift
//  TubiCodingChallenge
//
//  Created by Mitali Kulkarni on 4/21/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    let id: String
    let title: String
    let imagePath: String
    let index: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case index
        case imagePath = "image"
    }
}
