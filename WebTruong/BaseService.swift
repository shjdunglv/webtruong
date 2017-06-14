//
//  BaseService.swift
//  RaoViet
//
//  Created by Chung on 12/5/16.
//  Copyright © 2016 3i. All rights reserved.
//

//
//"status": "ok",
//"response": "ok",
//"message":

import Foundation
import Alamofire
import SwiftyJSON
class BaseService: NSObject {
    func request(url: String, method: Alamofire.HTTPMethod , params: [String : Any]?,
                 success: @escaping (_ data: JSON?, _ msg: String) -> (),
                 fail: @escaping (_ msg: String) -> ()) {
        Alamofire.request(url, method: method, parameters: params).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                let msg = json["response"].string
                let data = json["message"]
                if data != nil {
                    success(data, msg!)
                }else {
                    fail(msg!)
                }
            case .failure:
                
                break
            }
        }
        
    }
    func requestReturnMessage(url: String, method: Alamofire.HTTPMethod , params: [String : Any],
                              success: @escaping ( _ msg: String) -> ())
    {
        Alamofire.request(url, method: method, parameters: params).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                if let msg = json["response"].string {
                    success(msg)
                }else if let count = json["view_count"].int {
                    success(String(count))
                }else if let status = json["status"].string {
                    success(status)
                }
                
            case .failure:
                
                break
            }
        }
        
    }
    
    func requestReturnIdPost(url: String, method: Alamofire.HTTPMethod , params: [String : Any],
                             success: @escaping (_ msg: String) -> (), fail: @escaping (_ msg:String) -> ())
    {
        Alamofire.request(url, method: method, parameters: params).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                if let idPost = json["idpost"].int {
                    success(String(idPost))
                }else if let credit = json["credit"].string {
                    success(credit)
                }else {
                    let response = json["response"].string
                    fail(response!)
                }
            case .failure:
                break
            }
        }
        
    }
    
    func requestForUserStatus(url: String, method: Alamofire.HTTPMethod , params: [String : Any]?,
                              success: @escaping (_ data: JSON?, _ msg: String) -> (),
                              fail: @escaping (_ msg: String) -> ()) {
        Alamofire.request(url, method: method, parameters: params).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                let msg = json["status"].string
                let data = json["response"]
                if data != nil {
                    success(data, msg!)
                }else {
                    fail(msg!)
                }
            case .failure:
                break
            }
        }
        
    }
    func requestReturnCount(url: String, method: Alamofire.HTTPMethod , params: [String : Any]?,
                            success: @escaping (_ msg: String, _ count: String) -> ()) {
        Alamofire.request(url, method: method, parameters: params).responseJSON { [unowned self] response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                let msg = json["response"].string
                let count = json["count"].string
                success(msg!,count!)
            case .failure:
                break
            }
        }
        
    }
    func requestReturnChange(url: String, method: Alamofire.HTTPMethod, param: [String: Any]?, success: @escaping(_ msg: String)->())
    {
        Alamofire.request(url, method: method, parameters: param).responseJSON{
            [unowned self] response in
            switch response.result
            {
            case .success(let result):
                let json = JSON(result)
                success(json["response"].string!)
                break
            case .failure: break
            }
        }
    }
    
    //webTruong
    func requestSubmit(url: String, method: Alamofire.HTTPMethod, param: [String: Any]?, success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
    {
        Alamofire.request(url, method: method, parameters: param).responseJSON{
            [unowned self] response in
            switch response.result
            {
            case .success(let result):
                let json = JSON(result)
                if json[0] == true
                {
                 success(json)
                }
                else
                {
                    fail(json[1].string!)
                }
                
            case .failure: fail("Error Connection!"); break;
            }
        }
    }
    func requestNoParam(url: String, method: Alamofire.HTTPMethod, success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
    {
        Alamofire.request(url, method: method, parameters: nil).responseJSON{
            [unowned self] response in
            switch response.result
            {
            case .success(let result):
                let json = JSON(result)
                if json[0] == true
                {
                    success(json)
                }
                else if json[0] == false
                {
                    fail(json[1].string!)
                }
                else{
                fail("Error not consident")
                }
            case .failure: fail("Error Connection!"); break;
            }
        }
    }
    
    //    func urlRequestWithComponents(_ urlString : String, parameters : [String: Any]) -> (URLRequestConvertible,Data){
    //
    //         var urlRequest = URLRequest(url: URL(string: urlString)!)
    //            urlRequest.httpMethod = Alamofire.HTTPMethod.post.rawValue
    //
    //        return nil
    //
    //    }
    
    
}
