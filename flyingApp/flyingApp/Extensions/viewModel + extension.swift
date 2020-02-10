//
//  videoDownloads.swift
//  flyingApp
//
//  Created by Eduardo Lombardi on 10/02/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import Foundation

extension videoModel {
    
    func downloadVideo()
    {
        // Create destination URL
        if let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            guard let url = self.url else { return }
            let destinationFileUrl = documentsUrl.appendingPathComponent(url.pathComponents[2])
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:url)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "");
            }
        }
        task.resume()
        }
    }
        
}

