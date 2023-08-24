//
//  ImageService.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 23.08.2023.
//

import UIKit
import Kingfisher

protocol IImageService {
    func getImage(from url: String) async -> UIImage?
}

struct ImageService: IImageService {
    func getImage(from url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        if let image = await withCheckedContinuation({ continuation in
            ImageCache.default.retrieveImageInDiskCache(forKey: url.absoluteString) { result in
                continuation.resume(returning: try? result.get())
            }
        }) {
            return image
        } else {
            return await withCheckedContinuation { continuation in
                ImageDownloader.default.downloadImage(
                    with: url
                ) { result in
                    if let image = try? result.get().image {
                        ImageCache.default.store(image, forKey: url.absoluteString)
                    }
                    continuation.resume(returning: try? result.get().image)
                }
            }
        }
    }
}
