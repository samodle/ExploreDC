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
    @IBOutlet weak var myNavBar: UINavigationItem!
    @IBOutlet weak var actualNavBarRip: UINavigationBar!
    
    //MARK: View DidLoad/etc
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.rewind, target: self, action: #selector(VRTableViewController.LesGoHomeDawg(_:)))
   */
        
        /*
                let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.rewind, target: self, action: #selector(VRTableViewController.LesGoHomeDawg(_:)))
        navBarbutton.image = UIImage(named: "LeftArrow_Back")
        myNavBar.leftBarButtonItem?.image = UIImage(named: "LeftArrow_Back")
        myNavBar.leftBarButtonItem = navBarbutton
 */
        let x: CGFloat = 15
 
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "LeftArrow_Beck"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(VRTableViewController.LesGoHomeDawg(_:)), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: x, height: x)
     //   button.heightAnchor.constraint(equalToConstant: x)// = 25
     //   button.widthAnchor.constraint(equalToConstant: x)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
  
        myNavBar.leftBarButtonItem = barButton
    //    myNavBar.leftBarButtonItem?.width = x
        
        //pano init
        mainPanoView.enableFullscreenButton = true
        mainPanoView.enableCardboardButton = true
        mainPanoView.enableInfoButton = false
        mainPanoView.hidesTransitionView = VR_hidesTransitionView
        switch lastCardClick{
        case FloatingCard.A:
            myNavBar.title = "Memorials/Monuments"
        mainPanoView.load(UIImage(named: "union.jpg"),
             of: GVRPanoramaImageType.mono)
        case FloatingCard.B:
              myNavBar.title = "Government"
            mainPanoView.load(UIImage(named: "garfield00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.C:
              myNavBar.title = "Museums"
            mainPanoView.load(UIImage(named: "mall00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.D:
              myNavBar.title = "Events & Protests"
            mainPanoView.load(UIImage(named: "taft00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.E:
              myNavBar.title = "Cemeteries"
            mainPanoView.load(UIImage(named: "bible01.jpg"),
                              of: GVRPanoramaImageType.mono)
        case FloatingCard.F:
              myNavBar.title = "Misc."
            mainPanoView.load(UIImage(named: "vets00.jpg"),
                              of: GVRPanoramaImageType.mono)
        case .NA:
              myNavBar.title = "error"
            mainPanoView.load(UIImage(named: "pano_scusD01.png"),
                              of: GVRPanoramaImageType.mono)
        }
        
    }
    
    
    //MARK: Navigation
    @objc func LesGoHomeDawg(_ sender:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
       // performSegue(withIdentifier: "TableToMainSegue", sender: self)
    }
    
    //not using dis
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "LeftArrow_Back"), for: .normal)
        backButton.setTitle("  Back", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal) // You can change the TitleColor
    //    backButton.addTarget(self, action: #selector(self.backAction(_:)),A for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
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
