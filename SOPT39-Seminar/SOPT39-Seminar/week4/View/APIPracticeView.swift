//
//  APIPracticeView.swift
//  SOPT39-Seminar
//
//  Created by 김세령 on 10/31/26.
//

import SwiftUI

struct APIPracticeView: View {
    
    @State private var part = ""
    @State private var name = ""
    @State private var authorizationCode = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Group {
                TextField("web / iOS / android", text: $part)
                
                TextField("이름을 입력해주세요", text: $name)
            }
            .font(.custom("Pretendard-Medium", size: 18))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal, 16)
            .frame(height: 54)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color(white: 0.83), lineWidth: 2)
            }
            
            Button {
                Task {
                    await signupButtonDidTap()
                }
            } label: {
                Text(isLoading ? "발급 중..." : "코드 발급")
                    .font(.custom("Pretendard-SemiBold", size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 49)
                    .background(Color(.black), in: RoundedRectangle(cornerRadius: 12))
                
            }
            .disabled(isLoading)
            .padding(.top, 8)
            
            Spacer()
            
            if !authorizationCode.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("발급받은 인증 코드")
                        .font(.custom("Pretendard-SemiBold", size: 14))
                    Text(authorizationCode)
                        .font(.custom("Pretendard-Bold", size: 28))
                        .textSelection(.enabled)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 24)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .padding(.bottom, 24)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 88)
        .background(.white)
        .preferredColorScheme(.light)
    }
    
    private func signupButtonDidTap() async {
        guard !isLoading else { return }
        
        isLoading = true
        authorizationCode = ""
        errorMessage = ""
        defer { isLoading = false }
        
        do {
            let response = try await SignupService.shared.postSignup(part: part)
            try Task.checkCancellation()
            
            guard let code = response.data?.authorizationCode else {
                throw NetworkError.responseError
            }
            authorizationCode = code
        } catch is CancellationError {
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
}

#Preview {
    APIPracticeView()
}
