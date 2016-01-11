//
//  ColorPallette.swift
//  TimeKeeper
//
//  Created by Steve on 1/10/16.
//  Copyright © 2016 Braintree. All rights reserved.
//

import UIKit

class Palette {
    
    private func startColor() -> UIColor {
        fatalError("Not implemented by base class")
    }
    
    private func endColor() -> UIColor {
        fatalError("Not implemented by base class")
    }
    
    func blend(index: Int, of: Int) -> UIColor {
        var r1, r2, g1, g2, b1, b2: CGFloat
        r1 = 0; r2 = 0; g1 = 0; g2 = 0; b1 = 0; b2 = 0
        startColor().getRed(&r1, green: &g1, blue: &b1, alpha: nil)
        endColor().getRed(&r2, green: &g2, blue: &b2, alpha: nil)
        
        var r = (r1 + r2) / CGFloat(of); var g = (g1 + g2) / CGFloat(of); var b = (b1 + b2) / CGFloat(of)
        r *= CGFloat(index)
        g *= CGFloat(index)
        b *= CGFloat(index)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

class Hazel: Palette {
    
    override private func startColor() -> UIColor {
        return UIColor(red: (22.0/255.0), green: (52.0/255.0), blue: (65.0 / 255.0), alpha: 1.0)
    }
    
    override private func endColor() -> UIColor {
        return UIColor(red: (145.0/255.0), green: (170.0/255.0), blue: (157.0/255.0), alpha: 1.0)
    }
}