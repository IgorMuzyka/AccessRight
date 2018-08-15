
extension NSOpenPanel {

	@discardableResult
	public func select(
		url: URL? = nil,
		title: String,
		allowsMultipleSelection: Bool = false,
		canChooseDirectories: Bool = false,
		canChooseFiles: Bool = false,
		canCreateDirectories: Bool = false,
		allowedFileTypes: [String]? = nil
	) -> AccessRight? {
		self.title = title
		self.allowsMultipleSelection = allowsMultipleSelection
		self.canChooseDirectories = canChooseDirectories
		self.canChooseFiles = canChooseFiles

		if let allowedFileTypes = allowedFileTypes {
			self.allowedFileTypes = allowedFileTypes
		}

		guard let url = runModal() == .OK ? urls.first : nil else { return nil }

		return try? AccessRight(name: title, url: url, enabled: true)
	}
}
