//
//  Movie.swift
//  TubiCodingChallenge
//
//  Created by Mitali Kulkarni on 4/19/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: String
    let title: String
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imagePath = "image"
    }
}
