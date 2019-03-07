//
//  ViewController.swift
//  TagNavigation
//
//  Created by Albert on 2019/3/7.
//  Copyright © 2019 zfm. All rights reserved.
//

import UIKit

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

class ViewController: UIViewController {
    
    var currentPosition = 0

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let firstView:FirstViewController = FirstViewController()
        
        let secondView:SecondViewController = SecondViewController()
        
        let thirdView:ThirdViewController = ThirdViewController()
        
        firstView.view.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        secondView.view.frame = CGRect(x: screen_width, y: 0, width: screen_width, height: screen_height)
        
        thirdView.view.frame = CGRect(x: screen_width*2, y: 0, width: screen_width, height: screen_height)
        
        self.scrollView .addSubview(firstView.view)
        self.scrollView.addSubview(secondView.view)
        self.scrollView.addSubview(thirdView.view)
        self.scrollView.contentSize = CGSize(width: 3*screen_width, height: 0)
        
        
    }

    @IBAction func rightBtn_click(_ sender: Any) {
        if currentPosition != 2 {
            currentPosition = 2
            self.scrollView.setContentOffset(CGPoint(x: 2*screen_width, y: 0), animated: true)
        }
        
    }
    @IBAction func centerBtn_click(_ sender: Any) {
        if currentPosition != 1 {
            currentPosition = 1
            self.scrollView.setContentOffset(CGPoint(x: screen_width, y: 0), animated: true)
        }
        
    }
    @IBAction func leftBtn_click(_ sender: Any) {
        if currentPosition != 0 {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
    }
    
}

