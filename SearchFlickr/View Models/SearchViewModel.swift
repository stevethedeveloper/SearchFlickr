//
//  SearchViewModel.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/29/23.
//

import Foundation

public class SearchViewModel {
    
    private let urlSession = URLSession.shared
    
    var photoResults: Photos?
    
    var onErrorHandling: ((String) -> Void)?
    
    var data: Observable<[Photo]> = Observable([])
    
    func fetchPhotos(for searchTerm: String?) async {        
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            data.value = []
            return
        }
        
        let url: URL = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchTerm)")!
                
        do {
            let (returnData, _) = try await urlSession.data(from: url)
            self.parsePhotos(json: returnData)
            if let allPhotos = self.photoResults?.items {
                if allPhotos.count > 0 {
                    self.data.value = allPhotos
                }
            }
        } catch {
            onErrorHandling?("Could not retrieve videos.  Please check your connection and try again.")
        }
    }
        
    private func parsePhotos(json: Data) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
                
        do {
            let photosDecoded = try decoder.decode(Photos.self, from: json)
            self.photoResults = photosDecoded.items.count > 0 ? photosDecoded : nil
        } catch {
            self.onErrorHandling?("Could not parse photos.  Please check your connection and try again.")
        }
        
    }
}
