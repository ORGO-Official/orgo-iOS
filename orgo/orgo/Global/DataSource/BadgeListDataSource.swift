//
//  BadgeListDataSource.swift
//  orgo
//
//  Created by 김태현 on 2023/10/14.
//

import RxDataSources

struct BadgeListDataSource {
    let header: String
    var items: [Item]
}

extension BadgeListDataSource: SectionModelType {
    typealias Item = Badge
    
    init(original: BadgeListDataSource, items: [Item]) {
        self = original
        self.items = items
    }
}
