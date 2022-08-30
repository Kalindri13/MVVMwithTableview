//
//  ViewController.swift
//  MVVMwithTableview
//
//  Created by jigar.patel on 16/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ListTableview: UITableView!
    let viewModel = ListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.requestAllDatafromServer()
    }
}

extension ViewController:ListViewModelDelegate {
    func dataFoud() {
        DispatchQueue.main.async {
            self.ListTableview.reloadData()
        }
        
    }
    
    func errorOccuredWhileLoadigData() {
        // do notinng
    }
    
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell") as! listcell
        let cellData = viewModel.resultArray[indexPath.row]
        cell.selectionStyle = .none
        cell.configureData(listObect: cellData)
        return cell
    }
}
