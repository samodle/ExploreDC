//
//  VRMapViewController.swift
//  ExploreDC
//
//  Created by sam on 4/13/18.
//  Copyright © 2018 Rubicon. All rights reserved.
//

import Foundation
import MapKit

class VRMapViewController: UIViewController {
    //MARK: GVR SDK
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    
    @IBOutlet weak var mainPanoView: GVRPanoramaView!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    //MARK: INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPanoView.enableFullscreenButton = true
        mainPanoView.enableCardboardButton = true
        mainPanoView.enableInfoButton = false
        mainPanoView.load(UIImage(named: "taft00.jpg"),
                          of: GVRPanoramaImageType.mono)
        
        // set initial location in DC
        let regionRadius: CLLocationDistance = 10000
        let initialLocation = CLLocation(latitude: 38.9072, longitude: -77.1369)
        centerMapOnLocation(location: initialLocation,mKmV: myMapView,regionRadius: regionRadius)
        
    }
    
    
    
    //MARK: Map Kit
    func centerMapOnLocation(location: CLLocation, mKmV: MKMapView, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mKmV.setRegion(coordinateRegion, animated: true)
    }
    
    
}



//MARK: VR Extension
extension VRMapViewController: GVRWidgetViewDelegate {
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
