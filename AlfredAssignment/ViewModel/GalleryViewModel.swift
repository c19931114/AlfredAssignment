//
//  GalleryViewModel.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import Foundation

class GalleryViewModel {
    
    private let apiManager = APIManager()
    
    var page: Observable<Int> = Observable(0)
    
    private(set) var galleries: Observable<[GalleryCollectionViewCellModel]> = Observable([])
    
    init() {
        fetchGalleries()
        bind()
    }
    
    func fetchGalleries(page: Int = 0) {
        apiManager.searchGallery(page: page,
                                 query: "cat") { [weak self] result, error in
            guard let self = self else { return }
            guard let origin = self.galleries.value,
                  let result = result else { return }
            self.galleries.value = origin + result.galleries.compactMap {
                GalleryCollectionViewCellModel(gallery: $0)
            }
        }
    }
    
    private func bind() {
        page.bind { [weak self] page in
            guard let page = page, page < 5 else { return }
            self?.fetchGalleries(page: page)
        }
    }
}
