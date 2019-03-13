//
//  SongTableViewController.swift
//  PlaylistCoreData
//
//  Created by Hannah Hoff on 3/13/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    // landing pad
    var playlist: Playlist?
    
    //Mark: IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let playlist = playlist else { return }
        navigationItem.title = "\(playlist.title ?? "My Playlist")"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlist?.songs?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        guard let playlist = playlist else { return UITableViewCell()}
        if let song = playlist.songs?[indexPath.row] as? Song {
            cell.textLabel?.text = song.title
            cell.detailTextLabel?.text = song.artist
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            guard let song = playlist.songs?[indexPath.row] as? Song else { return }
            SongController.delete(song: song)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if artistTextField.text == "" || titleTextField.text == "" { return }
        guard let title = titleTextField.text,
        let artist = artistTextField.text,
        let playlist = playlist else { return }
        SongController.create(songWithTitle: title, artist: artist, playlist: playlist)
        artistTextField.text = ""
        titleTextField.text = ""
        tableView.reloadData()
        
    }
}

