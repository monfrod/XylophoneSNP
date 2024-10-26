//
//  ViewController.swift
//  XylophoneSNP
//
//  Created by yunus on 24.10.2024.
//

import UIKit
import SnapKit
import AVFoundation

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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        
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
//                self.view.backgroundColor = .white
                UIView.animate(withDuration: 0.1) {
                    self.view.backgroundColor = .white
                }
            }
        }
    }
    
}
