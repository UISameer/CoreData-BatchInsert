import Foundation

extension CDApis {
    func convertToApi() -> Api {
        return Api(api: self.api!, textDescription: self.textDescription!, auth: self.auth!, https: self.https, cors: self.cors!, link: self.link!, category: self.category!)
    }
}
