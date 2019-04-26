//
//  UIHelper.swift
//  Off-Places
//
//  Created by Esraa on 4/26/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UISegmentedControl {
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
}
