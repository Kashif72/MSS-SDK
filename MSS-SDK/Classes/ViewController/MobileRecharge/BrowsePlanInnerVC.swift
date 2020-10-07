//
//  BrowsePlanInnerVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class BrowsePlanInnerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var innerType = ""
    var plansArray = [PlanModel]()
    
    @IBOutlet var tvPlans: UITableView!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         tvPlans.delegate = self
         tvPlans.dataSource = self
         tvPlans.backgroundColor = UIColor.white

     }
     

     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }
     
    
     
      func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return plansArray.count
     }
     
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "planCell", for: indexPath as IndexPath) as! PlanViewCell
         let planModel = plansArray[indexPath.row]
         cell.lbTitle?.text = planModel.planName
         cell.lbOffer?.text = planModel.description
         cell.lbValidity?.text = planModel.validity
         cell.btnPrice?.setTitle("Rs " + " " + planModel.amount!, for: .normal)
         return cell
     }
     
     @IBAction func btnSelectPlan(_ sender: CustomButton) {
         print("Cehcked")
         if let text = sender.titleLabel?.text {
             print(text)
             _ = self.navigationController?.popViewController(animated: true)
         }
         
     }
     

}


class PlanViewCell: UITableViewCell{
   
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbValidity: UILabel!
    @IBOutlet weak var lbOffer: UILabel!
}
