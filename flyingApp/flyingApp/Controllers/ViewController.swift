//
//  ViewController.swift
//  flyingApp
//
//  Created by Eduardo Lombardi on 02/02/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var playlistItens:[videoModel] = []
    var currentVideo = 0
    var player = AVQueuePlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        player.automaticallyWaitsToMinimizeStalling = true
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {

        let parser:JSONParser = JSONParser()
        parser.downloadData(completion: {(success) in
            if success {
                self.playlistItens = parser.playlistItens
                var playerItems = [AVPlayerItem]()
                self.playlistItens.forEach { (videoModel) in
                if let asset = self.checkDownload(videoModel: videoModel) {
                    let playerItem = AVPlayerItem(asset: asset)
                    playerItems.append(playerItem)
                    self.player.insert(playerItem, after: nil)
                    }
            }
            
                let controller = AVPlayerViewController()
                controller.showsPlaybackControls = false
                controller.player = self.player
                
                self.present(controller, animated: true) {
                    self.player.play()
                }
            }})
        repeatVideo()
    }
    
    func repeatVideo() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) {
            
            notification in
            
            self.currentVideo += 1
            print("CURRENT VIDEO \(self.currentVideo)")
            if(self.currentVideo >= self.playlistItens.count) {
                self.currentVideo = 0
            print("CURRENT VIDEO \(self.currentVideo)")
            }
            if self.playlistItens.indices.contains(self.currentVideo) {
                let videoModel = self.playlistItens[self.currentVideo]
                if let asset = self.checkDownload(videoModel: videoModel) {
                    let playerItem = AVPlayerItem.init(asset: asset)
                    self.player.insert(playerItem, after: nil)
                }
            }
        }
    }
    
    func checkDownload(videoModel: videoModel) -> AVURLAsset? {
        if let url = videoModel.url {
            var asset = AVURLAsset(url: url)
            if !asset.isDownloaded() {
                videoModel.downloadVideo()
            } else {
                    if let localAssetURL = asset.downloadPath() {
                        asset = AVURLAsset.init(url: localAssetURL)
                    }
            }
            print("ASSET URL:\(asset.url)")
            return asset
        }
        return nil
    }

}

