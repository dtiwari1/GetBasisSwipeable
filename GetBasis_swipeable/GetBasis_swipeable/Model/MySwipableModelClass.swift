//
//  MySwipableModelClass.swift
//  GetBasis_swipeable
//
//  Created by TalentMicro on 21/04/20.
//  Copyright © 2020 GetBasis. All rights reserved.
//

import Foundation
class MySwipableModel:Codable{
    var data:[MySwipableModelData]?
}
class MySwipableModelData:Codable{
    var text:String?
    var id:String?
}
