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
        addPlayerNotifications()
    }
    
    func addPlayerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    
    func removePlayerNotifations() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    
    @objc func applicationWillEnterForeground(_ notification: Notification) {
        self.player.play()
    }
    
    @objc func applicationDidEnterBackground(_ notification: Notification) {
        self.player.pause()
    }
    
    func loadVideos() {
        let parser:JSONParser = JSONParser()
        parser.downloadData(completion: {(success) in
            if success {
                self.playlistItens = parser.playlistItens
                var playerItems = [AVPlayerItem]()
                self.playlistItens.forEach { (videoModel) in
                    if let asset = videoModel.checkDownload() {
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
    
    override func viewDidAppear(_ animated: Bool) {
        loadVideos()
    }
    
    func repeatVideo() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) {
            
            notification in
    
            self.currentVideo += 1
            if(self.currentVideo >= self.playlistItens.count) {
                self.currentVideo = 0
            }
            if self.playlistItens.indices.contains(self.currentVideo) {
                let videoModel = self.playlistItens[self.currentVideo]
                if let asset = videoModel.checkDownload() {
                    let playerItem = AVPlayerItem.init(asset: asset)
                    self.player.insert(playerItem, after: nil)
                }
            }
        }
    }
    
}

