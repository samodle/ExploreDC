import Foundation
import AWSCore

let S3BucketName: String = "exploredc"   // Update this to your bucket name
let S3DownloadKeyName: String = "pano_mallN00.png"    // Name of file to be downloaded
let S3UploadKeyName: String = "test-image.png"      // Name of file to be uploaded

let TriggerPitch: CGFloat = -70 //pitch at which the 'look down to trigger the UI' functionality executes
