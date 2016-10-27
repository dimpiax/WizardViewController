//
//  ViewController.swift
//  WizardViewController
//
//  Created by Pilipenko Dima on 10/20/2016.
//  Copyright (c) 2016 Pilipenko Dima. All rights reserved.
//

import UIKit
import WizardViewController

class ViewController: UIViewController {
    private var _wizardVC: WizardViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _wizardVC = WizardViewController()
        _wizardVC.modalTransitionStyle = .coverVertical
        _wizardVC.modalPresentationStyle = .overCurrentContext
        
        // setup page indicators
        _wizardVC.pageIndicatorColors = {[unowned self] currentPageIndex in
            let value: UIColor

            if let color = self._wizardVC.getView(index: currentPageIndex)?.backgroundColor {
                var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
                color.getRed(&r, green: &g, blue: &b, alpha: &a)
                
                // inverse color
                value = UIColor(red: 1-r, green: 1-g, blue: 1-b, alpha: 1)
            }
            else {
                switch currentPageIndex {
                    case 1: value = .darkGray
                    case 2: value = .gray
                    default: value = .black
                }

            }

            return (nil, value)
        }
        
        // set views
        _wizardVC.setViews([B(), B(), B()])
        
        // or
        
        // set view controllers
        _wizardVC.setViewControllers([A(), A(), A(), A()])
        
        // set custom view on top subview
        let button = UIButton(type: .custom)
        button.setTitle("skip", for: .normal)
        button.sizeToFit()
        button.frame.origin.y = view.bounds.height - button.bounds.height - 50
        button.frame.size.width = view.bounds.width
        button.addTarget(self, action: #selector(closeTutorial), for: .touchUpInside)
        
        _wizardVC.setTop(view: button)
        
        // run present after timeout
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showTutorial), userInfo: nil, repeats: false)
    }
    
    func showTutorial() {
        present(_wizardVC, animated: true, completion: nil)
    }
    
    func closeTutorial() {
        _wizardVC.dismiss(animated: true) {[unowned self] in
            self._wizardVC = nil
        }
    }
    
    deinit {
        // clear resources after usage
        _wizardVC.clear()
        _wizardVC = nil
    }
}

final class B: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: CGFloat(randOf(limit: 255))/255, green: CGFloat(randOf(limit: 255))/255, blue: CGFloat(randOf(limit: 255))/255, alpha: CGFloat(randOf(limit: 255))/255)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class A: UIViewController, WizardPageContent {
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: CGFloat(randOf(limit: 255))/255, green: CGFloat(randOf(limit: 255))/255, blue: CGFloat(randOf(limit: 255))/255, alpha: 1)
        
        label.textAlignment = .center
        view.addSubview(label)
    }
    
    override func viewWillLayoutSubviews() {
        label.frame.size = view.bounds.size
        label.font = UIFont.systemFont(ofSize: view.bounds.width, weight: UIFontWeightBlack)
        label.text = String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: randOf(limit: alphabet.characters.count))])
    }
    
    func pageWillAppear(animated: Bool) {
        //label.font = UIFont.systemFont(ofSize: view.bounds.width, weight: UIFontWeightBlack)
        //label.text = String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: randOf(limit: alphabet.characters.count))])
    }
    
    func pageWillDisappear(animated: Bool) {
        //label.font = UIFont.systemFont(ofSize: view.bounds.width*0.8, weight: UIFontWeightBlack)
    }
}

fileprivate func randOf(limit: Int) -> Int {
    return Int(arc4random_uniform(UInt32(limit)))
}
