//
//  ViewController.swift
//  CleanSDK
//
//  Created by Artem Eremeev on 11/10/2019.
//  Copyright (c) 2019 Artem Eremeev. All rights reserved.
//

import UIKit
import CleanSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if #available(iOS 11.0, *) {
//             self.additionalSafeAreaInsets.top = (self.navigationController?.navigationBar.frame.size.height)! - 44
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        VideoPlayerConstructor(urlString: "https://prostatic.smd.agency/media/videos/SampleVideo_1280x720_2mb.mp4").show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

