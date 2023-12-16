import Foundation

struct ApiViewModel {
    
    private let cdApiDataRepository: ApiCoreDataRepository = ApiDataRepository()
    private let restApiRepository: RestApiResourceRepository = RestApiRepository()
    
    func getApiRecords(completionHandler: @escaping(_ result: Array<Api>?) -> Void) {
       
        cdApiDataRepository.getApiRecords { response in
            if(response != nil && response?.count != 0) {
                // Return reposne to vview controller
                completionHandler(response)
            } else {
                // Call the api
                restApiRepository.getApiRecords { apiResponse in
                    if(apiResponse != nil && apiResponse?.count != 0) {
                        // Insert in core data
                        _ = cdApiDataRepository.insertApiRecords(records: apiResponse!)
                        completionHandler(apiResponse)
                    }
                }
            }
        }
    }
}
