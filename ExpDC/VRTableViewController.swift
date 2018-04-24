//
//  VRTableViewController.swift
//  ExploreDC
//
//  Created by sam on 4/13/18.
//  Copyright © 2018 Rubicon. All rights reserved.
//

import Foundation

class VRTableViewController: UIViewController {
    //MARK: GVR SDK
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    
    @IBOutlet weak var mainPanoView: GVRPanoramaView!
    
    //MARK: Variables
    var lastCardClick: FloatingCard = FloatingCard.NA
    
    //MARK: View DidLoad/etc
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPanoView.enableFullscreenButton = true
        mainPanoView.enableCardboardButton = true
        mainPanoView.enableInfoButton = false
        switch lastCardClick{
        case FloatingCard.A:
        mainPanoView.load(UIImage(named: "union.jpg"),
             of: GVRPanoramaImageType.mono)
        case FloatingCard.B:
            mainPanoView.load(UIImage(named: "garfield00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.C:
            mainPanoView.load(UIImage(named: "mall00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.D:
            mainPanoView.load(UIImage(named: "taft00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.E:
            mainPanoView.load(UIImage(named: "bible01.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.F:
            mainPanoView.load(UIImage(named: "vets00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case .NA:
            mainPanoView.load(UIImage(named: "pano_scusD01.png"),
                              of: GVRPanoramaImageType.mono)
        }
        
    }
    
    
}



//MARK: VR Extension
extension VRTableViewController: GVRWidgetViewDelegate {
    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!) {
        if content is UIImage {
            //   imageVRView.isHidden = false
            //   imageLabel.isHidden = false
        } else if content is NSURL {
            //  videoVRView.isHidden = false
            //  videoLabel.isHidden = false
        }
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!,
                    withErrorMessage errorMessage: String!)  {
        print(errorMessage)
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode) {
        currentView = widgetView
        currentDisplayMode = displayMode
        
        if displayMode == GVRWidgetDisplayMode.fullscreen{
            
        }else{
            
        }
    }
    
    func widgetViewDidTap(_ widgetView: GVRWidgetView!) {
        // 1
        guard currentDisplayMode != GVRWidgetDisplayMode.embedded else {return}
        // 2
        
    }
}
