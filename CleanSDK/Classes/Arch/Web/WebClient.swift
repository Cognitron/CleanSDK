//
//  WebClient.swift
//  Clean
//
//  Created by Artem Eremeev on 11/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxCocoa

public class WebClient: DataProvider {
    
    public func request<T: Decodable>(route: RouterType, method: HTTPMethod, settings: WebClientRequestSetting...) -> Single<T> {
        return Single.create { observer in
            
            self.loading?.accept(true)
            
            let request = try! self.createRequest(route: route, method: method, settings: settings)
            let dataRequest = Alamofire.SessionManager.default.request(request)
            
            dataRequest.responseData(completionHandler: { dataResponse in
                self.processResponse(route: route, dataResponse: dataResponse, observer: observer)
            })
            
            return Disposables.create {
                dataRequest.cancel()
                self.loading?.accept(false)
            }
        }
    }
    
    public func request(route: RouterType, method: HTTPMethod, settings: WebClientRequestSetting...) -> Single<Void> {
        return Single.create { observer in
            
            self.loading?.accept(true)
            
            let request = try! self.createRequest(route: route, method: method, settings: settings)
            let dataRequest = Alamofire.SessionManager.default.request(request)
            
            dataRequest.responseString(completionHandler: { dataResponse in
                self.processResponse(route: route, dataResponse: dataResponse, observer: observer)
            })
            
            return Disposables.create {
                dataRequest.cancel()
                self.loading?.accept(false)
            }
        }
    }
    
    public func multipartRequest<T: Decodable>(route: RouterType, method: HTTPMethod, fields: [MultipartField], settings: WebClientRequestSetting...) -> Single<T> {
        return Single.create { observer in
            
            self.loading?.accept(true)
            
            let request = try! self.createRequest(route: route, method: method, settings: settings)
            var uploadRequest: UploadRequest!
            
            Alamofire.SessionManager.default.upload(multipartFormData: { multipart in
                if Debugger.needDebugWebParameters {
                    print("Multipart fields for \(route.path):")
                    print(fields)
                }
                self.prepareMultipart(multipart: multipart, fields: fields)
            }, with: request, encodingCompletion: { result in
                
                switch result {
                case let .success(request, _, _):
                    uploadRequest = request
                    request.responseData(completionHandler: { dataResponse in
                        self.processResponse(route: route, dataResponse: dataResponse, observer: observer)
                    })
                    
                case let .failure(error):
                    let errorCode = error._code
                    self.processErrorCode(errorCode: errorCode, errorBody: "", observer: observer)
                }
            })
            
            return Disposables.create {
                uploadRequest?.cancel()
                self.loading?.accept(false)
            }
        }
    }
    
    public func multipartRequest(route: RouterType, method: HTTPMethod, fields: [MultipartField], settings: WebClientRequestSetting...) -> Single<Void> {
        return Single.create { observer in
            
            self.loading?.accept(true)
            
            let request = try! self.createRequest(route: route, method: method, settings: settings)
            var uploadRequest: UploadRequest!
            
            Alamofire.SessionManager.default.upload(multipartFormData: { multipart in
                if Debugger.needDebugWebParameters {
                    print("Multipart fields for \(route.path):")
                    print(fields)
                }
                self.prepareMultipart(multipart: multipart, fields: fields)
            }, with: request, encodingCompletion: { result in
                
                switch result {
                case let .success(request, _, _):
                    uploadRequest = request
                    request.responseString(completionHandler: { dataResponse in
                        self.processResponse(route: route, dataResponse: dataResponse, observer: observer)
                    })
                    
                case let .failure(error):
                    let errorCode = error._code
                    self.processErrorCode(errorCode: errorCode, errorBody: "", observer: observer)
                }
            })
            
            return Disposables.create {
                uploadRequest?.cancel()
                self.loading?.accept(false)
            }
        }
    }
    
    private func createRequest(route: RouterType, method: HTTPMethod, settings: [WebClientRequestSetting]) throws -> URLRequest {
        guard var request = try? URLRequest(url: route.path, method: method) else {
            throw WebClientError.requestCreating
        }
        
        if Debugger.needDebugWebRoute {
            print("Route:", route.path)
            print("Method:", method.rawValue)
        }
        
        for setting in settings {
            switch setting {
            case let .queryParameters(parameters):
                request = try URLEncoding.queryString.encode(request, with: parameters)
                if Debugger.needDebugWebParameters {
                    print("URL query parameters for \(route.path):")
                    print(parameters)
                }
            case let .jsonBody(parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                if Debugger.needDebugWebParameters {
                    print("JSON parameters for \(route.path):")
                    print(parameters)
                }
            case let .form(parameters):
                request = try URLEncoding.default.encode(request, with: parameters)
                if Debugger.needDebugWebParameters {
                    print("Form parameters for \(route.path):")
                    print(parameters)
                }
                
            case let .headers(headers):
                headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
                if Debugger.needDebugWebHeaders {
                    print("Headers for \(route.path):")
                    print(headers)
                }
                
            case let .basicAuth(user, password):
                if let authorization = "\(user):\(password)".data(using: .utf8)?.base64EncodedString() {
                    request.addValue("Basic \(authorization)", forHTTPHeaderField: "Authorization")
                }
            }
        }
        
        return request
    }
    
    private func processResponse<T: Decodable>(route: RouterType, dataResponse: DataResponse<Data>, observer: (SingleEvent<T>) -> Void) {
        
        let data = dataResponse.data ?? Data()
        let body = String(data: data, encoding: .utf8) ?? "no body"
        
        if Debugger.needDebugWebResponse {
            print("Response for \(route.path)")
            print("Success:", dataResponse.result.isSuccess)
        }
        
        if dataResponse.result.isSuccess {
            if Debugger.needDebugWebResponse {
                print("Body:")
                print(body)
            }
            do {
                let decoded: T = try decode(data: data)
                observer(.success(decoded))
            } catch let error {
                observer(.error(error))
            }
        } else {
            let errorCode = dataResponse.response?.statusCode ?? dataResponse.error?._code ?? 0
            if Debugger.needDebugWebResponse {
                if let statusCode = dataResponse.response?.statusCode {
                    print("Status code for \(route.path):", statusCode)
                } else if let errorCode = dataResponse.error?._code {
                    print("Error code for \(route.path):", errorCode)
                } else {
                    print("Unknown error for \(route.path)")
                }
            }
            processErrorCode(errorCode: errorCode, errorBody: body, observer: observer)
        }
    }
    
    private func processResponse(route: RouterType, dataResponse: DataResponse<String>, observer: (SingleEvent<Void>) -> Void) {
        
        let data = dataResponse.data ?? Data()
        let body = String(data: data, encoding: .utf8) ?? "no body"
        
        if Debugger.needDebugWebResponse {
            print("Response for \(route.path)")
            print("Success:", dataResponse.result.isSuccess)
        }
        
        if dataResponse.result.isSuccess {
            observer(.success(()))
        } else {
            let errorCode = dataResponse.response?.statusCode ?? dataResponse.error?._code ?? 0
            if Debugger.needDebugWebResponse {
                if let statusCode = dataResponse.response?.statusCode {
                    print("Status code for \(route.path):", statusCode)
                } else if let errorCode = dataResponse.error?._code {
                    print("Error code for \(route.path):", errorCode)
                } else {
                    print("Unknown error for \(route.path)")
                }
            }
            processErrorCode(errorCode: errorCode, errorBody: body, observer: observer)
        }
    }
    
    private func processErrorCode<T>(errorCode: Int, errorBody: String, observer: (SingleEvent<T>) -> Void) {
        switch errorCode {
        case NSURLErrorNotConnectedToInternet:
            observer(.error(WebClientError.notConnectedToInternet))
        case NSURLErrorTimedOut:
            observer(.error(WebClientError.timedOut))
        default:
            observer(.error(WebClientError.unknown(body: errorBody)))
        }
    }
    
    private func prepareMultipart(multipart: MultipartFormData, fields: [MultipartField]) {
        for field in fields {
            switch field {
            case let .jpegImage(image, imageName, field):
                if let data = image.jpegData(compressionQuality: 1) {
                    multipart.append(data, withName: field,
                                     fileName: imageName.contains(".jpeg") ? imageName : "\(imageName).jpeg",
                                     mimeType: "image/jpeg")
                }
                
            case let .pngImage(image, imageName, field):
                if let data = image.pngData() {
                    multipart.append(data, withName: field,
                                     fileName: imageName.contains(".png") ? imageName : "\(imageName).png",
                                     mimeType: "image/png")
                }
                
            case let .value(value, field):
                if let data = "\(value)".data(using: .utf8) {
                    multipart.append(data, withName: field)
                }
                
            case let .file(fileData, fileName, field):
                multipart.append(fileData, withName: field, fileName: fileName, mimeType: "")
            }
            
            
        }
    }
    
    
    
    private func decode<T: Decodable>(data: Data) throws -> T  {
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(T.self, from: data) else {
            throw WebClientError.decoding(body: String(data: data, encoding: .utf8) ?? "")
        }
        return result
    }
    
}

