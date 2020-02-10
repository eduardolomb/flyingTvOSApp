//
//  playlistArrayModel.swift
//  flyingApp
//
//  Created by Eduardo Lombardi on 02/02/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import Foundation

struct playlistArrayModel: Codable {
    
    let playlist: [videoModel]
    
    enum CodingKeys: String, CodingKey {
        case playlist
    }
    
}
