import Foundation

protocol ApiBaseRepository {
    func getApiRecords(completionHandler: @escaping(_ result: Array<Api>?) -> Void)
}

protocol ApiCoreDataRepository: ApiBaseRepository {
    func insertApiRecords(records: Array<Api>) -> Bool
    func batchInsertApiRecords(records: Array<Api>) -> Bool
}

protocol RestApiResourceRepository: ApiBaseRepository {
    
}
