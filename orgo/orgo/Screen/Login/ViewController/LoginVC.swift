//
//  LoginVC.swift
//  orgo
//
//  Created by 김태현 on 2023/08/15.
//

import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import NaverThirdPartyLogin
import AuthenticationServices


class LoginVC: BaseViewController {
    
    // MARK: - UI components
    
    private let logoImageView = UIImageView(image: ImageAssets.orgoLogoGreen)
    
    private let stackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 12.0
        }
    
    private let kakaoLoginBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.kakaoLogin, for: .normal)
        }
    
    private let naverLoginBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.naverLogin, for: .normal)
        }
    
    private let appleLoginBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.appleLogin, for: .normal)
        }
    
    private let loginBorder = UIImageView(image: ImageAssets.loginBorder)
    
    private let loginNextBtn = UIButton(type: .system)
        .then {
            $0.setImage(ImageAssets.loginNext, for: .normal)
        }
    
    
    // MARK: - Variables and Properties
    
    private let viewModel: LoginVM = LoginVM()
    private let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    var isFirstNaverLogin = true
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naverLoginInstance?.delegate = self
    }
    
    override func configureView() {
        super.configureView()
        
        configureInnerView()
    }
    
    override func layoutView() {
        super.layoutView()
        
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        
        bindBtn()
    }
    
    override func bindOutput() {
        super.bindOutput()
        
        bindLoginSuccess()
    }
    
    
    // MARK: - Functions
    
    private func appleAuthorization() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}


// MARK: - Configure

extension LoginVC {
    
    private func configureInnerView() {
        view.addSubviews([logoImageView, stackView])
        [kakaoLoginBtn, naverLoginBtn, appleLoginBtn, loginBorder, loginNextBtn].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
}


// MARK: - Layout

extension LoginVC {
    
    private func configureLayout() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(140.0)
            $0.height.equalTo(logoImageView.snp.width).dividedBy(2.43)
            $0.top.equalToSuperview().offset(200.0)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(110.0)
            $0.trailing.leading.equalToSuperview().inset(50.0)
        }
        
        [kakaoLoginBtn, naverLoginBtn, appleLoginBtn, loginNextBtn].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(stackView.snp.width).dividedBy(5.62)
            }
        }
        
        loginBorder.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.width).dividedBy(19.13)
        }
    }
    
}


// MARK: - Input

extension LoginVC {
    
    private func bindBtn() {
        kakaoLoginBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.viewModel.requestKakaoLogin()
            })
            .disposed(by: bag)
        
        naverLoginBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.naverLoginInstance?.requestThirdPartyLogin()
            })
            .disposed(by: bag)
        
        appleLoginBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.appleAuthorization()
            })
            .disposed(by: bag)
        
        loginNextBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVCToHome()
            })
            .disposed(by: bag)
    }
    
}


// MARK: - Output

extension LoginVC {
    
    /// 로그인 성공 감지
    private func bindLoginSuccess() {
        viewModel.output.isLoginSuccess
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isLoginSuccess in
                guard let self = self else { return }
                
                if isLoginSuccess {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVCToHome()
                } else {
                    self.showErrorAlert("로그인에 실패했습니다.")
                }
            })
            .disposed(by: bag)
    }
    
}

// MARK: - 네이버 로그인

extension LoginVC: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("login success")
        guard let instance = naverLoginInstance else {
            print("ERROR - naver login instance error")
            return
        }
        
        viewModel.requestNaverLogin(token: instance.accessToken)
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("second success")
        guard let instance = naverLoginInstance else {
            print("ERROR - naver login instance error")
            return
        }
        
        if isFirstNaverLogin {
            isFirstNaverLogin.toggle()
        } else {
            viewModel.requestNaverLogin(token: instance.accessToken)
        }
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("Log out")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(error!)
    }
}


// MARK: - ASAuthorizationControllerDelegate {

extension LoginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let identityToken = appleIDCredential.identityToken else { return }
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName ?? PersonNameComponents()
            let familyName = fullName.familyName ?? .empty
            let givenName = fullName.givenName ?? .empty

            if let email = appleIDCredential.email {
                KeychainManager.shared.save(key: .email, value: email)
                viewModel.requestSocialLogin(loginType: .apple, token: "\(userIdentifier)|\(email)")
            } else {
                guard let savedEmail = KeychainManager.shared.read(for: .email) else { return }
                viewModel.requestSocialLogin(loginType: .apple, token: "\(userIdentifier)|\(savedEmail)")
            }
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            DispatchQueue.main.async {
                print(("username: ", username, "password: ", password))
            }
            
        default:
            break
        }
    }
    
}

// MARK: - ASAuthorizationController PresentationContextProviding

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}
