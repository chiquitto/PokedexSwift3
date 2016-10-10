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
    var pokemonType = 0 {
        didSet{
            setNeedsLayout()
        }
    };
    var colorTypes = [
        [
            "bg": UIColor(red: 0, green: 0, blue: 0, alpha: 0),
            "fg": UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        ],
        [ // normal
            "bg": UIColor(netHex:0xA4ACAF),
            "fg": UIColor(netHex:0x212121)
        ],
        [ // fighting
            "bg": UIColor(netHex:0xc03028),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // flying
            "bg": UIColor(netHex:0xa890f0),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // poison
            "bg": UIColor(netHex:0xa040a0),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // ground
            "bg": UIColor(netHex:0xab9842),
            "fg": UIColor(netHex:0x212121)
        ],
        [ // rock
            "bg": UIColor(netHex:0xb8a038),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // bug
            "bg": UIColor(netHex:0xa8b820),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // ghost
            "bg": UIColor(netHex:0x705898),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // steel
            "bg": UIColor(netHex:0xb8b8d0),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // fire
            "bg": UIColor(netHex:0xf08030),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // water
            "bg": UIColor(netHex:0x4592c4),
            "fg": UIColor(netHex:0xFFFFFF)
        ],
        [ // grass
            "bg": UIColor(netHex:0x78c850),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // electric
            "bg": UIColor(netHex:0xf8d030),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // psychic
            "bg": UIColor(netHex:0xf85888),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // ice
            "bg": UIColor(netHex:0x98d8d8),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // dragon
            "bg": UIColor(netHex:0x7038f8),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // dark
            "bg": UIColor(netHex:0x705848),
            "fg": UIColor(netHex:0xffffff)
        ],
        [ // fairy
            "bg": UIColor(netHex:0xe898e8),
            "fg": UIColor(netHex:0xffffff)
        ]
    ] as [[String:UIColor]]
    
    
    var colorNames = [
        "",
        "normal",
        "fighting",
        "flying",
        "poison",
        "ground",
        "rock",
        "bug",
        "ghost",
        "steel",
        "fire",
        "water",
        "grass",
        "electric",
        "psychic",
        "ice",
        "dragon",
        "dark",
        "fairy"
    ] as [String]
    
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
        
        let bgColor = colorTypes[pokemonType]["bg"]
        let fgColor = colorTypes[pokemonType]["fg"]
        let typeName = colorNames[pokemonType]
        
//        switch pokemonType {
//        case "normal":
//            bgColor = UIColor(netHex:0xA4ACAF)
//            fgColor = UIColor(netHex:0x212121)
//            
//        default:
//            bgColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//            fgColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
//        }
        
        typeLabel.text = typeName.capitalized
        typeLabel.textColor = fgColor
        self.backgroundColor = bgColor
    }

}
