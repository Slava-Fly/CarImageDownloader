//
//  NetworkManager.swift
//  CarImageDownloader
//
//  Created by User on 04.10.2024.
//


import UIKit

enum NetworkManagerError: Error {
  case badResponse(URLResponse?)
  case badData
  case badLocalUrl
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, NetworkManagerError>) -> Void) {
        let cacheKey = NSString(string: url.absoluteString)
        
        // Проверяем наличие изображения в кеше
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(.success(cachedImage))
            return
        }
        
        // Загружаем изображение с интернета
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Проверка на наличие ошибок
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.badLocalUrl)) // Ошибка локальной URL или сети
                }
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            // Проверка ответа на правильность
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.badResponse(response)))
                }
                return
            }
            
            // Проверка данных
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
                return
            }
            
            // Кэшируем загруженное изображение
            self?.imageCache.setObject(image, forKey: cacheKey)
            
            // Возвращаем изображение в главной очереди
            DispatchQueue.main.async {
                completion(.success(image))
                print("Works Successfully!")
            }
        }.resume()
    }
}

