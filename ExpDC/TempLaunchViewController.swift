//
//  TempLaunchViewController.swift
//  ExploreDC
//
//  Created by sam on 4/25/18.
//  Copyright © 2018 Rubicon. All rights reserved.
//

import Foundation
import UIKit

class TempLaunchViewController: UIViewController {
    
    @IBOutlet weak var activityIndic: UIActivityIndicatorView!
    
    //MARK: INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndic.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(250)) {
            self.WoopWoop()
                 }
    }
    
    @objc func WoopWoop(){
        performSegue(withIdentifier: "LesGetItStartedSegue", sender: self)
    }
    
}
