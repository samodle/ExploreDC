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
            
            ScrollView.isHidden = false
            bigMapView.isHidden = true
            
            ContainerViewNew.isHidden = false
        case 1:
            print("Map Selected")
            isDaySelected = false
            isWeekSelected = true
            
            ScrollView.isHidden = true
            bigMapView.isHidden = false

        default:
            break
        }
    }
       
    //MARK: Variables
        let locationManager = CLLocationManager()
    
  //  let assetfuelBlue = UIColor(red: 50/255, green: 205/255, blue: 240/255, alpha: 1)
    @IBOutlet var ContainerViewNew: UIView!
    @IBOutlet var ScrollView: UIScrollView!

    @IBOutlet weak var CardViewA: CardView!
    @IBOutlet weak var CardViewB: CardView!
    @IBOutlet weak var CardViewC: CardView!
    @IBOutlet weak var CardViewD: CardView!
    @IBOutlet weak var CardViewE: CardView!
    @IBOutlet weak var CardViewF: CardView!
    
    @IBOutlet var MainMenuSegmentView: SMSegmentView!
    
    @IBOutlet weak var panoCardA: GVRPanoramaView!
    @IBOutlet weak var panoCardB: GVRPanoramaView!
    @IBOutlet weak var panoCardC: GVRPanoramaView!
    @IBOutlet weak var panoCardD: GVRPanoramaView!
    @IBOutlet weak var panoCardE: GVRPanoramaView!
    @IBOutlet weak var panoCardF: GVRPanoramaView!
    
    @IBOutlet weak var mapDaddy: MKMapView!
    
    @IBOutlet weak var bigMapView: UIView!
    @IBOutlet weak var mapPanoView: GVRPanoramaView!
    
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
        
         checkLocationAuthorizationStatus()
        
     //   if(DidWeJustUnwind){
      //      DidWeJustUnwind = false
      //      performSegue(withIdentifier: SegueToExecute, sender: self)
      //  }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        panoCardA.enableInfoButton = false
        panoCardA.enableFullscreenButton = false
        panoCardA.enableCardboardButton = false
        panoCardA.enableTouchTracking = VR_enableTouchTracking
        panoCardA.hidesTransitionView = VR_hidesTransitionView
        panoCardA.load(UIImage(named: Media.photoArray.first!),
                           of: GVRPanoramaImageType.mono)
        
        panoCardB.enableInfoButton = false
        panoCardB.enableFullscreenButton = false
        panoCardB.enableCardboardButton = false
         panoCardB.enableTouchTracking = VR_enableTouchTracking
         panoCardB.hidesTransitionView = VR_hidesTransitionView
        panoCardB.load(UIImage(named: Media.photoArray.last!),
                           of: GVRPanoramaImageType.mono)

        panoCardC.enableInfoButton = false
        panoCardC.enableFullscreenButton = false
        panoCardC.enableCardboardButton = false
         panoCardC.enableTouchTracking = VR_enableTouchTracking
         panoCardC.hidesTransitionView = VR_hidesTransitionView
        panoCardC.load(UIImage(named: Media.photoArray[1]),
                           of: GVRPanoramaImageType.mono)
        
        panoCardD.enableInfoButton = false
        panoCardD.enableFullscreenButton = false
        panoCardD.enableCardboardButton = false
         panoCardD.enableTouchTracking = VR_enableTouchTracking
         panoCardD.hidesTransitionView = VR_hidesTransitionView
        panoCardD.load(UIImage(named: Media.photoArray[2]),
                       of: GVRPanoramaImageType.mono)
        
        panoCardE.enableInfoButton = false
        panoCardE.enableFullscreenButton = false
        panoCardE.enableCardboardButton = false
         panoCardE.enableTouchTracking = VR_enableTouchTracking
         panoCardE.hidesTransitionView = VR_hidesTransitionView
        panoCardE.load(UIImage(named: Media.photoArray[3]),
                       of: GVRPanoramaImageType.mono)
        
        panoCardF.enableInfoButton = false
        panoCardF.enableFullscreenButton = false
        panoCardF.enableCardboardButton = false
         panoCardF.enableTouchTracking = VR_enableTouchTracking
         panoCardF.hidesTransitionView = VR_hidesTransitionView
        panoCardF.load(UIImage(named: Media.photoArray[4]),
                       of: GVRPanoramaImageType.mono)
        
        mapPanoView.enableInfoButton = false
        mapPanoView.enableFullscreenButton = true
        mapPanoView.enableCardboardButton = true
         mapPanoView.enableTouchTracking = VR_enableTouchTracking
        mapPanoView.hidesTransitionView = VR_hidesTransitionView
        
        ManageCardHeights()
        
        let segmentView = MainMenuSegmentView
        
        segmentView?.delegate = self
        segmentView?.addSegmentWithTitle("By Category")
        segmentView?.addSegmentWithTitle("Map")

        segmentView?.selectSegmentAtIndex(0)

        // set initial location in DC
        mapDaddy.delegate = self
        //    mapView.register(ArtworkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if #available(iOS 11.0, *) {
            mapDaddy.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        } else {
            // Fallback on earlier versions
         //   let xyz3 = "moose"
        }
        
        let regionRadiusX: CLLocationDistance = 7000
        let initialLocationx = CLLocation(latitude: 38.9072, longitude: -77.0369)
        centerMapOnLocation(location: initialLocationx,mKmV: mapDaddy, regionRadius: regionRadiusX)
        
        
        // show artwork on map
            let dmx = Artwork(title: "Lincoln Memorial",
              locationName: "Abe chills hard in here",
              discipline: Discipline.memorial,
              coordinate: CLLocationCoordinate2D(latitude: 38.889305, longitude: -77.050092))
            mapDaddy.addAnnotation(dmx)
        
        let dmx2 = Artwork(title: "Arlington National Cemetery",
                          locationName: "ery or ary?",
                          discipline: Discipline.cemetery,
                          coordinate: CLLocationCoordinate2D(latitude: 38.87651, longitude: -77.06979))
        mapDaddy.addAnnotation(dmx2)
        
        let dmx3 = Artwork(title: "Jefferson Memorial",
                          locationName: "TJ chills hard here",
                          discipline: Discipline.memorial,
                          coordinate: CLLocationCoordinate2D(latitude: 38.880553, longitude: -77.036273))
        mapDaddy.addAnnotation(dmx3)
        
        let dmx4 = Artwork(title: "National Arboreum",
                          locationName: "lots of trees dawg",
                          discipline: Discipline.etc,
                          coordinate: CLLocationCoordinate2D(latitude: 38.910647, longitude: -77.966021))
        mapDaddy.addAnnotation(dmx4)
        
        let dmx5 = Artwork(title: "Marine Corps Memorial",
                           locationName: "Iwo Jima",
                          discipline: Discipline.memorial,
                          coordinate: CLLocationCoordinate2D(latitude: 38.890366, longitude: -77.070123))
        mapDaddy.addAnnotation(dmx5)
        
        let dmx6 = Artwork(title: "March For Our Lives",
                          locationName: "March 2018",
                          discipline: Discipline.event,
                          coordinate: CLLocationCoordinate2D(latitude: 38.892115, longitude: -77.021242))
        mapDaddy.addAnnotation(dmx6)
        
        let dmx7 = Artwork(title: "Women's March",
                          locationName: "April 18",
                          discipline: Discipline.event,
                          coordinate: CLLocationCoordinate2D(latitude: 38.897052, longitude: -77.039567))
        mapDaddy.addAnnotation(dmx7)
        
        let dmx8 = Artwork(title: "White House",
                          locationName: "realDonaldTrump tweets here",
                          discipline: Discipline.government,
                          coordinate: CLLocationCoordinate2D(latitude: 38.89762, longitude: -77.036070))
        mapDaddy.addAnnotation(dmx8)
        
        let dmx9 = Artwork(title: "Botanical Garden",
                          locationName: "plants on plants on plants",
                          discipline: Discipline.museum,
                          coordinate: CLLocationCoordinate2D(latitude: 38.887817, longitude: -77.012295))
        mapDaddy.addAnnotation(dmx9)
        
        let dmx0 = Artwork(title: "Capitol Building",
                          locationName: "nothing happens here",
                          discipline: Discipline.government,
                          coordinate: CLLocationCoordinate2D(latitude: 38.889888, longitude: -77.008432))
        mapDaddy.addAnnotation(dmx0)
        
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
    }

    //MARK: Map Kit
    func centerMapOnLocation(location: CLLocation, mKmV: MKMapView, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mKmV.setRegion(coordinateRegion, animated: false)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapDaddy.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    //MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCategorySegue" { //this means we are gonna do drugs. right? right guys?

            let toolPageViewController = segue.destination as! VRTableViewController
            toolPageViewController.lastCardClick = LastCardTapped
            toolPageViewController.animals = getVRTableData(thingy: LastCardTapped)
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

   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        print("Cell \(indexPath.row) selected")
    }
    
    func goHome() {
        dismiss(animated: true, completion: nil)
    }
    
   // var heightAnchor:NSLayoutConstraint!
    
    var ixx = 1
    @IBOutlet weak var yourHeightConstraintOutlet: NSLayoutConstraint!
    func mapView(_ mapView: MKMapView,
                          didSelect view: MKAnnotationView){
       // heightAnchor = SlideDrawerViewController.view.MainMapView.heightAnchor.constraint(equalToConstant:44.0)
       // heightAnchor = mapPanoView.heightAnchor.constraint(equalToConstant: 350)
       // heightAnchor.isActive = true
        yourHeightConstraintOutlet.constant = 350
        bigMapView.layoutIfNeeded()
        
        mapPanoView.load(UIImage(named: Media.photoArray[ixx]),
                       of: GVRPanoramaImageType.mono)
        ixx += 1
    }
    
    //MARK: Other
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
        }
        
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


// MARK: - MKMapViewDelegate

extension SlideDrawerViewController: MKMapViewDelegate {
    
    //   1
    //  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //    guard let annotation = annotation as? Artwork else { return nil }
    //    // 2
    //    let identifier = "marker"
    //    var view: MKMarkerAnnotationView
    //    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    //      as? MKMarkerAnnotationView { // 3
    //      dequeuedView.annotation = annotation
    //      view = dequeuedView
    //    } else {
    //      // 4
    //      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    //      view.canShowCallout = true
    //      view.calloutOffset = CGPoint(x: -5, y: 5)
    //      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    //    }
    //    return view
    //  }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
}
}


