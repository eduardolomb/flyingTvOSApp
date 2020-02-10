//
//  AVURLAsset+extension.swift
//  flyingApp
//
//  Created by Eduardo Lombardi on 10/02/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import AVKit
import Foundation

extension AVURLAsset {
    func isDownloaded() -> Bool {
        
        // First check if media is present at asset's URL. This could be the case if asset was created locally.
        if let documentsPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let path = documentsPathString + "/" + self.url.pathComponents[2]
            let mediaExists = FileManager.init().fileExists(atPath: path)
            return mediaExists
        }
       return false
    }

    func downloadPath() -> URL? {
        if let documentsPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let path = documentsPathString + "/" + self.url.pathComponents[2]
            let url = URL(fileURLWithPath: path)
            return url
        }
        return nil
    }
}
