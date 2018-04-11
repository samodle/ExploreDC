import UIKit
import AWSCore
import AWSS3

class VRViewController: UIViewController {
    
    @IBOutlet weak var imageVRView: GVRPanoramaView!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var daMainView: UIView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var videoVRView: GVRVideoView!
    @IBOutlet weak var diggityDownloadButton: UIButton!
    
    weak var timer: Timer?
    
    enum Media {
        //museums, national mall, monuments, parks, white house & capitol
        static var photoArray = ["bg01.jpg", "bg02.jpg", "bg03.jpg", "bible00.jpg", "bible01.jpg", "bible02.jpg",  "garfield00.jpg", "mall00.jpg", "mall01.jpg", "mall02.jpg", "taft00.jpg", "union.jpg", "verizon00.jpg", "verizon01.jpg", "vets00.jpg", "wharf.jpg"]
        static let videoURL = "https://s3.amazonaws.com/ray.wenderlich/elephant_safari.mp4"
    }
    
    enum WhatNow{
        case GoBack
        case GoForward
        case Chill
    }
    
    
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    //var currentPosish = GVRHeadRotation.init() //this is sum loosely strung together horse 💩
    var yawY: CGFloat = 0
    var pitchP: CGFloat = 0
    var pitchIncrementer: Bool = false
    var wasLastMoveForwardAsOpposedToBack: Bool = false //this is obvi gonna be wrong the first time. im using it for testing ARE YOU OK WITH THAT! GAWD

    
    @IBAction func diggityTouchDown(_ sender: Any) {
        videoLabel.isHidden = true
        videoVRView.isHidden = true
    }
    
    
    
    
    
    func checkThatPosish(cP: GVRHeadRotation){
        yawY = cP.yaw
        pitchP = cP.pitch
        print("Yaw: ")
        print(yawY)
        print("Pitch: ")
        print(pitchP)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
      //  imageLabel.isHidden = true
       // imageVRView.isHidden = true
        videoLabel.isHidden = true
        videoVRView.isHidden = true
        imageVRView.load(UIImage(named: Media.photoArray.first!),
                         of: GVRPanoramaImageType.mono)
        //imageVRView.
        imageVRView.enableCardboardButton = true
        imageVRView.enableFullscreenButton = true
        imageVRView.enableInfoButton = false
        imageVRView.delegate = self
        videoVRView.load(from: URL(string: Media.videoURL))
        videoVRView.enableCardboardButton = true
        videoVRView.enableFullscreenButton = true
        videoVRView.delegate = self
        
      //  checkThatPosish(cP: imageVRView.headRotation) //this may have been causing odd crashes. das da best i got fo ya dawg
        
        startTimer()
  }
    
   

    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
  
            if self?.currentDisplayMode != GVRWidgetDisplayMode.embedded
            {
            self?.yawY = (self?.imageVRView.headRotation.yaw)!
            self?.pitchP = (self?.imageVRView.headRotation.pitch)!
            
            print("Yaw: \(String(describing: self?.yawY))")
            print("Pitch: \(String(describing: self?.pitchP))")
            
                let wN: WhatNow = self!.figureItDaFckOut() //switched to "let" to make xcode shut up
            
            switch wN {
            case .Chill:
                print("no change")
                if (self?.wasLastMoveForwardAsOpposedToBack)! {
                    print("Last Move: Forward")
                }else{
                    print("Last Move: Backward")
                }
            case .GoBack:
                print("<<<<<<< GO BACK")
                self?.wasLastMoveForwardAsOpposedToBack = false
                Media.photoArray.insert(Media.photoArray.removeLast(), at:  0)
                self?.imageVRView?.load(UIImage(named: Media.photoArray.last!),
                                        of: GVRPanoramaImageType.mono)
            case .GoForward:
                print("FORWARD >>>>>>>")
                self?.wasLastMoveForwardAsOpposedToBack = true
                Media.photoArray.append(Media.photoArray.removeFirst())
                self?.imageVRView?.load(UIImage(named: Media.photoArray.first!),
                                  of: GVRPanoramaImageType.mono)
            }
            
        }

        }
    }
    
    
    func figureItDaFckOut() -> WhatNow{
        if self.pitchP < TriggerPitch {
            if self.yawY < 0 {
                return WhatNow.GoBack
            } else{
                return WhatNow.GoForward
            }
        } else {
            return WhatNow.Chill
        }
    }
    
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    // if appropriate, make sure to stop your timer in `deinit`
    
    deinit {
        stopTimer()
    }
 
}

extension VRViewController: GVRWidgetViewDelegate {
    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!) {
        if content is UIImage {
         //   imageVRView.isHidden = false
         //   imageLabel.isHidden = false
        } else if content is NSURL {
          //  videoVRView.isHidden = false
          //  videoLabel.isHidden = false
        }
        
    //    checkThatPosish()
       
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!,
                    withErrorMessage errorMessage: String!)  {
        print(errorMessage)
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode) {
        currentView = widgetView
        currentDisplayMode = displayMode
       
      //checkThatPosish(cP: widgetView.headRotation)
        
        if displayMode == GVRWidgetDisplayMode.fullscreen{
            imageLabel.isHidden = true
            imageVRView.isHidden = true
            videoLabel.isHidden = true
            videoVRView.isHidden = true
            titleLabel.isHidden = true
            daMainView.backgroundColor = UIColor.black
            diggityDownloadButton.isHidden = true
        }else{
            imageLabel.isHidden = false
            imageVRView.isHidden = false
            videoLabel.isHidden = false
            videoVRView.isHidden = false
            titleLabel.isHidden = false
            daMainView.backgroundColor = UIColor.white
            diggityDownloadButton.isHidden=false
        }

      
    }
    
    
    func widgetViewDidTap(_ widgetView: GVRWidgetView!) {
        // 1
        guard currentDisplayMode != GVRWidgetDisplayMode.embedded else {return}
        // 2
        if currentView == imageVRView {
            Media.photoArray.append(Media.photoArray.removeFirst())
            imageVRView?.load(UIImage(named: Media.photoArray.first!),
                              of: GVRPanoramaImageType.mono)
        }
    }
}
