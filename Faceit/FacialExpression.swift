//
//  FacialExpression.swift
//  Faceit
//
//  Created by Leon Fan on 2018/11/6.
//  Copyright © 2018 Leon Fan. All rights reserved.
//

import Foundation


struct FacialExpression {
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }
    
    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
        
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }

    }
    
    let eyes: Eyes
    let mouth: Mouth
    
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }
    
}
