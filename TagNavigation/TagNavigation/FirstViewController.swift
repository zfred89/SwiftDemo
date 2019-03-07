//
//  FirstViewController.swift
//  TagNavigation
//
//  Created by Albert on 2019/3/7.
//  Copyright © 2019 zfm. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        let label = UILabel(frame: self.view.frame)
        label.textAlignment = .center
        label.text = "First"
        label.font = UIFont.systemFont(ofSize: 44)
        label.textColor = UIColor.white
        self.view.addSubview(label)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
