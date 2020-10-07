//
//  SlidingContainerSliderView.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

struct SlidingContainerSliderViewAppearance {
    
    var backgroundColor: UIColor
    
    var font: UIFont
    var selectedFont: UIFont
    
    var textColor: UIColor
    var selectedTextColor: UIColor
    
    var outerPadding: CGFloat
    var innerPadding: CGFloat
    
    var selectorColor: UIColor
    var selectorHeight: CGFloat
    
    var fixedWidth: Bool
}

protocol SlidingContainerSliderViewDelegate {
    func slidingContainerSliderViewDidPressed (_ slidingtContainerSliderView: SlidingContainerSliderView, atIndex: Int)
}

class SlidingContainerSliderView: UIScrollView, UIScrollViewDelegate {
    
    // MARK: Properties
    
    var appearance: SlidingContainerSliderViewAppearance! {
        didSet {
            draw()
        }
    }
    
    @objc var shouldSlide: Bool = true
    
    @objc let sliderHeight: CGFloat = 44
    @objc var titles: [String]!
    
    @objc var labels: [UILabel] = []
    @objc var selector: UIView!
    
    var sliderDelegate: SlidingContainerSliderViewDelegate?
    
    
    // MARK: Init
    
    @objc init (width: CGFloat, titles: [String]) {
        super.init(frame: CGRect (x: 0, y: 0, width: width, height: sliderHeight))
        self.titles = titles
        
        delegate = self
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        scrollsToTop = false
        
        appearance = SlidingContainerSliderViewAppearance (
            backgroundColor: ColorConverter.hexStringToUIColor(hex: ColorCode.navigationColor),
            
            font: UIFont (name: "CenturyGothic-bold", size: 15)!,
            selectedFont: UIFont.systemFont(ofSize: 15),
            
            textColor: ColorConverter.hexStringToUIColor(hex: ColorCode.tab_not_selcted),
            selectedTextColor: ColorConverter.hexStringToUIColor(hex: ColorCode.selectedTabColor),
            
            outerPadding: 10,
            innerPadding: 10,
            
            selectorColor: ColorConverter.hexStringToUIColor(hex: ColorCode.selectedTabColor),
            selectorHeight: 2,
            fixedWidth: false)
        
        
        draw()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    // MARK: Draw
    
    @objc func draw () {
        
        // clean
        if labels.count > 0 {
            for label in labels {
                
                label.removeFromSuperview()
                
                if selector != nil {
                    selector.removeFromSuperview()
                    selector = nil
                }
            }
        }
        
        labels = []
        backgroundColor = appearance.backgroundColor
        
        if appearance.fixedWidth {
            var labelTag = 0
            let width = CGFloat(frame.size.width) / CGFloat(titles.count)
            
            for title in titles {
                let label = labelWithTitle(title)
                label.frame.origin.x = (width * CGFloat(labelTag))
                label.frame.size = CGSize(width: width, height: label.frame.size.height)
                label.center.y = frame.size.height/2
                labelTag += 1
                label.tag = labelTag
                
                addSubview(label)
                labels.append(label)
            }
            
            let selectorH = appearance.selectorHeight
            selector = UIView (frame: CGRect (x: 0, y: frame.size.height - selectorH, width: width, height: selectorH))
            selector.backgroundColor = appearance.selectorColor
            addSubview(selector)
            
            contentSize = CGSize (width: frame.size.width, height: frame.size.height)
        } else {
            var labelTag = 0
            var currentX = appearance.outerPadding
            
            for title in titles {
                let label = labelWithTitle(title)
                label.frame.origin.x = currentX
                label.center.y = frame.size.height/2
                labelTag += 1
                label.tag = labelTag
                
                addSubview(label)
                labels.append(label)
                currentX += label.frame.size.width + appearance.outerPadding
            }
            
            let selectorH = appearance.selectorHeight
            selector = UIView (frame: CGRect (x: 0, y: frame.size.height - selectorH, width: 100, height: selectorH))
            selector.backgroundColor = appearance.selectorColor
            addSubview(selector)
            
            contentSize = CGSize (width: currentX, height: frame.size.height)
        }
        
    }
    
    @objc func labelWithTitle (_ title: String) -> UILabel {
        
        let label = UILabel (frame: CGRect (x: 0, y: 0, width: 0, height: 0))
        label.text = title
        label.font = appearance.font
        label.textColor = appearance.textColor
        label.textAlignment = .center
        
        label.sizeToFit()
        label.frame.size.width += appearance.innerPadding * 2
        
        label.addGestureRecognizer(UITapGestureRecognizer (target: self, action: #selector(SlidingContainerSliderView.didTap(_:))))
        label.isUserInteractionEnabled = true
        
        return label
    }
    
    
    // MARK: Actions
    
    @objc func didTap (_ tap: UITapGestureRecognizer) {
        self.sliderDelegate?.slidingContainerSliderViewDidPressed(self, atIndex: tap.view!.tag - 1)
    }
    
    
    // MARK: Menu
    
    @objc func selectItemAtIndex (_ index: Int) {
        
        // Set Labels
        
        for i in 0..<self.labels.count {
            let label = labels[i]
            
            if i == index {
                
                label.textColor = appearance.selectorColor
                label.font = appearance.selectedFont
                
                if !appearance.fixedWidth {
                    label.sizeToFit()
                    label.frame.size.width += appearance.innerPadding * 2
                }
                
                // Set selector
                
                UIView.animate(withDuration: 0.3, animations: {
                    [unowned self] in
                    self.selector.frame = CGRect (
                        x: label.frame.origin.x,
                        y: self.selector.frame.origin.y,
                        width: label.frame.size.width,
                        height: self.appearance.selectorHeight)
                })
                
            } else {
                
                label.textColor = appearance.textColor
                label.font = appearance.font
                if !appearance.fixedWidth {
                    label.sizeToFit()
                    label.frame.size.width += appearance.innerPadding * 2
                }
            }
        }
    }
    
}



