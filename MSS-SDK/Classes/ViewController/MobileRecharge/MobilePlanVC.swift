//
//  MobilePlanVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class MobilePlanVC: UIViewController,SlidingContainerViewControllerDelegate {

    @IBOutlet weak var mainView: UIView!
    var opCode: String = ""
    var circleCode: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorConverter.hexStringToUIColor(hex: ColorCode.bgColor)
        
        self.fillView()
    }
    
    func fillView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller1 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller1?.innerType = "FullTalkTime"
        controller1?.plansArray = PlanModel.fTUniqueI
        
        let controller2 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller2?.innerType = "SPECIAL"
        controller2?.plansArray = PlanModel.specialUniqueI
        
        let controller3 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as?BrowsePlanInnerVC
        controller3?.innerType = "2G"
        controller3?.plansArray = PlanModel.TwoGUniqueI
        
        let controller4 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller4?.innerType = "3G"
        controller4?.plansArray = PlanModel.ThreeGUniqueI
        
        let controller5 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller5?.innerType = "TOPUP"
        controller5?.plansArray = PlanModel.TopUpGUniqueI
        
        let slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [controller1!,controller2!,controller3!,controller4!,controller5!],
            titles: ["FULL TALKTIME", "SPECIAL", "2G","3G","TOPUP"])
        
        mainView.addSubview(slidingContainerViewController.view)
        
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 50
        slidingContainerViewController.sliderView.appearance.fixedWidth = false
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
    }
    

    @IBAction func onClickBack(_ sender: Any) {
    }
    
    // MARK: SlidingContainerViewControllerDelegate
    
    func slidingContainerViewControllerDidShowSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewController(_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewControllerAtIndex(_ slidingContainerViewController: SlidingContainerViewController, index: Int) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
