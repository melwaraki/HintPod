//
//  Extensions.swift
//  Pods
//
//  Created by Marawan Alwaraki on 23/03/2019.
//

import Foundation

extension UIView {
    
    func setCard() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        
        //        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 6).cgPath
    }
}
