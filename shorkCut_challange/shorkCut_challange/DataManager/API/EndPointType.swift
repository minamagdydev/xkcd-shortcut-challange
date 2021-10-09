import Foundation

protocol EndPointType {
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    // More tasks can be added here such as if we want to add more headers for authentication etc.
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
}
