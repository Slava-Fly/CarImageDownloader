//
//  ImageViewModel.swift
//  CarImageDownloader
//
//  Created by User on 04.10.2024.
//

import UIKit

class ImageViewModel {
    
    private let networkManager = NetworkManager.shared
    private let imageStorage = ImageStorage.shared
    
    var images: [CollectionImage] = []
    
    init() {
        images = imageStorage.getCarImage()
    }
    
    func downloadImage(for index: Int, completion: @escaping (Result<UIImage, NetworkManagerError>) -> Void) {
        guard let url = URL(string: images[index].imageURL) else {
            completion(.failure(.badLocalUrl))
            return
        }
        networkManager.downloadImage(from: url) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Повторная загрузка URL
    func reset() {
        images = imageStorage.getCarImage()
    }
    
    // Удаление ячейки по индексу
    func removeCell(at index: Int) {
        images.remove(at: index)
    }
}
