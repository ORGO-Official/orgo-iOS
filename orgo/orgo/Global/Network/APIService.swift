//
//  APIService.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

import Alamofire
import RxSwift

protocol APIService {
    
    func requestGet<T: Decodable>(urlResource: URLResource<T>) -> Observable<Result<T, APIError>>
    
    func reqeustPost<T: Decodable>(urlResource: URLResource<T>, parameter: Parameters?) -> Observable<Result<T, APIError>>
    
    func reqeustPostWithImage<T: Decodable>(urlResource: URLResource<T>, parameter: Parameters, image: UIImage) -> Observable<Result<T, APIError>>
    
}
