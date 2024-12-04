//
//  Model.swift
//  Neovify completed task
//
//  Created by Saumil Doshi on 04/11/24.
//

import Foundation

struct BaseResponseModel<T: Codable>: Codable {
    let status : Bool?
    let response_code : Int?
    let message : String?
    let data : [T]?
}

struct BannerListModel: Codable {
    let channel_id : Int?
    let program_name : String?
    let description : String?
    let status : String?
    let image : String?
    let optimised_image : String?
    let background_image : String?
    let channel_name : String?
    let callSign : String?
    let stationName : String?
    let url : String?
    let dash_url : String?
    let smooth_url : String?
    let zip_code : [String]?
    let favourite : Bool?
}

struct GenreListModel : Codable {
    let genre_name : String?
    let channels : [ChannelListModel]?
}

struct ChannelListModel : Codable {
    let id : Int?
    let prgSvcId : Int?
    let url : String?
    let stationName : String?
    let callSign : String?
    let timeZone : String?
    let channel_url : String?
    let genre_name : String?
    let favourite : Bool?
    let image : String?
}

