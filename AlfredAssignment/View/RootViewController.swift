//
//  RootViewController.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import UIKit

enum Layout {
    case list
    case grid
    
    var column: Int {
        switch self {
        case .list: return 1
        case .grid: return 3
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .list: return 40 * 2
        case .grid: return 2
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .list: return 16
        case .grid: return 2
        }
    }
    
    var itemSize: CGSize {
        let fullScreenSize = UIScreen.main.bounds.size
        var width: CGFloat = 0
        var height: CGFloat = 0
        switch self {
        case .list:
            width = fullScreenSize.width - horizontalPadding
            height = width
        case .grid:
            width = (fullScreenSize.width - 1 // 暫時處理進位問題
                     - horizontalPadding * CGFloat(column-1)) / 3
            height = width
        }
        return CGSize(width: width, height: height)
    }
}

class RootViewController: BaseViewController {
    
    private let viewModel: RootViewModel

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("change layout", for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cCellID = String(describing: PhotoCollectionViewCell.self)
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) 
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: cCellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func bindViewModel() {
        viewModel.layout.bind { [weak self] _ in
            print("viewModel.layout.bind")
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func buttonDidTap() {
        viewModel.layout.value = viewModel.layout.value == .list ? .grid : .list
    }
}

extension RootViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseCell = collectionView.dequeueReusableCell(withReuseIdentifier: cCellID, for: indexPath)
        guard let cell = reuseCell as? PhotoCollectionViewCell else { 
            return reuseCell 
        }
        cell.configCell(layout: viewModel.layout.value ?? .list)
        return cell
    }
}

extension RootViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.layout.value?.itemSize ?? .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.layout.value?.horizontalPadding ?? .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.layout.value?.verticalPadding ?? .zero
    }
}
