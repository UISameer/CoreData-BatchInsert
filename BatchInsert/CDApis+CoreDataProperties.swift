import Foundation
import CoreData

extension CDApis {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDApis> {
        return NSFetchRequest<CDApis>(entityName: "CDApis")
    }

    @NSManaged public var api: String?
    @NSManaged public var textDescription: String?
    @NSManaged public var auth: String?
    @NSManaged public var https: Bool
    @NSManaged public var cors: String?
    @NSManaged public var link: String?
    @NSManaged public var category: String?
    @NSManaged public var id: UUID?

}

extension CDApis : Identifiable {

}
