//
//  ViewController.swift
//  PlayVideo
//
//  Created by Albert on 2019/3/5.
//  Copyright © 2019 zfm. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    var path:String?
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        ///获取视频路径
        path = Bundle.main.path(forResource: "DarkPhoenix", ofType: "mp4")
        ///
        playerView = AVPlayer(url: URL(fileURLWithPath: path!))
        playerViewController.player = playerView
        
        ///获取本地视频第5秒的截图（这个可以自己根据实际情况来定）
        videoImage.image = getVideoCurrentImage(second: 5.0)
        
    }

    @IBAction func playBtn_click(_ sender: Any) {
        self.present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }
    
    /// 获取视频的关键图片
    ///
    /// - Returns: 第几秒的图片
    func getVideoCurrentImage(second:Double) -> UIImage {
        let avAsset = AVAsset(url: URL(fileURLWithPath: path!))
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(second, preferredTimescale: 600)
        var actualTime:CMTime = CMTimeMake(value: 0,timescale: 0)
        let imageRef:CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        let currentImage = UIImage(cgImage: imageRef)
        
        return currentImage
        
    }
}

