//
//  StatusView.swift
//  CPULoadMonitor
//
//  Created by leonid.mesentsev on 17/02/23.
//

import Cocoa

final class StatusView: NSView {
    
    @Clamped(to: 0...1)
    var value: CGFloat = 0.5

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.green.set()
        var rect = bounds.insetBy(dx: 1.0, dy: 1.0)
        rect.size.width = rect.width * value
        let fillPath = NSBezierPath(roundedRect: rect, xRadius: 2.0, yRadius: 2.0)
        fillPath.fill()

        NSColor.init(white: 0.99, alpha: 0.5).set()
        let borderPath = NSBezierPath(roundedRect: bounds, xRadius: 4.0, yRadius: 4.0)
        borderPath.lineWidth = 1.0
        borderPath.stroke()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrs = [NSAttributedString.Key.font: NSFont(name: "HelveticaNeue", size: 10)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let string = "\(Int(value * 100))%"
        string.draw(with: bounds.insetBy(dx: 2.0, dy: 2.0), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
    }
}
