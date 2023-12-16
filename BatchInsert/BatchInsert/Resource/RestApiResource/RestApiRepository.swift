import Foundation

struct RestApiRepository : RestApiResourceRepository {
    
    func getApiRecords(completionHandler: @escaping (Array<Api>?) -> Void) {
        
        URLSession.shared.dataTask(with: ApiResource.apiResource) { (data, response, error) in
            if(error == nil && data != nil) {
                do {
                        // deocding the response
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data!)
                    if(result.count > 0) {
                        completionHandler(result.apis) // sending decoded response back
                    } else {
                        debugPrint("error in response, please contact codecat15")
                    }
                    
                } catch let error {
                    debugPrint(error)
                }
            }
            
        }.resume()
    }
}
