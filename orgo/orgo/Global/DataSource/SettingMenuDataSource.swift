//
//  SettingMenuDataSource.swift
//  orgo
//
//  Created by 김태현 on 2023/09/12.
//

import RxDataSources

struct SettingMenuDataSource {
    var items: [Item]
}

extension SettingMenuDataSource: SectionModelType {
    typealias Item = SettingMenu
    
    init(original: SettingMenuDataSource, items: [Item]) {
        self = original
        self.items = items
    }
}
