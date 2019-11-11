import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var status: Bool = false
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let defaults = UserDefaults.standard
        let x = defaults.object(forKey: "hideWindow")
        if x as? String != "Yes" {
            var myWindow: NSWindow? = nil
            let storyboard = NSStoryboard(name: "Main",bundle: nil)
            let controller: ViewControler = storyboard.instantiateController(withIdentifier: "MainController") as! ViewControler
            myWindow = NSWindow(contentViewController: controller)
            myWindow?.makeKeyAndOrderFront(self)
            let vc = NSWindowController(window: myWindow)
            vc.showWindow(self)
        }            
        
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem.button!.image = NSImage(named: "off")
        statusBarItem.button!.action = #selector(AppDelegate.toggle)
        statusBarItem.button!.sendAction(on: [.leftMouseDown, .rightMouseDown])   
    }
    
    @objc func toggle() {
        let event = NSApp.currentEvent!
        if (event.type ==  NSEvent.EventType.rightMouseDown) {            
            NSApplication.shared.terminate(nil)
        }
        
        if (status) {
            statusBarItem.button!.image = NSImage(named: "off")
            status = false
        } else {
            statusBarItem.button!.image = NSImage(named: "on")
            status = true
        }
        
        let currentTrackScript = """
        tell application "System Events"

            tell appearance preferences

                set dark mode to not dark mode

            end tell

        end tell
        """
        
        if let scriptObject = NSAppleScript(source: currentTrackScript) {
            var errorDict: NSDictionary? = nil
            scriptObject.executeAndReturnError(&errorDict)
            if let error = errorDict {
                print(error)
            }
        }
    }
}
