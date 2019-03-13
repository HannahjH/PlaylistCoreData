//
//  PlaylistTableViewController.swift
//  PlaylistCoreData
//
//  Created by Hannah Hoff on 3/13/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {

    @IBOutlet weak var playlistTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlaylistController.shared.playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.title
        cell.detailTextLabel?.text = "\(playlist.songs?.count ?? 0) Song(s)"

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.delete(playlist: playlist)
            // Delete the row form the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSongVC", let indexPath = tableView.indexPathForSelectedRow {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            let songVC = segue.destination as? SongTableViewController
            songVC?.playlist = playlist
        }
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let title = playlistTitleTextField.text else { return }
        PlaylistController.shared.add(playlistWithTitle: title)
        tableView.reloadData()
    }
}
