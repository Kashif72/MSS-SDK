//
//  MobilePlanVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar

class MobilePlanVC: UIViewController,SlidingContainerViewControllerDelegate {
   
    @IBOutlet weak var mainView: UIView!
    var opCode: String = ""
    var circleCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorConverter.hexStringToUIColor(hex: ColorCode.bgColor)
        
        self.showLoading(view: self.view, text: "Please wait")
        
        var req = PlanRequest()
        req.circleCode = circleCode
        req.serviceProvider = opCode
        
        APIHandler.sharedInstance.getMobilePlans(loginReq: req, success: { (sessionId) in
            //Success
            self.stopLoading(fromView: self.view)
            self.fillView()
            
        }, failure: { (message) in
            self.stopLoading(fromView: self.view)
            self.showError(message: message!)
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onClickBack(_:)), name: Notification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil)
    }
    
    func fillView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller1 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller1?.innerType = "Full Talktime"
        controller1?.plansArray = PlanModel.fTUniqueI
        
        let controller2 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller2?.innerType = "Special Recharge"
        controller2?.plansArray = PlanModel.specialUniqueI
        
        let controller3 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as?BrowsePlanInnerVC
        controller3?.innerType = "2G Data"
        controller3?.plansArray = PlanModel.TwoGUniqueI
        
        let controller4 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller4?.innerType = "3G Data"
        controller4?.plansArray = PlanModel.ThreeGUniqueI
        
        let controller5 = storyboard.instantiateViewController(withIdentifier: "browsePlanInnerVc") as? BrowsePlanInnerVC
        controller5?.innerType = "Top up"
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
        dismiss(animated: false)
        
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
    
    
     private func showLoading(view:UIView, text:String){
           let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
           loadingNotification.mode = MBProgressHUDMode.indeterminate
       }
       
       
       private func stopLoading(fromView:UIView){
           MBProgressHUD.hide(for: fromView, animated: true)
       }
    
    func showError(message: String){
          let snackbar = TTGSnackbar(message: message, duration: .short)
          snackbar.animationType = .slideFromTopBackToTop
          snackbar.backgroundColor = ColorConverter.hexStringToUIColor(hex: ColorCode.txtError)
          snackbar.show()
      }
    
    
    
}

