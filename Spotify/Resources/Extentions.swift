//
//  Extentions.swift
//  Spotify
//
//  Created by Fastick on 30.06.2022.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var heigth: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + heigth
    }
}

extension String {
    var formattedDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        guard let date = formatter.date(from: self) else {
            return self
        }
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}
