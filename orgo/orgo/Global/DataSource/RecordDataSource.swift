//
//  RecordDataSource.swift
//  orgo
//
//  Created by 김태현 on 2023/09/12.
//

import RxDataSources

struct RecordDataSource {
    var items: [Item]
}

extension RecordDataSource: SectionModelType {
    typealias Item = RecordResponseModel
    
    init(original: RecordDataSource, items: [Item]) {
        self = original
        self.items = items
    }
}
