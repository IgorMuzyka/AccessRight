
import FileKit
import FileKit_RestorablePersistable

open class AccessRightsManager {

	public let directory: Path

	public init(directory: Path) {
		self.directory = directory
	}

	public private(set) var accessRights = [AccessRight]()

	@discardableResult
	public func register(_ accessRight: AccessRight) -> AccessRight {
		accessRights.append(accessRight)
		return accessRight
	}

	@discardableResult
	public func persist(_ accessRight: AccessRight) throws -> AccessRight {
		try accessRight.persist(to: directory)
		return accessRight
	}

    public func persist() throws {
        try accessRights.forEach { try persist($0) }
    }

	public func restore() throws {
		directory.children().map { try? AccessRight.restore(from: $0) }.compactMap { $0 }.map(register).forEach { $0.enable() }
	}
}
