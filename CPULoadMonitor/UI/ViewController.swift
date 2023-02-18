//
//  ViewController.swift
//  CPULoadMonitor
//
//  Created by leonid.mesentsev on 17/02/23.
//

import Cocoa
import SwiftUI


final class ViewController: NSViewController {
    
    var swiftUIView: NSHostingController<ContentView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftUIView = NSHostingController(rootView: ContentView())
        view.addSubview(swiftUIView!.view)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        swiftUIView?.view.frame = view.bounds
    }
}
