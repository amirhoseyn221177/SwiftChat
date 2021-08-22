//
//  PhotoCollectionsUI.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-08-17.
//

import Foundation
import UIKit


class PhotoCollectionUI : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    weak var collectionView : UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.isHidden = true
            collectionView.register(UINib(nibName: "imagesGalleyCell", bundle: nil), forCellWithReuseIdentifier: "gallery")
        }
    }
    var photos : [UIImage] = [UIImage()]
    var photoProccess = PhotoProcess()
    
    override func viewDidLoad() {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gallery", for: indexPath) as! imagesGalleyCell
        cell.GalleryImage.image = photos[indexPath.row]
        return cell
    }
    
    func getphoto (completion : @escaping(Result<[UIImage],Error>)->Void){
        let group = DispatchGroup()
        photoProccess.getPhotoFromLibrary(group)
        group.notify(queue : .global()){
            self.photos = self.photoProccess.photos
            completion(.success(self.photoProccess.photos))
            }
        
    }

    
}
