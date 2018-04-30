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
    
    var isFirstTimeDawg: Bool = true
    
    //MARK: INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndic.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(250)) {
            self.WoopWoop()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isFirstTimeDawg {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(150)) {
                self.WoopWoop()
            }
        }
    }
    
    
    @objc func WoopWoop(){
        isFirstTimeDawg = false
        performSegue(withIdentifier: "LesGetItStartedSegue", sender: self)
    }
    
}
