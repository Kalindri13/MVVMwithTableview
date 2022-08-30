//
//  ListviewModel.swift
//  MVVMwithTableview
//
//  Created by jigar.patel on 16/06/22.
//

import Foundation

protocol ListViewModelDelegate {
    func dataFoud()
    func errorOccuredWhileLoadigData()
}

class ListViewModel {
    var delegate:ListViewModelDelegate?
    var resultArray = [List]()
    func requestAllDatafromServer() {
        let urlStrig = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=982e05a04b264540b2eb21479047f91a"
        if let url = URL(string: urlStrig) {
            let urlrequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlrequest) { data, response, error in
               // print(" respose is \(response)")
               // print("data is \(data)")
                if let _ = error {
                    self.delegate?.dataFoud()
                    return
                }
                
                
                let decoder = JSONDecoder()
                do  {
                    let results = try decoder.decode(ListObject.self, from: data!)
                    //print("results is \(results)")
                    //print("results cout is  is \(results.articles.count)")
                    self.resultArray.append(contentsOf: results.articles)
                    self.delegate?.dataFoud()

                } catch {
                    self.delegate?.dataFoud()
                   // print("error occured")
                }
               

            }.resume()
        }
        
    }
    

}


