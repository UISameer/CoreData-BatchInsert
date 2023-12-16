import Foundation
import CoreData

struct ApiDataRepository: ApiCoreDataRepository {
    
    func getApiRecords(completionHandler: @escaping (Array<Api>?) -> Void) {
        
        PersistentStorage.shared.printDocumentDirectoryPath()
        
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDApis.self)
        var apis: Array<Api> = []
        result?.forEach({ (cdApi) in
            apis.append(cdApi.convertToApi())
        })
        completionHandler(apis)
    }
    
    func insertApiRecords(records: Array<Api>) -> Bool {
        
        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            
            records.forEach { apiRecord in
                let cdApi = CDApis(context: privateManagedContext)
                cdApi.id = UUID()
                cdApi.api = apiRecord.api
                cdApi.auth = apiRecord.auth
                cdApi.cors = apiRecord.cors
                cdApi.textDescription = apiRecord.textDescription
                cdApi.https = apiRecord.https
                cdApi.category = apiRecord.category
                cdApi.link = apiRecord.link
            }
            
            if(privateManagedContext.hasChanges) {
                try? privateManagedContext.save()
            }
        }
        return true
    }
    
    func batchInsertApiRecords(records: Array<Api>) -> Bool {
        
        PersistentStorage.shared.printDocumentDirectoryPath()

        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            
            let request = self.batchInsertApiRecords(records: records)
            do {
                try privateManagedContext.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return true
    }
    
    private func createBatchInsertRequest(records: Array<Api>) -> NSBatchInsertRequest {
        
        let totalCount  = records.count
        var index = 0
        
        let batchInsert = NSBatchInsertRequest(entity: CDApis.entity()) { (managedObject: NSManagedObject) -> Bool in
            
            guard index < totalCount else {return true}
            
            if let api = managedObject as? CDApis {
                let apiRecord = records[index]
                api.id = UUID()
                api.api = apiRecord.api
                api.auth = apiRecord.auth
                api.cors = apiRecord.cors
                api.textDescription = apiRecord.textDescription
                api.https = apiRecord.https
                api.category = apiRecord.category
                api.link = apiRecord.link
            }
            index += 1
            return false
        }
        return batchInsert
    }
}
