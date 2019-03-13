//
//  PlaylistController.swift
//  PlaylistCoreData
//
//  Created by Hannah Hoff on 3/13/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    //Singleton
    static let shared = PlaylistController()
    
    // Source of truth is going to be the MOC
    var playlists: [Playlist] {
        // form a request to pull playlists off of hard drive
        let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        // deal with the throw
        return(try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    // CRUD
    //Create
    func add(playlistWithTitle title: String) {
        Playlist(title: title)
        saveToPersistentStore()
        
    }
    
    //Delete
    func delete(playlist: Playlist){
        CoreDataStack.context.delete(playlist)
        saveToPersistentStore()
    }
    
    // Persistence
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error in \(#function) \(error) \(error.localizedDescription)")
        }
    }
}
