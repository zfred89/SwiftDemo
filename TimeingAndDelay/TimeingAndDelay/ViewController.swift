//
//  ViewController.swift
//  TimeingAndDelay
//
//  Created by 张丰民 on 2019/3/4.
//  Copyright © 2019 zfm. All rights reserved.
//

import UIKit

let timerTitle = "Timer"
let gcdTitle = "GCD"
let choseTitle = "选择实现方式"

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var selectTypeBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    var timer:Timer? = Timer()//计时器
    var isCounting = false
    var isTimer = true
    var count : Float = 0.0
    {
        didSet{
            timeLabel.text = String(format: "%.1f", count)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0.0
        
    }
    @IBAction func resetBtn_click(_ sender: Any) {
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        isCounting = false
        selectTypeBtn.isEnabled = true
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
        timer = nil
        count = 0.0
    }
    
    @IBAction func startBtn_click(_ sender: Any) {
        if isTimer {
            timer =  Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
        }else{
            MRGCDTimer.share.scheduledDispatchTimer(withName: "666", timeInterval: 0.1, queue: .main, repeats: true) {
                self.updateCounter()
            }
        }
        
        isCounting = true
        selectTypeBtn.isEnabled = false
        startBtn.isEnabled = false
        pauseBtn.isEnabled = true
    }
    
    @IBAction func pauseBtn_click(_ sender: Any) {
        if isTimer {
            if let timerTemp = timer {
                timerTemp.invalidate()
            }
            timer = nil
        }else{
            if MRGCDTimer.share.isExistTimer(withName: "666") {
                MRGCDTimer.share.destoryTimer(withName: "666")
            }
        }
        
        isCounting = false
        selectTypeBtn.isEnabled = true
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
        
    }
    @IBAction func selectTypeBtn_click(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: choseTitle, preferredStyle: .actionSheet)
        let cancelAlert = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let timerAlert = UIAlertAction(title: timerTitle, style: .default) { (action) in
            self.isTimer = true
        }
        let gcdAlert = UIAlertAction(title: gcdTitle, style: .default) { (action) in
            self.isTimer = false
        }
        
        alert.addAction(cancelAlert)
        alert.addAction(timerAlert)
        alert.addAction(gcdAlert)
        self.present(alert, animated: true) {
            
        }
        
    }
    
//    更新计时数
    @objc func updateCounter () {
        count = count + 0.1
    }
}

