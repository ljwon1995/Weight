//
//  DataViewController.swift
//  Weight
//
//  Created by USER on 2021/03/01.
//

import UIKit

class DataViewController: UIViewController {
    
    let dataViewModel = DataViewModel()
    
    @IBOutlet weak var weightTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightTableView.dataSource = self
        
        dataViewModel.setListenerToWeightData {
            self.weightTableView.reloadData()
        }
        
        dataViewModel.setDummyData()
    }
}

extension DataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.totalDataNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weightInfoCell = weightTableView.dequeueReusableCell(withIdentifier: "WeightInfoCell", for: indexPath) as? WeightInfoCell else { return UITableViewCell() }
        
        dataViewModel.setWeightInfo(withDataIndex: indexPath.row) { weight in
            weightInfoCell.amountLabel.text = "\(String(weight.amount))KG"
        }
        
        return weightInfoCell
    }
}
