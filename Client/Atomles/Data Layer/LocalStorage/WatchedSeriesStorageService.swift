//
//  WatchedSeriesStorageService.swift
//  Atomles
//
//  Created by Ildar on 08.09.2022.
//

import Foundation

protocol WatchedSeriesStorage {
    var watchedEpisodeIds: [Int] { get set }
}

protocol WatchedSeriesStorageServiceProtocol {
    func getWatchedEpisodeIds() -> [Int]
    func markEpisodeAsWatched(_ episodeId: Int)
    func unmarkEpisodeAsWatched(_ episodeId: Int)
}

class WatchedSeriesStorageService: WatchedSeriesStorageServiceProtocol {
    
    private var storage: WatchedSeriesStorage
    
    init(storage: WatchedSeriesStorage = UserDefaultsLayer()) {
        self.storage = storage
    }
    
    func getWatchedEpisodeIds() -> [Int] {
        return storage.watchedEpisodeIds
    }
    
    func markEpisodeAsWatched(_ episodeId: Int) {
        storage.watchedEpisodeIds += [episodeId]
    }
    
    func unmarkEpisodeAsWatched(_ episodeId: Int) {
        if let index = storage.watchedEpisodeIds.firstIndex(of: episodeId) {
            storage.watchedEpisodeIds.remove(at: index)
        }
    }
}
