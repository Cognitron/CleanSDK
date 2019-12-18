//
//  VideoPlayerConstructor.swift
//  Alamofire
//
//  Created by Artem Eremeev on 18.12.2019.
//

import Foundation
import AVKit
import AVFoundation

public class VideoPlayerConstructor: SystemActionConstructorType {
    
    private let videoPlayerController: AVPlayerViewController
    
    public convenience init(urlString: String) {
        self.init(url: URL(string: urlString)!)
    }
    
    public init(url: URL) {
        videoPlayerController = AVPlayerViewController()
        videoPlayerController.player = AVPlayer(url: url)
    }
    
    public func show() {
        present(controller: videoPlayerController, completion: {
            self.videoPlayerController.player?.play()
        })
    }
}
