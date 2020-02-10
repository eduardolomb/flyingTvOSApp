//
//  dataModel.swift
//  flyingApp
//
//  Created by Eduardo Lombardi on 02/02/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import Foundation

struct videoModel: Codable {
    
    let name:String?
    let url:URL?
    
    private enum codingKeys: String, CodingKey {
        case name
        case url
    }
}
