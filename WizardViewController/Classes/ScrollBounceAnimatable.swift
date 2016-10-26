//
//  ScrollBounceAnimatable.swift
//  Pods
//
//  Created by Pilipenko Dima on 10/20/16.
//
//

import Foundation
import UIKit

public protocol ScrollBounceAnimatable: class {
    var scrollViewDidDragging: ((_ percent: CGFloat, _ direction: CGPoint?) -> Void)? { get set }
    var scrollViewDidEndDragging: ((_ percent: CGFloat, _ direction: CGPoint?) -> Void)? { get set }
}
