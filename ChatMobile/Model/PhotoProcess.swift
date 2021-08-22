//
//  PhotoProcess.swift
//  ChatMobile
//
//  Created by Amir Sayyar on 2021-07-03.
//

import Foundation
import Photos
import UIKit
class PhotoProcess  {
    var photos : [UIImage] = [UIImage]()
    // This is for more custom selection and if the user wants to edit a photo
//
    func getPhotoFromLibrary(_ group : DispatchGroup){
        let manager = PHImageManager.default()
        let reqOptions = PHImageRequestOptions()
        let fetchOptions = PHFetchOptions()
        reqOptions.isSynchronous = false
        reqOptions.deliveryMode = .fastFormat
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let results : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if results.count > 0 {
            print(32)
            for i in 0..<results.count{
                let asset = results.object(at: i)
                let size = CGSize(width: 300, height: 200)
                group.enter()
                DispatchQueue.global(qos: .default).async {
                    manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: reqOptions) { (image,_) in
                        if let image = image {
                            print(37)
                            self.photos.append(image)
                            group.leave()
                        }
                    }
                }
            }
        }else{
            print("No Image Found")
        }
    }
    
    
 
}
