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

    //MARK: Variables
    var lastCardClick: FloatingCard = FloatingCard.NA

    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myNavBar: UINavigationItem!
    
    //MARK: INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPanoView.enableFullscreenButton = true
        mainPanoView.enableCardboardButton = true
        mainPanoView.enableInfoButton = false
        mainPanoView.enableTouchTracking = VR_enableTouchTracking
        mainPanoView.hidesTransitionView = VR_hidesTransitionView
        mainPanoView.load(UIImage(named: "taft00.jpg"),
                          of: GVRPanoramaImageType.mono)
        
        // set initial location in DC
        let regionRadius: CLLocationDistance = 10000
        let initialLocation = CLLocation(latitude: 38.9072, longitude: -77.1369)
        centerMapOnLocation(location: initialLocation,mKmV: myMapView,regionRadius: regionRadius)
        
        
        let x: CGFloat = 15
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "LeftArrow_Beck"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(VRTableViewController.LesGoHomeDawg(_:)), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: x, height: x)
        let barButton = UIBarButtonItem(customView: button)
        myNavBar.leftBarButtonItem = barButton
        
        
        switch lastCardClick{
        case FloatingCard.A:
            myNavBar.title = "National Mall"
            mainPanoView.load(UIImage(named: "union.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.B:
            myNavBar.title = "Northwest Quadrant"
            mainPanoView.load(UIImage(named: "garfield00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.C:
            myNavBar.title = "South"
            mainPanoView.load(UIImage(named: "mall00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.D:
            myNavBar.title = "Capitol Hill"
            mainPanoView.load(UIImage(named: "taft00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.E:
            myNavBar.title = "Waterfront"
            mainPanoView.load(UIImage(named: "bible01.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.F:
            myNavBar.title = "Houston"
            mainPanoView.load(UIImage(named: "vets00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case .NA:
            myNavBar.title = "error"
            mainPanoView.load(UIImage(named: "pano_scusD01.png"),
                              of: GVRPanoramaImageType.mono)
        }
    }
    
    
    
    //MARK: Map Kit
    func centerMapOnLocation(location: CLLocation, mKmV: MKMapView, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mKmV.setRegion(coordinateRegion, animated: true)
    }
    
    //MARK: Navigation
    @objc func LesGoHomeDawg(_ sender:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
        // performSegue(withIdentifier: "TableToMainSegue", sender: self)
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
