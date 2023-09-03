//
//  SearchResultDataSource.swift
//  orgo
//
//  Created by 김태현 on 2023/09/04.
//

import RxDataSources

struct SearchResultDataSource {
    var items: [Item]
}

extension SearchResultDataSource: SectionModelType {
    typealias Item = MountainListResponseModel
    
    init(original: SearchResultDataSource, items: [Item]) {
        self = original
        self.items = items
    }
}
