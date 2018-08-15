## Access Right

A right way to persist access to URLs between app launches. **Works in sandbox**.

## Installation

To install it, simply add the following line to your Podfile:

```ruby
pod 'FileKit'
pod 'FileKit-RestorablePersistable', :git => 'https://github.com/IgorMuzyka/FileKit-RestorablePersistable.git'
pod 'AccessRight', :git => 'https://github.com/IgorMuzyka/AccessRight.git'
```

## Usage

Add the following code to you `AppDelegate`

```swift
import AccessRight
import FileKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
    private let path: Path = .userApplicationSupport
    internal let accessRightsManager: AccessRightsManager(directory: path + "AccessRights")

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		try? accessRightsManager.restore() // restore previously acquired Access Rights
	}

    func applicationWillTerminate(_ aNotification: Notification) {
        try? accessRightsManager.persist() // persist currently owned Access Rights
    }
}
```

And when you need to *acquire* `AccessRight` just do it like this

```swift
func askUserForAccess() -> AccessRight? {
    guard
        let accessRight = NSOpenPanel().select(
            url: nil, // the URL for resource you would like to acquire Access Right to
            title: "access please",
            allowsMultipleSelection: false,
            canChooseDirectories: true,
            canChooseFiles: false,
            canCreateDirectories: false,
            allowedFileTypes: nil
        ),
        let manager = (NSApplication.shared.delegate as? AppDelegate).accessRightsManager
    else { return nil }

    manager.register(accessRight) // you may want to register the Access Right right away so that AccessRightManager could persist it when asked to
    try! manager.persist(accessRight) // or maybe persist as early as possible

    return accessRight
}
```

## Author

Igor Muzyka, igormuzyka42@gmail.com

## License

AccessRight is available under the MIT license. See the LICENSE file for more info.
