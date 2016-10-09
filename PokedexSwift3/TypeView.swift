//
//  Type.swift
//  PokedexSwift3
//
//  Created by Alisson Chiquitto on 09/10/16.
//  Copyright © 2016 Alisson Chiquitto. All rights reserved.
//

import UIKit

class TypeView: UIView {

    var typeLabel = UILabel()
    var pokemonType = "" {
        didSet{
            setNeedsLayout()
        }
    };
    var colorTypes = [
        "bug": [
            "bg": UIColor(netHex:0xa8b820),
            "fg": UIColor(netHex:0xffffff)
        ],// 7
        "dark": [
            "bg": UIColor(netHex:0x705848),
            "fg": UIColor(netHex:0xffffff)
        ],// 17
        "dragon": [
            "bg": UIColor(netHex:0x7038f8),
            "fg": UIColor(netHex:0xffffff)
        ],// 16
        "electric": [
            "bg": UIColor(netHex:0xf8d030),
            "fg": UIColor(netHex:0xffffff)
        ],// 13
        "fairy": [
            "bg": UIColor(netHex:0xe898e8),
            "fg": UIColor(netHex:0xffffff)
        ],// 18
        "fighting": [
            "bg": UIColor(netHex:0xc03028),
            "fg": UIColor(netHex:0xffffff)
        ],// 2
        "fire": [
            "bg": UIColor(netHex:0xf08030),
            "fg": UIColor(netHex:0xffffff)
        ],// 10
        "flying": [
            "bg": UIColor(netHex:0xa890f0),
            "fg": UIColor(netHex:0xffffff)
        ],// 3
        "ghost": [
            "bg": UIColor(netHex:0x705898),
            "fg": UIColor(netHex:0xffffff)
        ],// 8
        "grass": [
            "bg": UIColor(netHex:0x78c850),
            "fg": UIColor(netHex:0xffffff)
        ],// 12
        "ground": [
            "bg": UIColor(netHex:0xab9842),
            "fg": UIColor(netHex:0x212121)
        ],
        "ice": [
            "bg": UIColor(netHex:0x98d8d8),
            "fg": UIColor(netHex:0xffffff)
        ],// 15
        "normal": [
            "bg": UIColor(netHex:0xA4ACAF),
            "fg": UIColor(netHex:0x212121)
        ],// 1
        "poison": [
            "bg": UIColor(netHex:0xa040a0),
            "fg": UIColor(netHex:0xffffff)
        ],// 4
        "psychic": [
            "bg": UIColor(netHex:0xf85888),
            "fg": UIColor(netHex:0xffffff)
        ],// 14
        "rock": [
            "bg": UIColor(netHex:0xb8a038),
            "fg": UIColor(netHex:0xffffff)
        ],// 6
        "steel": [
            "bg": UIColor(netHex:0xb8b8d0),
            "fg": UIColor(netHex:0xffffff)
        ],// 9
        "water": [
            "bg": UIColor(netHex:0x4592c4),
            "fg": UIColor(netHex:0xFFFFFF)
        ],// 11
    ] as [String : [String:UIColor]]
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        typeLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        typeLabel.textColor = .black
        
        // typeLabel.center = CGPoint(x: self.frame.size.width, y: self.frame.size.height)
        
        typeLabel.textAlignment = .center
        
        addSubview(typeLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        typeLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        refreshView()
    }
    
    func refreshView() {
        
        let bgColor = colorTypes[pokemonType]?["bg"]
        let fgColor = colorTypes[pokemonType]?["fg"]
        
//        switch pokemonType {
//        case "normal":
//            bgColor = UIColor(netHex:0xA4ACAF)
//            fgColor = UIColor(netHex:0x212121)
//            
//        default:
//            bgColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//            fgColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
//        }
        
        typeLabel.text = pokemonType.capitalized
        typeLabel.textColor = fgColor
        self.backgroundColor = bgColor
    }

}
