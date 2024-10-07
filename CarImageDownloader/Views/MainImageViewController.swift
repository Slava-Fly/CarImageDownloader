//
//  MainImageViewController.swift
//  CarImageDownloader
//
//  Created by User on 04.10.2024.
//

import UIKit

class MainImageViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let viewModel = ImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Car Images"
        
        setupCollectionView()
        setupPullToRefresh()
    }
    
    // Настройка коллекции для отображения изображений
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Настройка функциональности Pull to refresh
    private func setupPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshImages), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshImages() {
        viewModel.reset()
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
}


// MARK: - UICollectionViewDataSource
extension MainImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        // Загружаем изображение по индексу
        viewModel.downloadImage(for: indexPath.row) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    cell.configure(with: image)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error downloading image for cell at index \(indexPath.row): \(error)")
                }
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let width = (collectionView.frame.width - padding)
        
        return CGSize(width: width, height: width)
    }
}

// MARK: - UICollectionViewDelegate
extension MainImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        UIView.animate(withDuration: 0.7) {
            guard let cell = collectionView.cellForItem(at: indexPath) else {
                return
            }
            
            cell.center = CGPoint(x: cell.center.x + cell.frame.width + 10, y: cell.center.y)
            cell.alpha = 0
        } completion: { [weak self] success in
            guard let self = self else {
                return
            }
            if success {
                self.viewModel.removeCell(at: indexPath.row)
                collectionView.deleteItems(at: [indexPath])
            }
        }
    }
}
