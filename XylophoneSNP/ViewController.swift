//
//  ViewController.swift
//  XylophoneSNP
//
//  Created by yunus on 24.10.2024.
//

import UIKit
import SnapKit
import AVFoundation
import CoreData

class ViewController: UIViewController {
    
    
    let VStack: UIStackView={
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    let firstView = UIView()
    let secondView = UIView()
    let thirdView = UIView()
    let fourthView = UIView()
    let fifthView = UIView()
    let sixthView = UIView()
    let seventhView = UIView()
    let CButton = UIButton()
    let DButton = UIButton()
    let EButton = UIButton()
    let FButton = UIButton()
    let GButton = UIButton()
    let AButton = UIButton()
    let BButton = UIButton()
    var player: AVAudioPlayer?
    var recordingIsEnabled: Bool = false
    var song:[NSString] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [RecordingData]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "rec/stop", style: .done, target: self, action: #selector(startRecording))
        
    }
    
    @objc func startRecording(){
        if !recordingIsEnabled{
            recordingIsEnabled = true
        }
        else if recordingIsEnabled{
            stopRecording()
            recordingIsEnabled = false
        }
    }
    
    func playAudio(title: String){
        guard let path = Bundle.main.path(forResource: title, ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func buttonPressed(sender: UIButton){
        print(sender.titleLabel?.text ?? "")
        UIView.animate(withDuration: 0.1) {
            self.view.backgroundColor = sender.backgroundColor
        }
        //        view.backgroundColor = sender.backgroundColor
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
            if let text = sender.titleLabel?.text{
                self.playAudio(title: text)
                sender.alpha = 1
                UIView.animate(withDuration: 0.1) {
                    self.view.backgroundColor = .systemBackground
                }
            }
        }
        if recordingIsEnabled {
            song.append((sender.titleLabel?.text)! as NSString)
            print(song)
        }
    }
    func stopRecording(){
        let alert = UIAlertController(title: "Give the name of your song", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        let addButton = UIAlertAction(title: "Add", style: .default) { _ in
            self.addSong(name: alert.textFields?.first?.text ?? "")
            self.song = []
        }
        alert.addAction(addButton)
        
        present(alert, animated: true)
    }
    
    
    // MARK: CoreData
    
    func getAllSongs(){
        let fetchRequest: NSFetchRequest<RecordingData> = RecordingData.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let items = try context.fetch(fetchRequest)
        }catch {
            print("Error fetching songs: \(error)")
        }
    }
    
    func addSong(name: String){
        let newSong = RecordingData(context: context)
        newSong.songName = name
        newSong.recording = song
        
        do {
            try context.save()
            getAllSongs()
            
        } catch {
            print("Error fetching songs: \(error)")
        }
    }
}
