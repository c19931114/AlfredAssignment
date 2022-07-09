//
//  PhotoCollectionViewCell.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
        
    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    func configCell() {
        setupUI()
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
