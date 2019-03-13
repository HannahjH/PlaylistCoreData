//
//  SongController.swift
//  PlaylistCoreData
//
//  Created by Hannah Hoff on 3/13/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

import Foundation

class SongController {
    
    static func create(songWithTitle title: String, artist: String, playlist: Playlist) {
        Song(title: title, artist: artist, playlist: playlist)
        PlaylistController.shared.saveToPersistentStore()
    }
    
    static func delete(song: Song) {
        CoreDataStack.context.delete(song)
        PlaylistController.shared.saveToPersistentStore()
    }
}
