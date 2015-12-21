//
//  TextView.swift
//  Type
//
//  Created by Davide Bruzzone on 12/20/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import UIKit

class TextView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // TODO: Turn the method's hard-coded values into properties
        let text: NSString = "Hello"

        // Set text's color
        let textColor: UIColor = UIColor.darkGrayColor()
        
        // Set text's font
        let textFont = UIFont(name: "Helvetica Neue", size: 20)

        // Set text's obliqueness (0 indicates no obliqueness/skew)
        let skew = 0.1
        
        let attributes: NSDictionary = [
            NSForegroundColorAttributeName: textColor,
            NSObliquenessAttributeName: skew,
            NSFontAttributeName: textFont!
        ]

        let boundingBox: CGSize = text.sizeWithAttributes(attributes as? [String : AnyObject])
        let offsets = xAndYOffsets(boundingBox, rect: rect)

        text.drawInRect(CGRectMake(offsets.x, offsets.y, boundingBox.width, boundingBox.height), withAttributes: attributes as? [String : AnyObject])
    }

    // MARK: - Private methods

    private func xAndYOffsets(boundingBox: CGSize, rect: CGRect) -> (x: CGFloat, y: CGFloat) {
        return (x: (rect.size.width - boundingBox.width) / 2.0,
                y: (rect.size.height - boundingBox.height) / 2.0)
    }

}
