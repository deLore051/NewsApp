//
//  UIButton+Additions.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 31.10.21..
//

import UIKit

extension UIButton {
    
    public func tapEffect(sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            sender.alpha = 1
        }
    }
}

