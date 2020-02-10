//
//  JSONParser.swift
//  flyingApp
//
//  Created by Eduardo Lombardi on 02/02/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import Foundation

class JSONParser: NSObject {
    
    var playlistItens:[videoModel] = []
    
    func downloadData(completion: @escaping (Bool) -> ()) {
        guard let jsonUrl = URL(string: "https://rapidwaveinc.com/playlist1.json") else { return }
        URLSession.shared.dataTask(with: jsonUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let videosData = try decoder.decode(playlistArrayModel.self, from: data)
                self.playlistItens = videosData.playlist
                completion(true)
            } catch let err {
                completion(false)
                print("Err", err)
            }
            }.resume()
    }
    
    
    
}
