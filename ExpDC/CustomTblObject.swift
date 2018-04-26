//
//  CustomTblObject.swift
//  ExploreDC
//
//  Created by sam on 4/25/18.
//  Copyright © 2018 Rubicon. All rights reserved.
//

import Foundation

class PlaceScene {
    
    //MARK: Properties
    
    var title: String
    var subtitle: String
    var photo: UIImage?
    var photo2: UIImage?
    
    //MARK: Initialization
    
    init?(title: String, substit: String, photo: UIImage?, pic2: UIImage?) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively <- this is from the example on apples website bruh. https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/CreateATableView.html#//apple_ref/doc/uid/TP40015214-CH8-SW1
      //  guard (rating >= 0) && (rating <= 5) else {
       //     return nil
       // }
        
        // Initialize stored properties.
        self.title = title
        self.photo = photo
        self.photo2 = pic2
        self.subtitle = substit
        
    }
}
