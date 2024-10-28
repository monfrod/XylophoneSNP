//
//  RecordingViewController.swift
//  XylophoneSNP
//
//  Created by yunus on 26.10.2024.
//
import UIKit
import SnapKit
import AVFoundation

class RecordingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate {
    
    
    let tableView:UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var player: AVAudioPlayer?
    
    var models = [RecordingData]()
    var songQueue: [String] = []
    var playSong: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recordings"
        tableView.delegate = self
        tableView.dataSource = self
        loadSong()
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "stop", style: .done, target: self, action: #selector(stopPlaySong))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSong()
        self.tableView.reloadData()
    }
    
    @objc func stopPlaySong(){
        playSong = false
    }
    
    func loadSong(){
        let fetchRequest = RecordingData.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            models = try context.fetch(fetchRequest)
        } catch{
            print("error12")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].songName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "\(models[indexPath.row].songName)", message: "Choose option", preferredStyle: .alert)
        let playAction = UIAlertAction(title: "Play", style: .default) { _ in
            self.songQueue = self.models[indexPath.row].recording.compactMap { $0 as? NSString as String? }
            self.playSong = true
            self.playNextSong()
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteItem(item: self.models[indexPath.row])
            self.loadSong()
            self.tableView.reloadData()
        }
        alert.addAction(playAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    
    func playNextSong() {
        guard !songQueue.isEmpty else { return }
        
        let nextSongTitle = songQueue.removeFirst()
        playSong(title: nextSongTitle)
    }
    
    func playSong(title: String){
        if playSong{
            guard let path = Bundle.main.path(forResource: title, ofType:"wav") else {
                return }
            let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.delegate = self
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playNextSong()
    }
    
    func deleteItem(item: RecordingData){
        context.delete(item)
        
        do{
            try context.save()
        } catch {
            print("Error delete item")
        }
    }
}
