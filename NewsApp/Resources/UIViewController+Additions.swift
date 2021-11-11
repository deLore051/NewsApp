//
//  UIViewController+Additions.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 11.11.21..
//

import UIKit

private var activityView: UIView?

extension UIViewController {
    
    func showSpinner() {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        guard let aView = activityView else { return }
        activityIndicator.center = aView.center
        activityIndicator.startAnimating()
        aView.addSubview(activityIndicator)
        self.view.addSubview(aView)
    }
    
    func removeSpinner() {
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
}
