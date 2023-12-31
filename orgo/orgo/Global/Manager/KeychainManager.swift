//
//  KeychainManager.swift
//  orgo
//
//  Created by 김태현 on 2023/08/16.
//

import Foundation

final class KeychainManager {
    
    // MARK: - Variables and Properties
    
    static let shared = KeychainManager()
    
    private let service = Bundle.main.bundleIdentifier!
    
    // MARK: - Life Cycle
    
    private init() {}
    
    // MARK: - Save, Update, Read, Delete
    
    @discardableResult
    func save(key: Key, value: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue,
            kSecValueData: value.data(using: .utf8)!
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            if status == errSecDuplicateItem {
                return update(key: key, value: value)
            }
            
            print("\(key.rawValue)를 Keychain에 저장하는 중에 오류가 발생했습니다.")
            
            return false
        }
        
        return true
    }
    
    @discardableResult
    private func update(key: Key, value: String) -> Bool {
        let prevQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue
        ]
        
        let updateQuery: [CFString: Any] = [
            kSecValueData: value.data(using: .utf8)!
        ]
        
        let status = SecItemUpdate(prevQuery as CFDictionary,
                                   updateQuery as CFDictionary)
        
        guard status == errSecSuccess else {
            print("\(key.rawValue)를 Keychain에 저장하는 중에 오류가 발생했습니다.")
            
            return false
        }
        
        return true
    }
    
    func read(for key: Key) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
    
    @discardableResult
    func delete(for key: Key) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            print("\(key.rawValue)를 Keychain에서 삭제하는 중에 오류가 발생했습니다.")
            
            return false
        }
        
        return true
    }
    
}

// MARK: - Custom Functions

extension KeychainManager {
    
    /// 액세스 토큰 리프레시
    func refresh(accessToken: String) {
        save(key: .accessToken, value: accessToken)
    }
    
    /// 로컬 디바이스에 저장된 사용자의 기본정보 모두 제거
    func removeAllKeys() {
        KeychainManager.Key.allCases.forEach {
            delete(for: $0)
        }
    }
    
}

// MARK: - Keys

extension KeychainManager {
    
    enum Key: String, CaseIterable {
        case isFirst
        
        case identifier
        case loginType
        
        case accessToken
        case refreshToken

        case email
    }
    
}

