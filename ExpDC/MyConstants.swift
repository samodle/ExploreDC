//
//  MyConstants.swift
//  assetfuel
//
//  Created by sam on 2/10/16.
//  Copyright © 2016 sam. All rights reserved.
//

import Foundation
import AWSCore

let S3BucketName: String = "exploredc"   // Update this to your bucket name
let S3DownloadKeyName: String = "pano_mallN00.png"    // Name of file to be downloaded
let S3UploadKeyName: String = "test-image.png"      // Name of file to be uploaded

let TriggerPitch: CGFloat = -70 //pitch at which the 'look down to trigger the UI' functionality executes

public enum FloatingCard{
    case A, B, C, D, E, F, NA
}

//MARK: Settings
let VR_hidesTransitionView: Bool = true


struct PublicConstants{
    //MARK: Card Size
    static let BigScreenCutoff: CGFloat = 750 //750
    static let BigHeightAnchor: CGFloat = 400 //300
    static let SmallHeightAnchor: CGFloat = 270 //170
    static let BigScreenNetSize: CGFloat = 1500 //1200
    static let SmallScreenNetSize:CGFloat = 800 //800
    
    //MARK: Other
}
