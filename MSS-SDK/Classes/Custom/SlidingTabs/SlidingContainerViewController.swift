//
//  SlidingContainerViewController.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

@objc protocol SlidingContainerViewControllerDelegate {
    @objc optional func slidingContainerViewControllerDidMoveToViewController (_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController, atIndex: Int)
    @objc optional func slidingContainerViewControllerDidHideSliderView (_ slidingContainerViewController: SlidingContainerViewController)
    @objc optional func slidingContainerViewControllerDidShowSliderView (_ slidingContainerViewController: SlidingContainerViewController)
}

class SlidingContainerViewController: UIViewController, UIScrollViewDelegate, SlidingContainerSliderViewDelegate {
    
    @objc var contentViewControllers: [UIViewController]!
    @objc var contentScrollView: UIScrollView!
    @objc var titles: [String]!
    
    @objc var sliderView: SlidingContainerSliderView!
    @objc var sliderViewShown: Bool = true
    
    @objc var delegate: SlidingContainerViewControllerDelegate?
    
    
    // MARK: Init
    
    @objc init (parent: UIViewController, contentViewControllers: [UIViewController], titles: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.contentViewControllers = contentViewControllers
        self.titles = titles
        
        
        // Move to parent
        
        willMove(toParentViewController: parent)
        parent.addChildViewController(self)
        didMove(toParentViewController: parent)
        
        
        // Setup Views
        
        sliderView = SlidingContainerSliderView (width: view.frame.size.width, titles: titles)
        sliderView.frame.origin.y = parent.view.safeAreaInsets.top
        sliderView.sliderDelegate = self
        
        contentScrollView = UIScrollView (frame: view.frame)
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.scrollsToTop = false
        contentScrollView.delegate = self
        contentScrollView.contentSize.width = contentScrollView.frame.size.width * CGFloat(contentViewControllers.count)
        
        
        
        view.addSubview(contentScrollView)
        view.addSubview(sliderView)
        
        
        // Add Child View Controllers
        
        var currentX: CGFloat = 0
        for vc in contentViewControllers {
            vc.view.frame = CGRect (
                x: currentX,
                y: parent.view.safeAreaInsets.top,
                width: view.frame.size.width,
                height: view.frame.size.height - parent.view.safeAreaInsets.top - parent.view.safeAreaInsets.bottom)
            contentScrollView.addSubview(vc.view)
            
            currentX += contentScrollView.frame.size.width
        }
        
        
        // Move First Item
        
        setCurrentViewControllerAtIndex(0)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: ChildViewController Management
    
    @objc func setCurrentViewControllerAtIndex (_ index: Int) {
        
        for i in 0..<self.contentViewControllers.count {
            let vc = contentViewControllers[i]
            
            if i == index {
                
                vc.willMove(toParentViewController: self)
                addChildViewController(vc)
                vc.didMove(toParentViewController: self)
                
                delegate?.slidingContainerViewControllerDidMoveToViewController? (self, viewController: vc, atIndex: index)
            } else {
                
                vc.willMove(toParentViewController: self)
                vc.removeFromParentViewController()
                vc.didMove(toParentViewController: self)
            }
        }
        
        sliderView.selectItemAtIndex(index)
        contentScrollView.setContentOffset(
            CGPoint (x: contentScrollView.frame.size.width * CGFloat(index), y: 0),
            animated: true)
        
        navigationController?.navigationItem.title = titles[index]
    }
    
    
    // MARK: SlidingContainerSliderViewDelegate
    
    @objc func slidingContainerSliderViewDidPressed(_ slidingContainerSliderView: SlidingContainerSliderView, atIndex: Int) {
        sliderView.shouldSlide = false
        setCurrentViewControllerAtIndex(atIndex)
    }
    
    
    // MARK: SliderView
    
    @objc func hideSlider () {
        
        if !sliderViewShown {
            return
        }
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        [unowned self] in
                        self.sliderView.frame.origin.y += self.parent!.view.safeAreaInsets.top + self.sliderView.frame.size.height
            },
                       completion: {
                        [unowned self] finished in
                        self.sliderViewShown = false
                        self.delegate?.slidingContainerViewControllerDidHideSliderView? (self)
        })
    }
    
    @objc func showSlider () {
        
        if sliderViewShown {
            return
        }
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        [unowned self] in
                        self.sliderView.frame.origin.y -= self.parent!.view.safeAreaInsets.top + self.sliderView.frame.size.height
            },
                       completion: {
                        [unowned self] finished in
                        self.sliderViewShown = true
                        self.delegate?.slidingContainerViewControllerDidShowSliderView? (self)
        })
    }
    
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.state == .began {
            sliderView.shouldSlide = true
        }
        
        let contentW = contentScrollView.contentSize.width - contentScrollView.frame.size.width
        let sliderW = sliderView.contentSize.width - sliderView.frame.size.width
        
        let current = contentScrollView.contentOffset.x
        let ratio = current / contentW
        
        if sliderView.contentSize.width > sliderView.frame.size.width && sliderView.shouldSlide == true {
            sliderView.contentOffset = CGPoint (x: sliderW * ratio, y: 0)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / contentScrollView.frame.size.width
        setCurrentViewControllerAtIndex(Int(index))
    }
}

extension UIGestureRecognizer.State {
    public var description: String {
        get {
            switch self {
            case .began:
                return "Began"
            case .cancelled:
                return "Cancelled"
            case .changed:
                return "Changed"
            case .ended:
                return "Ended"
            case .failed:
                return "Failed"
            case .possible:
                return "Possible"
            default:
                return ""
                
            }
        }
    }
}


