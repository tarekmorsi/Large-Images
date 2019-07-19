//
//  CollectionPage.swift
//  LargeImagesApp
//
//  Created by Tarek Morsi on 7/17/19.
//  Copyright © 2019 Tarek Morsi. All rights reserved.
//

import UIKit

class CollectionPage: UIViewController {
    
    let imageDir = UIImageDirectory()
    
    @IBOutlet weak var collectionView: UICollectionView!

//   Images names to be added in the collection view
//   (add the names of the images you wish to be also
//   added in the array below after adding to the
//   project)
    
    var image_names = ["St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif", "St-Benoit-du-Lac-Quebec.tif"] as [String];


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
}

extension CollectionPage: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_names.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as UICollectionViewCell
        let i = indexPath.row
        let cell_size = cell.frame.size
        
        let imageView: UIImageView =  cell.viewWithTag(10) as! UIImageView
        
        
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
    
        return cell
    }
    
}
