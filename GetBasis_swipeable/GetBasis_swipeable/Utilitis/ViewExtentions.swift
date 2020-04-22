//
//  ViewExtentions.swift
//  GetBasis_swipeable
//
//  Created by TalentMicro on 21/04/20.
//  Copyright © 2020 GetBasis. All rights reserved.
//
import Foundation
import UIKit
extension UIView{
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius
      layer.cornerRadius = 5.0
      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
