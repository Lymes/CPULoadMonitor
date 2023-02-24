//
//  AppDelegate.swift
//  CPULoadMonitor
//
//  Created by leonid.mesentsev on 16/02/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow?
    @IBOutlet weak var menu: NSMenu?

    private let windowKey = "CPUWindow"
    private var statusItem: NSStatusItem?
    private var statusView: StatusView?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusItem = NSStatusBar.system.statusItem(withLength: 32)
        let statusView = StatusView(frame: NSRect(
            x: 0, y: (NSStatusBar.system.thickness - 16.0) / 2.0,
            width: 32, height: 16))
        statusView.wantsLayer = true
        statusItem?.button?.addSubview(statusView)
        self.statusView = statusView
        
        if let menu = menu {
            statusItem?.menu = menu
        }
        window?.setFrame(.zero, display: false)
        window?.backgroundColor = .clear
        window?.level = NSWindow.Level(-100)
        window?.windowController?.shouldCascadeWindows = false
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let data = UserDefaults.standard.data(forKey: windowKey),
              let frame = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSValue.self, from: data) else {
            return
        }
        window?.animator().setFrame(frame.rectValue, display: true)
        overalCPULoad()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        guard let frame = window?.frame, let data = try? NSKeyedArchiver.archivedData(withRootObject: NSValue(rect: frame), requiringSecureCoding: true) else {
            return
        }
        UserDefaults.standard.set(data, forKey: windowKey)
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    private func overalCPULoad() {
        let usage = CPU.systemUsage()        
        statusView?.value = CGFloat((usage.user + usage.system) / 100.0)
        statusView?.needsDisplay = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.overalCPULoad()
        }
    }
}
