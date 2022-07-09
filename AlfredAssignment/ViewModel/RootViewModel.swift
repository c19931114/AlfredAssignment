//
//  RootViewModel.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import Foundation

class RootViewModel {
    
    var layout: Observable<Layout>
    var page: Observable<Int>
    var galleries: Observable<[GalleryCollectionViewCellModel]> = Observable([])
    
    init() {
        self.layout = Observable(.list)
        self.page = Observable(0)
        self.galleries = Observable([])
        fetchGalleries()
    }
    
    func fetchGalleries() {
        APIManager().searchGallery(query: "cat") { [weak self] result, error in
            guard let self = self else { return }
            guard let result = result else { return }
            self.galleries.value = result.galleries.compactMap {
                GalleryCollectionViewCellModel(gallery: $0)
            }
        }
    }
}
