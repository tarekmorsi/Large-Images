//
//  ViewController.swift
//  LargeImagesApp
//
//  Created by Tarek Morsi on 7/17/19.
//  Copyright © 2019 Tarek Morsi. All rights reserved.
//

import UIKit

class TablePage: UIViewController {

    var imageDir = UIImageDirectory()
    
    
//   Images names to be added in the table view
//   (add the names of the images you wish to be also
//   added in the array below after adding to the
//   project)
    
    @IBOutlet weak var tableView: UITableView!
    var image_names : [String] = ["St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif"];

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
}

extension TablePage: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return image_names.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "TableCell")
        let i = indexPath.row
        let cell_size = cell!.frame.size

        let imageView: UIImageView =  cell?.viewWithTag(10) as! UIImageView
        
        DispatchQueue.global(qos: .default).async {
            if(self.imageDir.contains(imageName: self.image_names[i]) == false){
                if var image = UIImage(named: self.image_names[i]) {
                    image = image.resizeImage(targetSize: cell_size)
                    self.imageDir.add(image: image, imageName: self.image_names[i])
                }
            }
            
            DispatchQueue.main.async{
                imageView.image = self.imageDir.read(imageName: self.image_names[i])
            }
        }
        
        return cell!;
    }
    
}


