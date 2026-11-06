import Foundation

enum NetworkError: Error, LocalizedError, CustomStringConvertible {
    case requestEncodingError
    case responseDecodingError
    case responseError
    case urlError
    case networkConnectionError
    case timeoutError
    case unknownError

    case badRequest
    case unauthorized
    case forbidden
    case notFoundError
    case internalServerError
    case httpError(statusCode: Int)
    case serverError(message: String)

    init(statusCode: Int) {
        switch statusCode {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFoundError
        case 500: self = .internalServerError
        default: self = .httpError(statusCode: statusCode)
        }
    }

    var errorDescription: String? {
        switch self {
        case .requestEncodingError:
            return "요청 데이터를 변환하지 못했어요."
        case .responseDecodingError:
            return "서버 응답 데이터를 해석하지 못했어요."
        case .responseError:
            return "올바른 HTTP 응답을 받지 못했어요."
        case .urlError:
            return "요청 주소가 올바르지 않아요."
        case .networkConnectionError:
            return "네트워크에 연결할 수 없어요. 연결 상태를 확인해주세요."
        case .timeoutError:
            return "요청 시간이 초과되었어요. 잠시 후 다시 시도해주세요."
        case .unknownError:
            return "알 수 없는 오류가 발생했어요."
        case .badRequest:
            return "잘못된 요청이에요. 입력한 정보를 확인해주세요."
        case .unauthorized:
            return "인증이 필요하거나 인증 정보가 올바르지 않아요."
        case .forbidden:
            return "요청한 작업을 수행할 권한이 없어요."
        case .notFoundError:
            return "요청한 리소스를 찾을 수 없어요."
        case .internalServerError:
            return "서버 오류가 발생했어요. 잠시 후 다시 시도해주세요."
        case let .httpError(statusCode):
            return "HTTP 오류가 발생했어요. (상태 코드: \(statusCode))"
        case let .serverError(message):
            return message
        }
    }

    var description: String {
        errorDescription ?? "네트워크 오류가 발생했어요."
    }
}
