import UIKit

import AWSCore
import AWSS3

class TestViewController: UIViewController {
    
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    
    
    @IBOutlet weak var littleBeeButton: UIButton!
    @IBOutlet weak var panoUnoView: GVRPanoramaView!
    @IBOutlet weak var progBar: UIProgressView!
    
    @IBAction func buttonDownEvent(_ sender: Any) {
        self.progBar.isHidden=false
        downloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progBar.isHidden = true
        self.progBar.progress = 0.0
        panoUnoView.enableInfoButton = false
        panoUnoView.enableFullscreenButton = true
        panoUnoView.enableCardboardButton = true
        
    }

func downloadData() {
    let expression = AWSS3TransferUtilityDownloadExpression()
    expression.progressBlock = {(task, progress) in DispatchQueue.main.async(execute: {
        // Do something e.g. Update a progress bar.
         self.progBar.progress = Float(progress.fractionCompleted)
    })
    }
    
    var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
    completionHandler = { (task, URL, data, error) -> Void in
        DispatchQueue.main.async(execute: {
            // Do something e.g. Alert a user for transfer completion.
            // On failed downloads, `error` contains the error object.
            
            if let error = error {
                NSLog("CORNDOGS JACKIE...CORNDOGS FOR ALL THESE PEOPLE: \(error)")
                //self.statusLabel.text = "Failed"
            }
            else if(self.progBar.progress != 1.0) {
               // self.statusLabel.text = "Failed"
                NSLog("Error: Failed - Likely due to sum bullsh*t: progress != 100...")
            }
            else{
               // self.statusLabel.text = "Success"
               // self.imageView.image = UIImage(data: data!)
         
                
                self.panoUnoView.load(UIImage(data: data!),
                                      of: GVRPanoramaImageType.mono)
            }
            
        })
    }
    
    let transferUtility = AWSS3TransferUtility.default()
    transferUtility.downloadData(
        fromBucket: "exploredc",
        key: "pano_namN00.png",
        expression: expression,
        completionHandler: completionHandler
        ).continueWith {
            (task) -> AnyObject? in if let error = task.error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let _ = task.result {
                // Do something with downloadTask.
                
            }
            return nil;
    }
}

}

//Mark: VR Extension
extension TestViewController: GVRWidgetViewDelegate {
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
