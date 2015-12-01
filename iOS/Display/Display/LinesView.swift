//
//  LinesView.swift
//  Display
//
//  Created by Davide Bruzzone on 11/30/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import UIKit

class LinesView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code

        // Get the height of the navigation bar
        let topY: CGFloat = topBarHeight()

        let context = UIGraphicsGetCurrentContext()

        CGContextSetLineWidth(context, 2.0)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 1.0, 1.0]
        let color = CGColorCreate(colorSpace, components)

        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, 30, topY + 30)
        CGContextAddLineToPoint(context, 300, 400)
        CGContextStrokePath(context)
    }

    // MARK: - Private methods
    
    private func statusBarHeight() -> CGFloat {
        return UIApplication.sharedApplication().statusBarFrame.size.height
    }

    private func navigationBarHeight() -> CGFloat {
        let navigationController: UINavigationController = self.window?.rootViewController as! UINavigationController

        return navigationController.navigationBar.frame.size.height
    }

    private func topBarHeight() -> CGFloat {
        return statusBarHeight() + navigationBarHeight()
    }

}
