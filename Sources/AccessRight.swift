
import FileKit_RestorablePersistable

open class AccessRight {

	public let name: String
	public let url: URL
	public private(set) var enabled: Bool = false

	public init(name: String, url: URL, enabled: Bool) throws {
		self.name = name
		self.url = url
		self.enabled = enabled
	}

	public required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		guard
			let name = try? container.decode(String.self, forKey: .name),
			let data = try? container.decode(Data.self, forKey: .data)
			else { throw Error.decoding("\(dump(container))") }

		self.name = name
		var isStale: Bool = false

		self.url = try URL(resolvingBookmarkData: data, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)
	}
}

extension AccessRight {

	@discardableResult
	public func enable() -> Bool {
		self.enabled = url.startAccessingSecurityScopedResource()
		return self.enabled
	}

	public func disable() {
		url.stopAccessingSecurityScopedResource()
		self.enabled = false
	}
}

extension AccessRight: Codable {

	private enum CodingKeys: CodingKey {

		case name
		case data
	}

	public enum Error: Swift.Error {

		case decoding(String)
	}

	public func encode(to encoder: Encoder) throws {
		let data = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(name, forKey: .name)
		try container.encode(data, forKey: .data)
	}
}

extension AccessRight: RestorablePersistable {

	public var fileName: String { return name }
	public static let fileExtension = ".accessright"
}
