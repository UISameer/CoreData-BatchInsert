import Foundation

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
    
}
