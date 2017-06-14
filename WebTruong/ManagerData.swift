    //
    //  ManagerData.swift
    //  RaoViet
    //
    //  Created by Chung on 12/5/16.
    //  Copyright © 2016 3i. All rights reserved.
    //
    
    import Foundation
    import SwiftyJSON
    import Alamofire
    class ManagerData : BaseService {
        
        static let instance = ManagerData()
        let baseUrl = "http://localhost/TruongHoc"
        let baseUrlCtrl = "http://localhost/TruongHoc/index.php"
        //Login
        static let SUBMIT_LOGIN = "\(instance.baseUrlCtrl)/User/Login/submit_login"
        static let GET_NEW_POST = "\(instance.baseUrlCtrl)/RestAPI/restPost/getPostNewAllCat"
        static let GET_POST_BY_ID = "\(instance.baseUrlCtrl)/RestAPI/restPost/getPostByID"
        static let DELETE_TOKEN = "\(instance.baseUrlCtrl)/User/Login/json_logout"
        static let UP_POST = "\(instance.baseUrlCtrl)/Post/Post/json_createPost"
        static let NEW_COMMENT = "\(instance.baseUrlCtrl)/comment/comment/json_getNewComment"
        static let SET_COMMENT = "\(instance.baseUrlCtrl)/comment/comment/json_setStatusComment"
        //get all state
        static let ALL_STATE = "http://117.6.131.222:8019/wms/api/state/getAllState/?insecure=cool"
        private var list_State: [State] = []
        
        static let LOGIN = "http://117.6.131.222:8019/wms/api/user/login/?insecure=cool"
        static let REGISTER = "http://117.6.131.222:8019/wms/api/user/register/?insecure=cool"
        
        //list post
        static let GET_ALL_POST_JOB = "http://117.6.131.222:8019/wms/api/post/getAllPostJob/?insecure=cool"
        static let GET_ALL_POST_MARKET = "http://117.6.131.222:8019/wms/api/post/getAllPostMarket/?insecure=cool"
        static let GET_ALL_POST_RENT = "http://117.6.131.222:8019/wms/api/post/getAllPostRental/?insecure=cool"
        
        //get list my post
        
        static let GET_MY_POST = "http://117.6.131.222:8019/wms/api/post/getPostAuthorByType/?insecure=cool"
        //
        //get count job post
        static let COUNT_POST_JOB = "http://117.6.131.222:8019/wms/api/post/count_my_postJob/?insecure=cool"
        
        //get count post market
        static let COUNT_POST_MARKET = "http://117.6.131.222:8019/wms/api/post/count_my_postMaket/?insecure=cool"
        
        //get count post rent
        static let COUNT_POST_RENT = "http://117.6.131.222:8019/wms/api/post/count_my_postRent/?insecure=cool"
        
        
        //detail post
        static let DETAIL_POST_WORKER = "http://117.6.131.222:8019/wms/api/post/getDetailPostJobWorker/?insecure=cool"
        static let DETAIL_POST_ENTERPRISE = "http://117.6.131.222:8019/wms/api/post/getDetailPostEnterprise/?insecure=cool"
        static let DETAIL_POST_BUY = "http://117.6.131.222:8019/wms/api/post/getDetailPostMarketBuy/?insecure=cool"
        static let DETAIL_POST_SELL = "http://117.6.131.222:8019/wms/api/post/getDetailPostMarketSell/?insecure=cool"
        static let DETAIL_POST_RENT_AND_LEASE = "http://117.6.131.222:8019/wms/api/post/getDetailPostRent/?insecure=cool"
        
        
        //Apply post
        static let APPLY_POST = "http://117.6.131.222:8019/wms/api/post/applyPost/?insecure=cool"
        
        static let SHOW_USER_APPLY = "http://117.6.131.222:8019/wms/api/post/showUserApplyPost/?insecure=cool"
        
        static let SHOW_POST_HAS_APPLY_OF_USER = "http://117.6.131.222:8019/wms/api/post/showPostHasApply/?insecure=cool"
        
        //search post
        
        static let SEARCH_POST_JOB_ENTERPRISE = "http://117.6.131.222:8019/wms/api/post/searchPostJobEnterprise/?insecure=cool"
        static let SEARCH_POST_JOB_WORKER = "http://117.6.131.222:8019/wms/api/post/searchPostJobWorker/?insecure=cool"
        static let SEARCH_POST_MARKET_BUY = "http://117.6.131.222:8019/wms/api/post/searchPostMarketBuy/?insecure=cool"
        static let SEARCH_POST_MARKET_SELl = "http://117.6.131.222:8019/wms/api/post/searchPostMarketSell/?insecure=cool"
        static let SEARCH_POST_LEASE = "http://117.6.131.222:8019/wms/api/post/searchPostLease/?insecure=cool"
        static let SEARCH_POST_RENT = "http://117.6.131.222:8019/wms/api/post/searchPostHire/?insecure=cool"
        // insert post
        static let INSERT_POST_ENTERPRISE = "http://117.6.131.222:8019/wms/api/post/insertPostJobEnterprise/?insecure=cool"
        
        static let INSERT_POST_WORKER = "http://117.6.131.222:8019/wms/api/post/insertPostJobWorker/?insecure=cool"
        
        static let INSERT_POST_SELL = "http://117.6.131.222:8019/wms/api/post/insertPostMarketSell/?insecure=cool"
        
        static let INSERT_POST_BUY = "http://117.6.131.222:8019/wms/api/post/insertPostMarketBuy/?insecure=cool"
        
        static let INSERT_POST_LEASE = "http://117.6.131.222:8019/wms/api/post/insertPostLease/?insecure=cool"
        static let INSERT_POST_RENT = "http://117.6.131.222:8019/wms/api/post/insertPostRent/?insecure=cool"
        
        
        //favorite
        
        static let UPDATE_FAVORITE = "http://117.6.131.222:8019/wms/api/post/updateFavorite/?insecure=cool"
        static let GET_POST_FAVORITE = "http://117.6.131.222:8019/wms/api/post/getPotByFavorite/?insecure=cool"
        
        // upload Image
        static let UPLOAD_IMAGE = "http://117.6.131.222:8019/wms/api/post/uploadImage/?insecure=cool"
        static let UPLOAD_AVATAR = "http://117.6.131.222:8019/wms/api/user/uploadImageForUser/?insecure=cool"
        
        //update view count
        
        static let VIEW_COUNT = "http://117.6.131.222:8019/wms/api/post/countViewPost/?insecure=cool"
        
        //edit profile
        
        static let EDIT_PROFILE = "http://117.6.131.222:8019/wms/api/user/editProfile/?insecure=cool"
        
        //Notification
        static let REGISTER_NOTI = "http://117.6.131.222:8019/wms/api/gcm/registerSubcribeNotify/?insecure=cool"
        
        //static let DELETE_TOKEN = "http://117.6.131.222:8019/wms/api/gcm/deleteTokenId/?insecure=cool"
        
        static let GET_USER_SUBCRIBE = "http://117.6.131.222:8019/wms/api/gcm/getUserSubcribe/?insecure=cool"
        
        static let SUBCRIBE_NOTIFY = "http://117.6.131.222:8019/wms/api/gcm/subcribeNotify/?insecure=cool"
        
        static let PUST_NOTIFY = "http://117.6.131.222:8019/wms/api/gcm/pushNotification/?insecure=cool"
        
        static let LIST_USER_SUBCRIBE = "http://117.6.131.222:8019/wms/api/gcm/getListNotifyOfUser/?insecure=cool"
        
        
        static let DELETE_POST = "http://117.6.131.222:8019/wms/api/post/deletePostById/?insecure=cool"
        
        
        static let EDIT_POST_WORKER = "http://117.6.131.222:8019/wms/api/post/editPostWorker/?insecure=cool"
        static let EDIT_POST_ENTERPRISE = "http://117.6.131.222:8019/wms/api/post/editPostBusiness/?insecure=cool"
        static let EDIT_POST_BUY = "http://117.6.131.222:8019/wms/api/post/editPostBuy/?insecure=cool"
        static let EDIT_POST_SELL = "http://117.6.131.222:8019/wms/api/post/editPostSell/?insecure=cool"
        static let EDIT_POST_RENT_AND_LEASE = "http://117.6.131.222:8019/wms/api/post/editPostRent/?insecure=cool"
        
        
        
        static let GET_TOTAL_CREDIT = "http://117.6.131.222:8019/wms/api/post/get_credit/?insecure=cool"
        
        static let GET_ALL_CREDIT_EXCHANGE = "http://117.6.131.222:8019/wms/api/post/get_money_exchange_credit/?insecure=cool"
        static let CHANGE_PASSWORD = "http://117.6.131.222:8019/wms/api/user/editPassword/?insecure=cool"
        func getAllState(success: @escaping (_ data: [State], _ msg: String) -> (),
                         fail: @escaping (_ msg: String) -> ()) {
            if list_State.count == 0 {
                request(url: ManagerData.ALL_STATE, method: .get, params: nil, success: { [unowned self] json, msg in
                    if (json?.array?.count)! > 0 {
                        for item in (json?.array)! {
                            self.list_State.append(State(from: item))
                        }
                    }
                    success(self.list_State,msg)
                    }, fail: { msg in
                        fail(msg)
                })
            }else {
                success(list_State, "ok")
            }
            
            
        }
        //{"phone":"383","email":"","password":"","device":""}
        
        func login(phone_email: String!,password: String!, device: String!, success: @escaping (_ data: JSON?, _ msg: String) -> (),
                   fail: @escaping (_ msg: String) -> ())
        {
            let param = ["q" : "{\"phone_email\":\"\(phone_email!)\",\"password\":\"\(password!)\",\"device\":\"\(device!)\"}"]
            
            request(url: ManagerData.LOGIN, method: .post, params: param, success: { [unowned self] json, msg in
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
            
        }
        
        //    {"displayname":"", "phone_email":"","password":"","device":"", “independent”:”0|1"}
        
        func register(displayName: String, phone_email: String, password: String, device: String, independent: String, success: @escaping (_ data: JSON?, _ msg: String) -> (),
                      fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"displayname\":\"\(displayName)\",\"phone_email\":\"\(phone_email)\",\"password\":\"\(password)\",\"device\":\"\(device)\",\"independent\":\"\(independent)\"}"]
            request(url: ManagerData.REGISTER, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
            
        }
        
        //edit profile
        //    {"user_id":"456","display_name":"abc"}
        func editProfile(user_id: String,display_name: String,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\",\"display_name\":\"\(display_name)\"}"]
            requestReturnMessage(url: ManagerData.EDIT_PROFILE, method: .post, params: param, success: {
                [unowned self] msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(msg)
            })
        }
        
        
        
        // lấy danh sach bài viết
        func getAllPost(type: String,page: String, success: @escaping (_ data: JSON?, _ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"type\":\"\(type)\",\"page\":\"\(page)\"}"]
            var url = ""
            switch type {
            case "worker","enterprise":
                url = ManagerData.GET_ALL_POST_JOB
            case "buy","sell":
                url = ManagerData.GET_ALL_POST_MARKET
            case "rent","lease":
                url = ManagerData.GET_ALL_POST_RENT
            default:
                break
            }
            request(url: url, method: .post, params: param, success: { [unowned self] json, msg in
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        //get list my post
        
        //    {"id":"166","tpye":"","page":""}
        func getListMyPost(id: String, type: String, page: String, success: @escaping (_ data: JSON?, _ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"id\":\"\(id)\",\"type\":\"\(type)\",\"page\":\"\(page)\"}"]
            request(url: ManagerData.GET_MY_POST, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! as! String ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        //get count
        
        //{"user_id":”467“}
        func getCountMyPost(type: String, user_id: String, success: @escaping (_ count: String, _ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\"}"]
            var url = ""
            switch type {
            case "7":
                url = ManagerData.COUNT_POST_JOB
            case "8":
                url = ManagerData.COUNT_POST_MARKET
            case "9":
                url = ManagerData.COUNT_POST_RENT
            default:
                break
            }
            requestReturnCount(url: url, method: .post, params: param, success: { [unowned self] msg, count in
                print(self.convertToDictionary(text: param["q"]! as! String ))
                success(msg, count)
            })
        }
        
        
        
        // get post detail
        
        func getPostDetail(type: typePost,id: Int,user_id: String, success: @escaping (_ data: JSON?, _ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"id\":\"\(id)\",\"user_id\":\"\(user_id)\"}"]
            var url = ""
            switch type {
            case .enterprise:
                url = ManagerData.DETAIL_POST_ENTERPRISE
            case .worker:
                url = ManagerData.DETAIL_POST_WORKER
            case .sell:
                url = ManagerData.DETAIL_POST_SELL
            case .buy:
                url = ManagerData.DETAIL_POST_BUY
            default:
                url = ManagerData.DETAIL_POST_RENT_AND_LEASE
                break
            }
            request(url: url, method: .post, params: param, success: { [unowned self] json, msg in
                print(json)
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        
        //Param: q={"username":"", "user_id":"", "post_id":"", "post_author":"",
        //    "post_title":"","phone":""}
        //Apply post
        func applyPost(username: String,user_id: String,post_id: String,post_author: String,post_title: String, phone: String ,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"username\":\"\(username)\",\"user_id\":\"\(user_id)\",\"post_id\":\"\(post_id)\",\"post_author\":\"\(post_author)\",\"post_title\":\"\(post_title)\",\"phone\":\"\(phone)\"}"]
            requestReturnMessage(url: ManagerData.APPLY_POST, method: .post, params: param, success: {
                [unowned self] msg in
                success(msg)
            })
        }
        
        
        func getPostHasApply(user_id: String, page: String ,success: @escaping (_ data: JSON?,_ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"id\":\"\(user_id)\",\"page\":\"\(page)\"}"]
            request(url: ManagerData.SHOW_POST_HAS_APPLY_OF_USER, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        //get user has apply
        //    {"id":"10193","page":"1"}
        func getUserHasApply(id: String, page: String ,success: @escaping (_ data: JSON?,_ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"id\":\"\(id)\",\"page\":\"\(page)\"}"]
            request(url: ManagerData.SHOW_USER_APPLY, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        
        
        
        
        //favorite
        
        //    {"post_id":"","user_id":""}
        func updateFavorite(post_id: String,user_id: String,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"post_id\":\"\(post_id)\",\"user_id\":\"\(user_id)\"}"]
            requestReturnMessage(url: ManagerData.UPDATE_FAVORITE, method: .post, params: param, success: {
                [unowned self] msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(msg)
            })
        }
        func getPostFavorite(id: String,success: @escaping (_ data: JSON?,_ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"id\":\"\(id)\"}"]
            request(url: ManagerData.GET_POST_FAVORITE, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        
        func searchPost(type: typePost,state: String!,city: String!,keyword: String!, success: @escaping (_ data: JSON?, _ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            var param : [String: Any]!
            var url = ""
            switch type {
            case .enterprise:
                url = ManagerData.SEARCH_POST_JOB_ENTERPRISE
                param = ["q" : "{\"state\":\"\(state!)\",\"city\":\"\(city!)\",\"keyword\":\"\(keyword!)\"}"]
            case .worker:
                url = ManagerData.SEARCH_POST_JOB_WORKER
                param = ["q" : "{\"state\":\"\(state!)\",\"city\":\"\(city!)\",\"keyword\":\"\(keyword!)\"}"]
            case .sell:
                url = ManagerData.SEARCH_POST_MARKET_SELl
                param = ["q" : "{\"state\":\"\(state!)\",\"city\":\"\(city!)\",\"keyword\":\"\(keyword!)\"}"]
            case .buy:
                url = ManagerData.SEARCH_POST_MARKET_BUY
                param = ["q" : "{\"state\":\"\(state!)\",\"city\":\"\(city!)\",\"keyword\":\"\(keyword!)\"}"]
            case .rent:
                url = ManagerData.SEARCH_POST_RENT
                param = ["q" : "{\"state\":\"\(state!)\",\"city\":\"\(city!)\",\"keyword\":\"\(keyword!)\"}"]
            case .lease:
                url = ManagerData.SEARCH_POST_LEASE
                param = ["q" : "{\"state\":\"\(state!)\",\"city\":\"\(city!)\",\"keyword\":\"\(keyword!)\"}"]
            default:
                break
            }
            
            request(url: url, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! as! String))
                //            print(url)
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        func convertToDictionary(text: String) -> String {
            
            return text
        }
        //q={"id":""}
        func updateViewCount(post_id: Int,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"id\":\"\(post_id)\"}"]
            requestReturnMessage(url: ManagerData.VIEW_COUNT, method: .post, params: param, success: {
                [unowned self] msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(msg)
            })
        }
        
        
        //register Notification
        //    {"user_id":"","device":"","token_id":""}
        func registerSubcribeNotify(user_id: String,device: String,token_id: String,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\",\"device\":\"\(device)\",\"token_id\":\"\(token_id)\"}"]
            requestReturnMessage(url: ManagerData.REGISTER_NOTI, method: .post, params: param, success: {
                [unowned self] msg in
                success(msg)
            })
        }
        

        
        //get user subcribe
        ///{"user_id":""}
        func getUserSubcribe(user_id: String,success: @escaping (_ data: JSON?,_ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\"}"]
            requestForUserStatus(url: ManagerData.GET_USER_SUBCRIBE, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        //get list user subcribe
        //    {"user_id":"466","page":"1"}
        func getListUserSubcribe(user_id: String,page: Int,success: @escaping (_ data: JSON?,_ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\",\"page\":\"\(page)\"}"]
            request(url: ManagerData.LIST_USER_SUBCRIBE, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        //Subcribe Category
        //{"user_id":"","categories":"","subcribe":""}
        func subcribeCategory(user_id: String,categories: String,subcribe: String,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\",\"categories\":\"\(categories)\",\"subcribe\":\"\(subcribe)\"}"]
            requestReturnMessage(url: ManagerData.SUBCRIBE_NOTIFY, method: .post, params: param, success: {
                [unowned self] msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(msg)
            })
        }
        
        
        //push notify
        //    {"categories":"worker","message":{"message":"Cong Nguyen đang cần tìm việc 9:10","post_id":"9926","profile_picture":"","type_message":"worker"},"user_id":"6"}
        func pushNotify(user_id: String,categories: String,message: String, post_id: String, profile_picture: String, type_message: String ,success: @escaping (_ data: JSON?,_ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\",\"categories\":\"\(categories)\",\"message\":{\"message\":\"\(message)\",\"post_id\":\"\(post_id)\",\"profile_picture\":\"\(profile_picture)\",\"type_message\":\"\(type_message)\"}}"]
            request(url: ManagerData.PUST_NOTIFY, method: .post, params: param, success: { [unowned self] json, msg in
                print(self.convertToDictionary(text: param["q"]! ))
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        
        //delete post
        //    {"id":""}
        func deletePost(post_id: Int,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"id\":\"\(post_id)\"}"]
            requestReturnMessage(url: ManagerData.DELETE_POST, method: .post, params: param, success: {
                [unowned self] msg in
                success(msg)
            })
        }
        
        //edit post
        func editPost(type: typePost,
                      post_title : String?,
                      post_content: String?,
                      id :  String?,
                      phone: String?,
                      statecity : String?,
                      zipcode: String?,
                      gps: String?,
                      image: String?,
                      price: String?
            , success : @escaping (_ msg : String) -> ()){
            
            var url = ""
            var param : [String: Any]!
            switch type {
            case .enterprise:
                url = ManagerData.EDIT_POST_ENTERPRISE
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"id\":\"\(id!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"salary\":\"\(price!)\"}"]
            case .worker:
                url = ManagerData.EDIT_POST_WORKER
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"id\":\"\(id!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"salary\":\"\(price!)\"}"]
                
            case .sell:
                url = ManagerData.EDIT_POST_SELL
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"id\":\"\(id!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"image\":\"\(image!)\",\"price\":\"\(price!)\"}"]
                
            case .buy:
                url = ManagerData.EDIT_POST_BUY
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"id\":\"\(id!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"image\":\"\(image!)\",\"price\":\"\(price!)\"}"]
                
            case .rent , .lease:
                url = ManagerData.EDIT_POST_RENT_AND_LEASE
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"id\":\"\(id!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"image\":\"\(image!)\",\"price\":\"\(price!)\"}"]
                
            default:
                break
            }
            print(self.convertToDictionary(text: param["q"]! as! String ))
            
            requestReturnMessage(url: url, method: .post, params: param, success: { (msg) in
                success(msg)
            })
        }
        
        
        
        //get total credit
        
        func getTotalCredit(user_id: String?, success : @escaping (_ msg : String) -> (),fail: @escaping (_ msg:String) -> ()){
            let param = ["q" : "{\"user_id\":\"\(user_id)\"}"]
            print(self.convertToDictionary(text: param["q"]! ))
            requestReturnIdPost(url: ManagerData.GET_TOTAL_CREDIT, method: .post, params: param, success: { (msg) in
                success(msg)
            }, fail: { msg in
                fail(msg)
            })
        }
        
        func getAllCreditExchange(success: @escaping (_ data: JSON?, _ msg: String) -> (),fail: @escaping (_ msg: String) -> ()) {
            request(url: ManagerData.GET_ALL_CREDIT_EXCHANGE, method: .post, params: nil, success: { [unowned self] json, msg in
                success(json, msg)
                }, fail: { msg in
                    fail(msg)
            })
        }
        
        
        
        
        
        
    }
    
    extension ManagerData {
        // đăng bài viết
        func insertPostNew(type: typePost,
                           post_title : String?,
                           post_content: String?,
                           post_author :  String?,
                           phone: String?,
                           statecity : String?,
                           zipcode: String?,
                           gps: String?,
                           image: String?,
                           price: String?
            , success : @escaping (_ msg : String) -> (),
              fail: @escaping (_ msg:String) -> ()){
            
            var url = ""
            var param : [String: Any]!
            switch type {
            case .enterprise:
                url = ManagerData.INSERT_POST_ENTERPRISE
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"post_author\":\"\(post_author!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"salary\":\"\(price!)\"}"]
            case .worker:
                url = ManagerData.INSERT_POST_WORKER
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"post_author\":\"\(post_author!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"salary\":\"\(price!)\"}"]
                
            case .sell:
                url = ManagerData.INSERT_POST_SELL
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"post_author\":\"\(post_author!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"image\":\"\(image!)\",\"price\":\"\(price!)\"}"]
                
            case .buy:
                url = ManagerData.INSERT_POST_BUY
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"post_author\":\"\(post_author!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"image\":\"\(image!)\",\"price\":\"\(price!)\"}"]
                
            case .rent:
                url = ManagerData.INSERT_POST_RENT
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"post_author\":\"\(post_author!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"image\":\"\(image!)\",\"price\":\"\(price!)\"}"]
            case .lease:
                url = ManagerData.INSERT_POST_LEASE
                param =  ["q" :"{\"post_title\":\"\(post_title!)\",\"post_content\":\"\(post_content!)\",\"post_author\":\"\(post_author!)\",\"phone\":\"\(phone!)\",\"statecity\":\"\(statecity!)\",\"zipcode\":\"\(zipcode!)\",\"gps\":\"\(gps!)\",\"image\":\"\(image!)\",\"price\":\"\(price!)\"}"]
                
            default:
                break
            }
            print(self.convertToDictionary(text: param["q"]! as! String ))
            
            requestReturnIdPost(url: url, method: .post, params: param, success: { (msg) in
                success(msg)
            }, fail: { msg in
                fail(msg)
            })
        }
        
        //root
        //                func uploadAvatar(image: UIImage!, user_id : String, success :  @escaping (_ url : String ) -> () , fail :  @escaping (_ msg : String ) -> ()){
        //                    let imageData = UIImageJPEGRepresentation(image, 0.5)
        //                    let photoImage = ImageModel(imageData: imageData!, imageType: .ImageJpeg, imageName: randomImageName(with: user_id))
        //        //            let pagram : [String : Any ]    = [ "user_id" : user_id,
        //        //                                                "image" : imageData]
        //                    let pagram : [String : Any ] =  ["q" :"{\"user_id\":\"\(user_id)\"}",
        //                        "image" : photoImage
        //                    ]
        //
        //                    print(pagram)
        //                    let urlRequest = urlRequestWithComponents(ManagerData.UPLOAD_AVATAR, parameters: pagram)
        //                    Alamofire.upload(urlRequest.1, with: urlRequest.0).responseData { response  in
        //                        switch response.result {
        //                        case .success(let result):
        //                            let json = JSON(result)
        //                            print("result: \(result)")
        //
        //
        //                            if let user_url = json["user_id"].string {
        //                                print("user id : \(user_url)")
        //                                success(user_url)
        //                            }else if let response = json["response"].string {
        //                                fail(response)
        //                            }
        //                            break
        //                        case .failure(let fail):
        //                            print(fail)
        //                        }
        //                    }
        //                }
        
        func uploadAvatar(image: UIImage!, user_id : String, success :  @escaping (_ url : String ) -> () , fail :  @escaping (_ msg : String ) -> ()){
            
            let pagram  =  ["q" :"{\"user_id\":\"\(user_id)\"}"]
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                    multipartFormData.append(imageData, withName: randomImageName(with: user_id), mimeType: "image/jpeg")
                    print("image \(imageData.description)")
                }
                
                for (key, value) in pagram {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }}, to: ManagerData.UPLOAD_AVATAR, method: .post, headers: nil,
                    encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.validate().responseJSON {  response in
                                switch response.result {
                                case .success(let result):
                                    let json = JSON(result)
                                    print("result: \(result)")
                                    if let user_url = json["user_url"].string {
                                        success(user_url)
                                    }else if let response = json["status"].string {
                                        fail(response)
                                        print("response : \(response)")
                                    }
                                    
                                case .failure(let fail):
                                    print(fail)
                                }
                            }
                        case .failure(let encodingError):
                            print("error:\(encodingError)")
                        }
            })
        }
        
        
        
        
        
        //--
        func uploadImagePost(image : UIImage!,
                             with name: String,
                             success : @escaping (_ url: String) -> () ,
                             failure : (_ msg : String) -> ()){
            
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            let photoImage = ImageModel(imageData: imageData!, imageType: .ImageJpeg, imageName: name)
            let parametes : [String : Any] = ["image" : photoImage]
            
            let urlRequest = urlRequestWithComponents(ManagerData.UPLOAD_IMAGE, parameters: parametes)
            Alamofire.upload(urlRequest.1, with: urlRequest.0).responseJSON { response in
                
                switch response.result {
                    
                case .success(let result):
                    let json = JSON(result)
                    let link = json["link"].string!
                    success(link)
                    break
                case .failure(let fail):
                    print(fail)
                }
            }
            
        }
        
        
        //- custom body http
        func urlRequestWithComponents(_ urlString: String, parameters: [String:Any]) -> (URLRequestConvertible, Data) {
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = Alamofire.HTTPMethod.post.rawValue
            let boundaryConstant = "Boundary-\(NSUUID().uuidString)"
            let contentType = "multipart/form-data;boundary="+boundaryConstant
            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
            var uploadData = Data()
            for (key, value) in parameters {
                uploadData.append("--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
                if value is ImageModel {
                    let netImage = value as! ImageModel
                    let filenameClause = " filename=\"\(netImage.imageName)\""
                    let contentDispositionString = "Content-Disposition: form-data; name=\"\(key)\";\(filenameClause)\r\n"
                    let contentDispositionData = contentDispositionString.data(using: String.Encoding.utf8)
                    uploadData.append(contentDispositionData!)
                    let contentTypeString = "Content-Type: \(netImage.imageType.getString())\r\n\r\n"
                    let contentTypeData = contentTypeString.data(using: String.Encoding.utf8)
                    uploadData.append(contentTypeData!)
                    uploadData.append(netImage.imageData as Data)
                    uploadData.append("\r\n".data(using: String.Encoding.utf8)!)
                    uploadData.append("--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
                    
                }
            }
            urlRequest.httpBody = uploadData
            let request = try! URLEncoding.default.encode(urlRequest, with: nil)
            
            return (request, uploadData as Data)
        }
        
        
        //func Change Password
        func changePassword(userid:String, oldPass: String, newPass: String, modifyPass: String, success: @escaping(_ msg: String)->())
        {
            let param = ["q":"{\"user_id\":\"\(userid)\",\"password_old\":\"\(oldPass)\",\"password_new\":\"\(newPass)\",\"password_confirm\":\"\(modifyPass)\"}"]
            requestReturnChange(url: ManagerData.CHANGE_PASSWORD, method: .post, param: param, success: {[unowned self] msg in success(msg)})
        }
        
        //WebTruong
        func submitLogin(userid:String, pass: String, success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
        {
            let param = ["username":userid, "password" : pass,"submit_login": 1,"remember": false] as [String : Any]
            requestSubmit(url: ManagerData.SUBMIT_LOGIN, method: .post, param: param, success: {[unowned self] data in success(data)}, fail: {[unowned self] msg in fail(msg)})
        }
    
        func getPost(type: Int, page: Int,success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
        {
            let param = ["type":type, "page" : page] as [String : Any]
             requestSubmit(url: ManagerData.GET_NEW_POST, method: .post, param: param, success: {[unowned self] data in success(data)}, fail: {[unowned self] msg in fail(msg)})
        }
        func getPostbyID(id: Int,success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
        {
            let param = ["id":id] as [String : Any]
            requestSubmit(url: ManagerData.GET_POST_BY_ID, method: .post, param: param, success: {[unowned self] data in success(data)}, fail: {[unowned self] msg in fail(msg)})
        }
        func setStatusComment(id: Int,success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
        {
            let param = ["id":id,"status":1] as [String : Any]
            requestSubmit(url: ManagerData.SET_COMMENT, method: .post, param: param, success: {[unowned self] data in success(data)}, fail: {[unowned self] msg in fail(msg)})
        }
        func getNewComment(success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
        {
            requestNoParam(url: ManagerData.NEW_COMMENT, method: .post, success: {[unowned self] data in success(data)}, fail: {[unowned self] msg in fail(msg)})
        }
        //UP Post
        func upPost(title: String,content: String, tags: String, subCategory: Int,success: @escaping(_ data: JSON)->(), fail: @escaping(_ msg: String)->())
        {
            let param = ["title":title,"editor":content,"tags":tags,"subcategory":subCategory] as [String : Any]
            requestSubmit(url: ManagerData.UP_POST, method: .post, param: param, success: {[unowned self] data in success(data)}, fail: {[unowned self] msg in fail(msg)})
        }
        //delete token
        //    {"user_id":"","device":""}
        func deleteTokenId(user_id: String,device: String,success: @escaping (_ msg: String) -> ()) {
            let param = ["q" : "{\"user_id\":\"\(user_id)\",\"device\":\"\(device)\"}"]
            requestSubmit(url: ManagerData.DELETE_TOKEN, method: .post, param: param, success: {
                [unowned self] msg in
                success("ok")
                },fail:{
                    [unowned self] msg in success(msg)
            })
        }
    }
    
    
