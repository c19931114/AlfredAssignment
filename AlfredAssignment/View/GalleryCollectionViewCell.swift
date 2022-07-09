//
//  GalleryCollectionViewCell.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    private var cellModel: GalleryCollectionViewCellModel!
    
    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCell(gallery: Gallery) {
        guard let urlString = cellModel?.gallery.getFirstImageLink() else { return }
        photoView.load(urlString: urlString)
    }
    func setCellModel(_ cellModel: GalleryCollectionViewCellModel) {
        self.cellModel = cellModel
        guard let urlString = self.cellModel.gallery.getFirstImageLink() else { return }
        photoView.load(urlString: urlString)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }
    
    private func setupUI() {
        contentView.addSubview(photoView)
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
