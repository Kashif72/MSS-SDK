//
//  CityListVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 12/04/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit

class CityListVC: UIViewController,  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {

    @IBOutlet weak var sbCity: UISearchBar!
    
    @IBOutlet weak var tblCity: UITableView!
    
    
    var cityArray = FlightCityModel.flightCityInstance
    
    var selectListner : CitySelecListner? = nil
    var selectType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sbCity.delegate = self
        tblCity.delegate = self
        tblCity.dataSource = self
        
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
              dismiss(animated: false)
       }

    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
    }
       
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
       
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "FlightCityCell", for: indexPath) as! FlightCityCell
        cell.lblAirPortName.text = cityArray[indexPath.row].cityCode
        cell.lblAirPortCode.text = cityArray[indexPath.row].cityName

        return cell
    }
       
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
       {
           return 80
       }
       
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectType == 1){
            selectListner?.onToSelected(to: cityArray[indexPath.row].cityCode)
            
        }else{
            selectListner?.onFromSelected(from: cityArray[indexPath.row].cityCode)
        }
        dismiss(animated: false)
                             
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String)
    {
        
    cityArray = FlightCityModel.flightCityInstance.filter({$0.cityName.contains(searchText) || $0.cityCode.contains(searchText)})
       tblCity.reloadData()
    }

}


class FlightCityCell: UITableViewCell{
    @IBOutlet weak var lblAirPortName: UILabel!
    @IBOutlet weak var lblAirPortCode: UILabel!
}
