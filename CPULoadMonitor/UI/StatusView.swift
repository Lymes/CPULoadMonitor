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

        let borderPath = NSBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), xRadius: 4.0, yRadius: 4.0)
        borderPath.setClip()

        NSColor.green.set()
        var rect = bounds.insetBy(dx: 1.0, dy: 1.0)
        rect.size.width = rect.width * value
        let fillPath = NSBezierPath(rect: rect)
        fillPath.fill()

        NSColor.init(white: 1.0, alpha: 1.0).set()
        borderPath.lineWidth = 1.5
        borderPath.stroke()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrs: [NSAttributedString.Key: Any] = [
            .font: NSFont(name: "HelveticaNeue", size: 10)!,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: NSColor.white
        ]
        let string = "\(Int(value * 100))%"
        string.draw(with: bounds.insetBy(dx: 0, dy: 4.5), options: [], attributes: attrs, context: nil)
    }
}
