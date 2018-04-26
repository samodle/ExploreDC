//
//  SharedFunctions.swift
//  ExploreDC
//
//  Created by sam on 4/26/18.
//  Copyright © 2018 Rubicon. All rights reserved.
//

import Foundation

func getVRTableData(thingy: FloatingCard) -> [PlaceScene]{
    var x = [PlaceScene]()
    var iconName: String
    
    switch thingy{
    case FloatingCard.A:
        iconName = "monu.png"
        x.append(PlaceScene(title: "Botanical Garden",substit: "this is muh subtitle",photo: "tomb.png",pic2: iconName,photoVR: "bg01.jpg")!)
         x.append(PlaceScene(title: "Botanical Garden",substit: "this is muh subtitle",photo: "tomb.png",pic2: iconName,photoVR: "bg02.jpg")!)
         x.append(PlaceScene(title: "Botanical Garden",substit: "this is muh subtitle",photo: "tomb.png",pic2: iconName,photoVR: "bg03.jpg")!)
    case FloatingCard.B:
        iconName = "capi.png"
        x.append(PlaceScene(title: "Taft Carrilon",substit: "this is muh subtitle",photo: "tomb.png",pic2: iconName,photoVR: "taft00.jpg")!)
    case FloatingCard.C:
        iconName = "muse.png"
        x.append(PlaceScene(title: "Museum of the Bible",substit: "this is muh subtitle",photo: "capi.png",pic2: iconName,photoVR: "bible00.jpg")!)
          x.append(PlaceScene(title: "Museum of the Bible",substit: "this is muh subtitle",photo: "tree.png",pic2: iconName,photoVR: "bible01.jpg")!)
          x.append(PlaceScene(title: "Museum of the Bible",substit: "this is muh subtitle",photo: "prot.png",pic2: iconName,photoVR: "bible02.jpg")!)
    case FloatingCard.D:
        iconName = "prot.png"
        x.append(PlaceScene(title: "Women's March",substit: "Feb 27, 2019",photo: "tree.png",pic2: iconName,photoVR: "union.jpg")!)
    case FloatingCard.E:
        iconName = "tomb.png"
        x.append(PlaceScene(title: "oops",substit: "this is muh subtitle",photo: "capi.png",pic2: iconName,photoVR: "verizon01.jpg")!)
    case FloatingCard.F:
        iconName = "tree.png"
        x.append(PlaceScene(title: "The Wharf",substit: "Annual Christmas light boat parade",photo: "prot.png",pic2: iconName,photoVR: "wharf.jpg")!)
    case .NA:
        break
    }
    
    return x
}
