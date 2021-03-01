//
//  DataViewController.swift
//  Weight
//
//  Created by USER on 2021/03/01.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var weightTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightTableView.dataSource = self
        weightTableView.delegate = self
    }
}

extension DataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return weightTableView.dequeueReusableCell(withIdentifier: "WeightCell", for: indexPath)
    }
}

extension DataViewController: UITableViewDelegate {
    
}
