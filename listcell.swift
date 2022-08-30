//
//  listcell.swift
//  MVVMwithTableview
//
//  Created by jigar.patel on 21/06/22.
//

import UIKit

class listcell: UITableViewCell {
    
    @IBOutlet weak var imgList: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureData(listObect:List) {
        lblTitle.text = listObect.title
        lblDescription.text = listObect.description
        if let url = listObect.imageUrl {
            downloadImage(from: url)
        }
    }
    
    func downloadImage(from url: URL) {
       // print("Download Started")
       // print("Download url is \(url)")

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
           // print(response?.suggestedFilename ?? url.lastPathComponent)
            //print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imgList.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func addCornerRadiousToImageView() {
        self.imgList.layer.cornerRadius = 16
    }
    
    //func loadListImage

}
