//
//  UIButton+Extensions.swift
//  FreeWheelinTest
//
//  Created by Wangak Kim on 2021/03/27.
//  Copyright © 2021 Wangak Kim. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(.init(width: 1.f, height: 1.f))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(.init(x: 0, y: 0, width: 1.f, height: 1.f))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
}
