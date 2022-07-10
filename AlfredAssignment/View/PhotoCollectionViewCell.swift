//
//  PhotoCollectionViewCell.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    private var cellModel: PhotoCollectionViewCellModel!
    
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
    
    func setCellModel(_ cellModel: PhotoCollectionViewCellModel) {
        self.cellModel = cellModel
        let urlString = self.cellModel.photo.link
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
