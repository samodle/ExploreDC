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
    
    switch thingy{
    case FloatingCard.A:
        x.append(PlaceScene(title: "",substit: "",photo: "",pic2: "",photoVR: "")!)
    case FloatingCard.B:
        x.append(PlaceScene(title: "",substit: "",photo: "",pic2: "",photoVR: "")!)
    case FloatingCard.C:
        x.append(PlaceScene(title: "",substit: "",photo: "",pic2: "",photoVR: "")!)
    case FloatingCard.D:
        x.append(PlaceScene(title: "",substit: "",photo: "",pic2: "",photoVR: "")!)
    case FloatingCard.E:
        x.append(PlaceScene(title: "",substit: "",photo: "",pic2: "",photoVR: "")!)
    case FloatingCard.F:
        x.append(PlaceScene(title: "",substit: "",photo: "",pic2: "",photoVR: "")!)
    case .NA:
        break
    }
    
    return x
}
