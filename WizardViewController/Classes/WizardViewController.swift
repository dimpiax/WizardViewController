//
//  TutorialViewController.swift
//  Snkrboard
//
//  Created by Pilipenko Dima on 10/20/16.
//  Copyright © 2016 dimpiax. All rights reserved.
//

import Foundation
import UIKit

public final class WizardViewController: UIViewController, UIScrollViewDelegate, ScrollBounceAnimatable {
    // * ScrollBounceAnimatable
    public var scrollViewDidDragging: ((_ percent: CGFloat, _ direction: CGPoint?) -> Void)?
    public var scrollViewDidEndDragging: ((_ percent: CGFloat, _ direction: CGPoint?) -> Void)?
    
    public var pageIndicatorColors: ((_ currentPage: Int) -> (UIColor?, UIColor?))?
    
    public var defaultPageIndex = 0
    
    public var currentPageIndex: Int? = nil {
        willSet {
            guard let arr = getContentArray() else {
                return
            }
            
            if currentPageIndex != newValue {
                if let curIndex = currentPageIndex {
                    arr[curIndex]?.pageWillDisappear(animated: true)
                }
                
                if let nextIndex = newValue {
                    addViewAndSiblings(nextIndex)
                    arr[nextIndex]?.pageWillAppear(animated: true)
                }
            }
        }
        didSet {
            setupPageIndicatorColors()
            _pageControl.currentPage = currentPageIndex ?? defaultPageIndex
        }
    }
    
    fileprivate var _scrollView: UIScrollView!
    fileprivate var _pageControl: UIPageControl!
    
    fileprivate var _viewControllers: [UIViewController]?
    fileprivate var _views: [UIView?]!
    
    override public func loadView() {
        super.loadView()
        
        _scrollView = UIScrollView()
        _pageControl = UIPageControl()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        _scrollView.isPagingEnabled = true
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.delegate = self
        view.addSubview(_scrollView)
        
        _pageControl.hidesForSinglePage = true
        setupPageIndicatorColors()
        view.addSubview(_pageControl)
        
        // reload data if _views is filled
        reloadData()
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layoutScrollView()
        layoutPageControl()
        
        if let views = _views, let curIndex = currentPageIndex, curIndex < views.count {
            if let view = views[curIndex] {
                _scrollView.contentOffset.x = view.frame.minX
            }
        }
    }
    
    public func setViewControllers(_ value: [UIViewController]) {
        _viewControllers = value
        _views = [UIView?](repeating: nil, count: value.count)
    }
    
    public func setViews(_ value: [UIView]) {
        _viewControllers = nil
        _views = value
        
        reloadData()
    }
    
    public func clear() {
        _viewControllers = nil
        _views = nil
    }
    
    // DELEGATES
    // * UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let views = _views else {
            return
        }
        
        let x = scrollView.contentOffset.x
        
        var nilCount = 0
        for index in 0..<currentPageIndex! {
            if _views[index] == nil {
                nilCount += 1
            }
        }
        
        let pagesCountOffset = CGFloat(nilCount)
        let pagesWidthOffset = pagesCountOffset * scrollView.bounds.width
        
        var pageIndex = Int(round((x + pagesWidthOffset) / scrollView.bounds.width))
        
        pageIndex = max(0, min(views.count-1, pageIndex)) // normalize
        currentPageIndex = pageIndex
        
        if let f = scrollViewDidDragging {
            f(getScrollViewOffset(scrollView), .zero)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let f = scrollViewDidEndDragging {
            f(getScrollViewOffset(scrollView), .zero)
        }
    }
    
    // PRIVATE
    fileprivate func reloadData() {
        guard isViewLoaded else {
            return
        }
        
        currentPageIndex = nil
        
        childViewControllers.forEach {
            $0.removeFromParentViewController()
            $0.didMove(toParentViewController: nil)
        }
        _viewControllers?.forEach { vc in
            vc.removeFromParentViewController()
            vc.didMove(toParentViewController: nil)
            
            // remove view from superview if loaded, it's for optimization like in `addViewAndSiblings`
            if vc.isViewLoaded {
                vc.view.removeFromSuperview()
            }
        }
        
        // remove views from scroll view
        _scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        // refresh page
        currentPageIndex = defaultPageIndex
        
        layoutPageControl()
        layoutScrollView()
    }
    
    fileprivate func layoutScrollView() {
        layoutScrollViews()
        
        _scrollView.frame = view.bounds
    }
    
    fileprivate func layoutPageControl() {
        _pageControl.numberOfPages = _views?.count ?? 0
        
        _pageControl.center = view.center
        _pageControl.frame.origin.y = view.bounds.height * 0.95
    }
    
    fileprivate func layoutScrollViews() {
        if let views = _views {
            var prevRect: CGRect?
            for case let value? in views {
                value.frame = CGRect(x: prevRect?.maxX ?? 0, y: 0, width: view.bounds.width, height: view.bounds.height)
                prevRect = value.frame
            }
            
            if let lastItem = prevRect {
                _scrollView.contentSize = CGSize(width: lastItem.maxX, height: lastItem.maxY)
            }
        }
        else {
            _scrollView.contentSize = .zero
        }
    }
    
    fileprivate func addViewAndSiblings(_ index: Int) {
        var isNeedLayout = false
        
        if let vcs = _viewControllers {
            for directionIndex in [-1, 0, 1] {
                let curIndex = index+directionIndex
                if curIndex >= 0 && curIndex < vcs.count {
                    let vc = vcs[curIndex]
                    
                    if vc.parent == nil {
                        addChildViewController(vc)
                        vc.didMove(toParentViewController: self)
                    }
                    
                    if vc.isViewLoaded == false || vc.view.superview == nil {
                        let view = vc.view
                        _scrollView.insertSubview(view!, at: curIndex)
                        _views[curIndex] = view
                        
                        isNeedLayout = true
                    }
                }
            }
        }
        else if let views = _views {
            for directionIndex in [-1, 0, 1] {
                let curIndex = index+directionIndex
                
                if curIndex >= 0 && curIndex < views.count {
                    guard let view = views[curIndex] else {
                        continue
                    }
                    
                    if view.superview == nil {
                        _scrollView.insertSubview(view, at: curIndex)
                        isNeedLayout = true
                    }
                }
            }
        }
        
        if isNeedLayout {
            layoutScrollViews()
        }
    }
    
    fileprivate func getScrollViewOffset(_ scrollView: UIScrollView) -> CGFloat {
        guard let currentPageIndex = currentPageIndex, let vcs = _viewControllers , currentPageIndex == vcs.count-1 else {
            return 0
        }
        return scrollView.contentOffset.x / scrollView.bounds.width - CGFloat(currentPageIndex)
    }
    
    fileprivate func setupPageIndicatorColors() {
        var colors: (common: UIColor, current: UIColor) = (.white, .black)
        if let pageIndicatorColorsSetup = pageIndicatorColors, let pageIndex = currentPageIndex {
            let result = pageIndicatorColorsSetup(pageIndex)
            if let common = result.0 {
                colors.common = common
            }
            
            if let current = result.1 {
                colors.current = current
            }
        }
        
        _pageControl.pageIndicatorTintColor = colors.common
        _pageControl.currentPageIndicatorTintColor = colors.current
    }
    
    fileprivate func getContentArray() -> [WizardPageContent?]? {
        var contentArray: [WizardPageContent?]?
        if let vcs = _viewControllers {
            contentArray = vcs.map { $0 as? WizardPageContent }
        }
        else if let views = _views {
            contentArray = views.map { $0 as? WizardPageContent }
        }
        
        return contentArray
    }
    
    deinit {
        if let curIndex = currentPageIndex {
            (_viewControllers?[curIndex] as? WizardPageContent)?.pageWillDisappear(animated: true)
        }
        
        _scrollView = nil
        _pageControl = nil
        
        _views = nil
    }
}
