//
//  Decider.swift
//  Pods
//
//  Created by Pilipenko Dima on 10/27/16.
//
//

import Foundation
import UIKit

class Decider<T> {
    typealias Key = T
    
    var deciderable: Deciderable!
    var assigned: Key?
    
    init(value: Deciderable) {
        deciderable = value
    }
    
    func assign(_ value: Key) {}
    func remove() {}
    
    deinit {
        deciderable = nil
        assigned = nil
    }
}

class UIViewDecider<T>: Decider<T> where Decider<T>.Key: UIView {
    override func assign(_ value: Key) {
        guard value != assigned else {
            return
        }

        remove()
        
        assigned = value
        deciderable.addView(value)
    }
    
    override func remove() {
        if let view = assigned as? UIView {
            view.removeFromSuperview()
        }
        
        assigned = nil
    }
}

class UIViewControllerDecider<T>: Decider<T> where Decider<T>.Key: UIViewController {
    override func assign(_ value: Key) {
        guard value != assigned else {
            return
        }
        
        remove()
        
        assigned = value
        deciderable.addViewController(value)
    }
    
    override func remove() {
        if let vc = assigned as? UIViewController {
            vc.removeFromParentViewController()
            vc.didMove(toParentViewController: nil)
            
            // remove view from superview if loaded, it's for optimization like in `addViewAndSiblings`
            if vc.isViewLoaded {
                vc.view.removeFromSuperview()
            }
        }
        
        assigned = nil
    }
}

protocol Deciderable {
    func addViewController(_ value: UIViewController)
    func addView(_ value: UIView)
}
