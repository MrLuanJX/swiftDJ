//
//  LJXRequestSwiftTool.swift
//  LJXSwiftTest
//
//  Created by a on 2019/5/8.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import Alamofire

// block
public typealias Success = (_ data : Any)->()
public typealias Failure = (_ error : Error)->()
public typealias Progress = (_ currentProgress : Any)->()

class LJXRequestSwiftTool: NSObject {
    
    //单例
    static let shareInstance:LJXRequestSwiftTool = {
    
        let tools = LJXRequestSwiftTool()
        
        return tools
    }()
}

extension LJXRequestSwiftTool {
    
    /// header
    public var headerFields: [String: String]{
        var header: [String:String] = [:]
        header["version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        header["type"] = "ios"
        return header
    }
    
    /// GET请求
    func getRequest (
         urlString: String,
         params: Parameters? = nil,
         header: String? = nil,
         success: @escaping Success,
         failure: @escaping Failure) {
        request(urlString, params: params, method: .get, success, failure)
    }
    
    /// POST请求
    func postRequest (
        urlString: String,
        params: Parameters? = nil,
        success: @escaping Success,
        failure: @escaping Failure) {
        
        request(urlString, params: params, method: .post, success, failure)
    }
    
    /// 上传图片
    func uploadRequest (
        urlString: String,
        imageData: NSData? = nil,
        usingThreshold: CUnsignedLongLong? = nil,
        params: Parameters? = nil,
        method: HTTPMethod? = nil,
        fileName: String? = nil,
        currentProgress: @escaping Progress,
        success: @escaping Success,
        failure: @escaping Failure) {

        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        manager.upload(multipartFormData: { (formdata) in
            formdata.append(imageData! as Data, withName: fileName! as String, mimeType: "image/jpeg")

        }, usingThreshold: usingThreshold! as CUnsignedLongLong, to: urlString as String, method: method! as HTTPMethod, headers: headerFields, queue: nil) { (encodingResult) in
            switch encodingResult{
                
            case .success(let uploadFile, _, _):
                // 上传进度回调
                uploadFile.uploadProgress(closure: { (progress) in
                    debugPrint("上传进度\(progress)")
                    currentProgress(progress)
                })
                // 上传结果回调
                uploadFile.responseString(completionHandler: { (response) in
                    
                    success(response.result.value as Any)
                })
                break
            case .failure( let error):
                
                failure(error)
                break
            }
        }
    }
    
    /// 下载
    func downLoad(urlString: String,
                  method: HTTPMethod? = nil,
                  params: Parameters? = nil,
                  currentProgress: @escaping Progress,
                  success: @escaping Success,
                  failure: @escaping Failure) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        //指定下载路径（文件名不变）
       let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
       manager.download(urlString as String, method: method! as HTTPMethod, parameters: params, encoding: JSONEncoding.default, headers: headerFields, to: destination).downloadProgress { (progress) in
            
            print("当前进度--",progress)
            
            }.responseData { (response) in
                
                switch (response.result) {
                    case .success:
                    print("下载完毕!")
                    success(response.result.value as Any)
                    break
                    
                case .failure(let error):
                    failure(error)
                    break
                }
        }

    }
    
    /// 公共的私有方法
    private func request(
        _ urlString: String, params: Parameters? = nil, method: HTTPMethod,
        _ success: @escaping Success,
        _ failure: @escaping Failure) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        manager.request(urlString, method: method, parameters: params, encoding: JSONEncoding.default, headers: headerFields).responseJSON { (response) in
            guard response.result.value != nil else {
                return
            }
            switch (response.result) {
            case .success:
                
                success(response.result.value as Any)
                
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
}
