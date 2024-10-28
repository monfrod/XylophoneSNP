//
//  Extension.swift
//  XylophoneSNP
//
//  Created by yunus on 26.10.2024.
//

import UIKit
import SnapKit

extension ViewController{
    func setupUI(){
        let titleButton = ["A", "B", "C", "D", "E", "F", "G"]
        let colorArray: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemIndigo, .systemBlue, .systemPurple]
        let viewArray = [firstView,secondView,thirdView,fourthView,fifthView,sixthView,seventhView]
        let buttonArray = [CButton,DButton,EButton,FButton,GButton,AButton,BButton]
        for i in 0..<7{
            viewArray[i].addSubview(buttonArray[i])
            buttonArray[i].snp.makeConstraints { make in
                make.top.equalTo(viewArray[i].snp.top)
                make.bottom.equalTo(viewArray[i].snp.bottom)
                make.left.equalTo(viewArray[i].snp.left).offset((i*6)+5)
                make.right.equalTo(viewArray[i].snp.right).offset((-i*6)-5)
            }
            buttonArray[i].backgroundColor = colorArray[i]
            buttonArray[i].setTitle(titleButton[i], for: .normal)
            buttonArray[i].titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
            
            buttonArray[i].tag = i
            buttonArray[i].addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
        
        
        for i in viewArray{
            VStack.addArrangedSubview(i)
        }
        view.addSubview(VStack)
        VStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
    }
    
}

