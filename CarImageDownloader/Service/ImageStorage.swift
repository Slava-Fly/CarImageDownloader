//
//  ImageStorage.swift
//  CarImageDownloader
//
//  Created by User on 04.10.2024.
//

import Foundation

final class ImageStorage {
    
    static let shared: ImageStorage = {
        return ImageStorage()
    }()
    
    private init() {}
    
    func getCarImage() -> [CollectionImage] {
        return [
            CollectionImage(imageURL: "https://s1.auto.drom.ru/photo/v2/yfoEJcZe4tzrNHDESBvz0ojRH38LZhT5uVVX-IOaUYftcHPE49q97o0QWYo5ZhVCYNMQhrm_IjrFbvEn/gen1200.jpg"),
            CollectionImage(imageURL: "https://s1.auto.drom.ru/photo/v2/LqhBvtc5JGhQISp-DT-YMqxryX6hcNh_CJf8qy4Md1kI9jXb1xmbHYIIl68O0nhR7EM0hZg8aRgG4obL/gen1200.jpg"),
            CollectionImage(imageURL: "https://s1.auto.drom.ru/photo/v2/5mdsE6sA7kEGyrKpo9Umt5oh4_pM74RfSgZ0sU85r4bbZwG2MjiTqJLpXgbwg8Qlp0TcE_2bmODOjy6p/gen1200.jpg"),
            CollectionImage(imageURL: "https://s1.auto.drom.ru/photo/v2/SWRopqvOCiyGIgjyPVzYbT8K1xfsj5m7pPOQpygySJ1BBTwV_G3ryKSUIHn-FwvvPxHgg5amh1VX3A8b/gen1200.jpg"),
            CollectionImage(imageURL: "https://s1.auto.drom.ru/photo/v2/XK4_4_AAv5BD11Kitpes0u_lEuGnnBAiKXFFSncrzMXYGR5VEzfrm61Ya7bANd1at_5RDqv2zLcp/gen1200.jpg"),
            CollectionImage(imageURL: "https://s1.auto.drom.ru/photo/v2/djGZvTpAUCszyJntPVSkjxy1V1MPrLgT_KwAUe1pkRUjFklwaydbtD14aAzMX0QTQjKE5vgfqU9WL8zz/gen1200.jpg")
        ]
    }
}
