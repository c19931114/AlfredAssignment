//
//  PhotosViewModel.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import Foundation

class PhotosViewModel {
    
    var photos: Observable<[PhotoCollectionViewCellModel]> = Observable([])
    
    init(photos: [GalleryImage]) {
        self.photos.value = photos.compactMap { PhotoCollectionViewCellModel(photo: $0) }
    }
}
