//
//  UITopSubview.swift
//  Pods
//
//  Created by Pilipenko Dima on 10/27/16.
//
//

import Foundation
import UIKit

class UITopSubview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let view = subviews.first, view.frame.contains(point) {
            return view
        }
        return nil
    }
}
