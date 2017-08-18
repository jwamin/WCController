//
//  shared.swift
//  WCLive
//
//  Created by Joss Manger on 8/18/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Foundation

enum Directions {
    
    case down
    case right
    case up
    case left
    case center
    case upright
    case upleft
    case downright
    case downleft
    
    func stringDescriptor()->String{
        switch self {
        case .up:
            return "⬆️"
        case .down:
            return "⬇️"
        case .left:
            return "⬅️"
        case .right:
            return "➡️"
        case .center:
            return "⏺"
        case .downleft:
            return "↙️"
        case .downright:
            return "↘️"
        case .upright:
            return "↗️"
        case .upleft:
            return "↖️"
        }
        
    }
    
    static func stringDecoder(_ str:String)->Directions{
        switch str {
        case "⬆️":
            return .up
        case "⬇️":
            return .down
        case "⬅️":
            return .left
        case "➡️":
            return .right
        case "⏺":
            return .center
        case "↙️":
            return .downleft
        case "↘️":
            return .downright
        case "↗️":
            return .upright
        case "↖️":
            return .upleft
        default:
            return .center
        }
        
    }
    
}
