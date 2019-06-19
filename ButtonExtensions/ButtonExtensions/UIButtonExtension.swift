//
//  UIButtonExtension.swift
//  ButtonExtensions
//
//  Created by Bruno Amezcua on 6/19/19.
//  Copyright © 2019 Bruno Amezcua. All rights reserved.
//

import UIKit

extension UIButton {
    
    // Bordes redondos
    func round(){
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    // Brilla al oprimir
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
}
