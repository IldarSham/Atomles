//
//  UserDefaultsLayer.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 19.03.2023.
//

import Foundation

class UserDefaultsLayer {
    @Persist(key: "app_theme_id", defaultValue: AppTheme.system.rawValue)
    var appThemeId: Int
    
    @Persist(key: "watched_episode_ids", defaultValue: [])
    var watchedEpisodeIds: [Int]
}

extension UserDefaultsLayer: AppThemeStorage {}
extension UserDefaultsLayer: WatchedSeriesStorage {}
