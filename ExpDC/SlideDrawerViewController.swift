//
//  SlideDrawerViewController.swift
//  Created by sam on 12/31/15.
//  Copyright © 2015 sam. All rights reserved.
//
import UIKit
import MapKit

class SlideDrawerViewController: UIViewController, SMSegmentViewDelegate {
    //MARK: GVR SDK
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    
    enum Media {
        static var photoArray = ["bg01.jpg", "bg02.jpg", "bg03.jpg", "bible00.jpg", "bible01.jpg", "bible02.jpg",  "garfield00.jpg", "mall00.jpg", "mall01.jpg", "mall02.jpg", "taft00.jpg", "union.jpg", "verizon00.jpg", "verizon01.jpg", "vets00.jpg", "wharf.jpg"]
    }
    
    //MARK: Navigation Prep
    var DidWeJustUnwind: Bool = false
    var SegueToExecute: String = "HanShotFirst"
    var LastCardTapped: FloatingCard = FloatingCard.NA
    
    @IBAction func returnToLineSelect(_ sender: AnyObject) {
        goHome()
    }
    
    var isDaySelected: Bool = true
    var isWeekSelected: Bool = false

    func segmentView(_ segmentView: SMBasicSegmentView, didSelectSegmentAtIndex index: Int) {
        
        //TIME PERIOD DEPENDENT SETUP
        switch index{
        case 0:
            print("Category Selected")
            isDaySelected = true
            isWeekSelected = false
            
            ContainerViewNew.isHidden = false
            ContainerViewNew2.isHidden = true

        case 1:
            print("Area Selected")
            isDaySelected = false
            isWeekSelected = true
            
            ContainerViewNew.isHidden = true
            ContainerViewNew2.isHidden = false
     
    /*    case 2:
            print("month selected")
            isDaySelected = false
            isWeekSelected = false
            isMonthSelected = true
      */
        default:
            break
        }
    }
       
    //MARK: Variables
  //  let assetfuelBlue = UIColor(red: 50/255, green: 205/255, blue: 240/255, alpha: 1)
    @IBOutlet var ContainerViewNew: UIView!
    @IBOutlet weak var ContainerViewNew2: UIView!
    @IBOutlet var ScrollView: UIScrollView!

    @IBOutlet weak var CardViewA: CardView!
    @IBOutlet weak var CardViewB: CardView!
    @IBOutlet weak var CardViewC: CardView!
    @IBOutlet weak var CardViewD: CardView!
    @IBOutlet weak var CardViewE: CardView!
    @IBOutlet weak var CardViewF: CardView!
    @IBOutlet weak var CardView2A: CardView!
    @IBOutlet weak var CardView2B: CardView!
    @IBOutlet weak var CardView2C: CardView!
    @IBOutlet weak var CardView2D: CardView!
    @IBOutlet weak var CardView2E: CardView!
    @IBOutlet weak var CardView2F: CardView!
    
    @IBOutlet var MainMenuSegmentView: SMSegmentView!
    
    @IBOutlet weak var panoCardA: GVRPanoramaView!
    @IBOutlet weak var panoCardB: GVRPanoramaView!
    @IBOutlet weak var panoCardC: GVRPanoramaView!
    @IBOutlet weak var panoCardD: GVRPanoramaView!
    @IBOutlet weak var panoCardE: GVRPanoramaView!
    @IBOutlet weak var panoCardF: GVRPanoramaView!
    
    @IBOutlet weak var mapViewA: MKMapView!
    @IBOutlet weak var mapViewB: MKMapView!
    @IBOutlet weak var mapViewC: MKMapView!
    @IBOutlet weak var mapViewD: MKMapView!
    @IBOutlet weak var mapViewE: MKMapView!
    @IBOutlet weak var mapViewF: MKMapView!
    
    //MARK: Initialization
    
    convenience init?(selectedLineName: String){
        self.init()
    }
    
    convenience init(){
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: View Appear/Load
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(DidWeJustUnwind){
            DidWeJustUnwind = false
            performSegue(withIdentifier: SegueToExecute, sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        panoCardA.enableInfoButton = false
        panoCardA.enableFullscreenButton = false
        panoCardA.enableCardboardButton = false
        panoCardA.hidesTransitionView = VR_hidesTransitionView
        panoCardA.load(UIImage(named: Media.photoArray.first!),
                           of: GVRPanoramaImageType.mono)
        
        panoCardB.enableInfoButton = false
        panoCardB.enableFullscreenButton = false
        panoCardB.enableCardboardButton = false
         panoCardB.hidesTransitionView = VR_hidesTransitionView
        panoCardB.load(UIImage(named: Media.photoArray.last!),
                           of: GVRPanoramaImageType.mono)

        panoCardC.enableInfoButton = false
        panoCardC.enableFullscreenButton = false
        panoCardC.enableCardboardButton = false
         panoCardC.hidesTransitionView = VR_hidesTransitionView
        panoCardC.load(UIImage(named: Media.photoArray[1]),
                           of: GVRPanoramaImageType.mono)
        
        panoCardD.enableInfoButton = false
        panoCardD.enableFullscreenButton = false
        panoCardD.enableCardboardButton = false
         panoCardD.hidesTransitionView = VR_hidesTransitionView
        panoCardD.load(UIImage(named: Media.photoArray[2]),
                       of: GVRPanoramaImageType.mono)
        
        panoCardE.enableInfoButton = false
        panoCardE.enableFullscreenButton = false
        panoCardE.enableCardboardButton = false
         panoCardE.hidesTransitionView = VR_hidesTransitionView
        panoCardE.load(UIImage(named: Media.photoArray[3]),
                       of: GVRPanoramaImageType.mono)
        
        panoCardF.enableInfoButton = false
        panoCardF.enableFullscreenButton = false
        panoCardF.enableCardboardButton = false
         panoCardF.hidesTransitionView = VR_hidesTransitionView
        panoCardF.load(UIImage(named: Media.photoArray[4]),
                       of: GVRPanoramaImageType.mono)
        
        ManageCardHeights()
        
        let segmentView = MainMenuSegmentView
        
        segmentView?.delegate = self
        segmentView?.addSegmentWithTitle("By Category")
        segmentView?.addSegmentWithTitle("Map")

        segmentView?.selectSegmentAtIndex(0)

        // set initial location in DC
        let regionRadius: CLLocationDistance = 10000
        let initialLocation = CLLocation(latitude: 38.9072, longitude: -77.1369)
        centerMapOnLocation(location: initialLocation,mKmV: mapViewA,regionRadius: regionRadius)
        
        let regionRadiusB: CLLocationDistance = 8000
        let initialLocationB = CLLocation(latitude: 38.9072, longitude: -77.0369)
        centerMapOnLocation(location: initialLocationB,mKmV: mapViewB, regionRadius: regionRadiusB)
        
        let regionRadiusC: CLLocationDistance = 6000
        let initialLocationC = CLLocation(latitude: 38.8072, longitude: -77.0369)
        centerMapOnLocation(location: initialLocationC,mKmV: mapViewC, regionRadius: regionRadiusC)
        
        let regionRadiusD: CLLocationDistance = 9000
        let initialLocationD = CLLocation(latitude: 38.9072, longitude: -77.0369)
        centerMapOnLocation(location: initialLocationD,mKmV: mapViewD, regionRadius: regionRadiusD)
        
        let regionRadiusE: CLLocationDistance = 8000
        let initialLocationE = CLLocation(latitude: 38.9072, longitude: -77.0369)
        centerMapOnLocation(location: initialLocationE,mKmV: mapViewE, regionRadius: regionRadiusE)
        
        let regionRadiusF: CLLocationDistance = 7000
        let initialLocationF = CLLocation(latitude: 38.9072, longitude: -77.0369)
        centerMapOnLocation(location: initialLocationF,mKmV: mapViewF, regionRadius: regionRadiusF)
        
        //Programatically adding touch event handler to Cards (CardViewCOntrollers)
        
        //Card - gesture recognizers. https://developer.apple.com/documentation/uikit/uitapgesturerecognizer?preferredLanguage=occ
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIsA(_:)))
        self.CardViewA.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIsB(_:)))
        self.CardViewB.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIsC(_:)))
        self.CardViewC.addGestureRecognizer(gesture3)
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIsD(_:)))
        self.CardViewD.addGestureRecognizer(gesture4)
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIsE(_:)))
        self.CardViewE.addGestureRecognizer(gesture5)
        let gesture6 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIsF(_:)))
        self.CardViewF.addGestureRecognizer(gesture6)
        
        let gesture21 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIs2A(_:)))
        self.CardView2A.addGestureRecognizer(gesture21)
        let gesture22 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIs2B(_:)))
        self.CardView2B.addGestureRecognizer(gesture22)
        let gesture23 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIs2C(_:)))
        self.CardView2C.addGestureRecognizer(gesture23)
        let gesture24 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIs2D(_:)))
        self.CardView2D.addGestureRecognizer(gesture24)
        let gesture25 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIs2E(_:)))
        self.CardView2E.addGestureRecognizer(gesture25)
        let gesture26 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenAllKPIs2F(_:)))
        self.CardView2F.addGestureRecognizer(gesture26)
        
        //Card - old stuff
        //  let gesture2 = UITapGestureRecognizer(target: self, action: #selector(SlideDrawerViewController.OpenLossCompass(_:)))
      //  self.LossCompassCard.addGestureRecognizer(gesture2)
      //  self.LossCompassGraphView.addGestureRecogni/zer(gesture2)
       // self.LossCompassLabel.addGestureRecognizer(gesture2)
    }

    //MARK: Map Kit
    func centerMapOnLocation(location: CLLocation, mKmV: MKMapView, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mKmV.setRegion(coordinateRegion, animated: true)
    }
    
    //MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCategorySegue" { //this means we are gonna do drugs. right? right guys?

            let toolPageViewController = segue.destination as! VRTableViewController
            toolPageViewController.lastCardClick = LastCardTapped
            toolPageViewController.animals = getVRTableData(thingy: LastCardTapped)
        }
        else if segue.identifier == "ShowMapSegue"{
            let toolPageViewController = segue.destination as! VRMapViewController
            toolPageViewController.lastCardClick = LastCardTapped
        }
    }
    
    @objc func OpenAllKPIsA(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.A
        performSegue(withIdentifier: "ShowCategorySegue", sender: self)
    }
    @objc func OpenAllKPIsB(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.B
        performSegue(withIdentifier: "ShowCategorySegue", sender: self)
    }
    @objc func OpenAllKPIsC(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.C
        performSegue(withIdentifier: "ShowCategorySegue", sender: self)
    }
    @objc func OpenAllKPIsD(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.D
        performSegue(withIdentifier: "ShowCategorySegue", sender: self)
    }
    @objc func OpenAllKPIsE(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.E
        performSegue(withIdentifier: "ShowCategorySegue", sender: self)
    }
    @objc func OpenAllKPIsF(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.F
        performSegue(withIdentifier: "ShowCategorySegue", sender: self)
    }
    
    
    
    @objc func OpenAllKPIs2A(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.A
        performSegue(withIdentifier: "ShowMapSegue", sender: self)
    }
    
    @objc func OpenAllKPIs2B(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.B
        performSegue(withIdentifier: "ShowMapSegue", sender: self)
    }
    
    @objc func OpenAllKPIs2C(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.C
        performSegue(withIdentifier: "ShowMapSegue", sender: self)
    }
    
    @objc func OpenAllKPIs2D(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.D
        performSegue(withIdentifier: "ShowMapSegue", sender: self)
    }
    
    @objc func OpenAllKPIs2E(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.E
        performSegue(withIdentifier: "ShowMapSegue", sender: self)
    }
    
    @objc func OpenAllKPIs2F(_ sender:UITapGestureRecognizer){
        LastCardTapped = FloatingCard.F
        performSegue(withIdentifier: "ShowMapSegue", sender: self)
    }
    
  

   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        print("Cell \(indexPath.row) selected")
    }
    
    
    func goHome() {
        dismiss(animated: true, completion: nil)
    }
   
    
    //MARK: Other
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        DispatchQueue.main.async {
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func ManageCardHeights() {
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        if screenHeight > PublicConstants.BigScreenCutoff
        {
            let CardViewAHeight = CardViewA.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardViewBHeight = CardViewB.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardViewCHeight = CardViewC.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardViewDHeight = CardViewD.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardViewEHeight = CardViewE.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardViewFHeight = CardViewF.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let ContainerViewHeight = ContainerViewNew.heightAnchor.constraint(equalToConstant: 1600)
            
            CardViewAHeight.isActive = true
            CardViewBHeight.isActive = true
            CardViewCHeight.isActive = true
            CardViewDHeight.isActive = true
            CardViewEHeight.isActive = true
            CardViewFHeight.isActive = true
            ContainerViewHeight.isActive = true
            
            let CardView2AHeight = CardView2A.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2BHeight = CardView2B.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2CHeight = CardView2C.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2DHeight = CardView2D.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2EHeight = CardView2E.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2FHeight = CardView2F.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let Container2ViewHeight = ContainerViewNew2.heightAnchor.constraint(equalToConstant: 1600)
            
            CardView2AHeight.isActive = true
            CardView2BHeight.isActive = true
            CardView2CHeight.isActive = true
            CardView2DHeight.isActive = true
            CardView2EHeight.isActive = true
            CardView2FHeight.isActive = true
            Container2ViewHeight.isActive = true
            
        } else
        {
            let CardViewAHeight = CardViewA.heightAnchor.constraint(equalToConstant: PublicConstants.SmallHeightAnchor)
            let CardViewBHeight = CardViewB.heightAnchor.constraint(equalToConstant: PublicConstants.SmallHeightAnchor)
            let CardViewCHeight = CardViewC.heightAnchor.constraint(equalToConstant: PublicConstants.SmallHeightAnchor)
            let CardViewDHeight = CardViewD.heightAnchor.constraint(equalToConstant: PublicConstants.SmallHeightAnchor)
            let CardViewEHeight = CardViewE.heightAnchor.constraint(equalToConstant: PublicConstants.SmallHeightAnchor)
            let CardViewFHeight = CardViewF.heightAnchor.constraint(equalToConstant: PublicConstants.SmallHeightAnchor)
            let ContainerViewHeight = ContainerViewNew.heightAnchor.constraint(equalToConstant: 2600)
            
            CardViewAHeight.isActive = true
            CardViewBHeight.isActive = true
            CardViewCHeight.isActive = true
            CardViewDHeight.isActive = true
            CardViewEHeight.isActive = true
            CardViewFHeight.isActive = true
            ContainerViewHeight.isActive = true
            
            let CardView2AHeight = CardView2A.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2BHeight = CardView2B.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2CHeight = CardView2C.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2DHeight = CardView2D.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2EHeight = CardView2E.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let CardView2FHeight = CardView2F.heightAnchor.constraint(equalToConstant: PublicConstants.BigHeightAnchor)
            let Container2ViewHeight = ContainerViewNew2.heightAnchor.constraint(equalToConstant: 3000)
            
            CardView2AHeight.isActive = true
            CardView2BHeight.isActive = true
            CardView2CHeight.isActive = true
            CardView2DHeight.isActive = true
            CardView2EHeight.isActive = true
            CardView2FHeight.isActive = true
            Container2ViewHeight.isActive = true
        }
        
    }
  
    func showAlert(_ sender: AnyObject) {
    }
    
    
}

//MARK: VR Extension
extension SlideDrawerViewController: GVRWidgetViewDelegate {
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


