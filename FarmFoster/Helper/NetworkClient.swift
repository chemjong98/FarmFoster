//
//  NetworkClient.swift
//  FarmFoster
//
//  Created by ebpearls on 28/12/2023.
//

import Foundation
import SwiftUI
import Apollo
import FarmFosterAPI

enum AppError: Error {
    case invalidURL
    case invalidResponse
    case unknown
    case custom(String?)
    case failed
    
    var errorDescription: String? {
       switch self {
       case .unknown:
           return "unknown"
       case .failed:
           return "Failed"
       case .invalidResponse:
           return "invalidResponse"
       case let .custom(message):
           return message
       case .invalidURL:
           return "invalidURL"
       }
   }
}

protocol GraphQLClient {
    func fetch<Query: GraphQLQuery>(query: Query, cacahePolicy: Apollo.CachePolicy) async -> Result<GraphQLResult<Query.Data>, AppError>
    func perform<Mutation: GraphQLMutation>(mutation: Mutation) async -> Result<GraphQLResult<Mutation.Data>, AppError>
}

// MARK: NetworkClient
class NetworkClient: GraphQLClient {
    static let shared: NetworkClient = NetworkClient()
    
    private init(){}
    
    public lazy var apollo: ApolloClient = {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        
        guard let graphURL: String = try? BuildConfiguration.getValue(key: .graphURL), let endPointURL = URL(string: graphURL) else {
            fatalError()
        }
        
        let interceptorProvider = NetworkFetchInterceptorProvider(store: store)
        let requestChainNetworkTransport = RequestChainNetworkTransport(interceptorProvider: interceptorProvider, endpointURL: endPointURL)
        
        return ApolloClient(networkTransport: requestChainNetworkTransport, store: store)
    }()
}

extension NetworkClient {
    
    
    func fetch<Query>(query: Query, cacahePolicy: Apollo.CachePolicy = .fetchIgnoringCacheCompletely) async -> Result<GraphQLResult<Query.Data>, AppError> where Query: GraphQLQuery {
        await withCheckedContinuation{ continuation in
            apollo.fetch(query: query) { [unowned self] result in
                self.handleContinuation(continuation: continuation, Operation: query, result: result)
            }
        }
    }
    
    func perform<Mutation>(mutation: Mutation) async -> Result<GraphQLResult<Mutation.Data>, AppError> where Mutation: GraphQLMutation {
        await withCheckedContinuation { continuation in
            apollo.perform(mutation: mutation) { [unowned self] response in
                self.handleContinuation(continuation: continuation, Operation: mutation, result: response)
            }
        }
    }
    
    
    // MARK:  continuation handler
    private func handleContinuation<Operation: GraphQLOperation>(continuation: CheckedContinuation<Result<GraphQLResult<Operation.Data>
                                                                 ,AppError> ,Never>,
                                                                 Operation: Operation,
                                                                 result: Result<GraphQLResult<Operation.Data> , Error>)
    {
        switch result {
        case .success(let response):
            if let error = response.errors?.first?.errorDescription {
                continuation.resume(returning: .failure(.custom(error)))
            } else {
                continuation.resume(returning: .success(response))
            }
        case .failure(let error):
            if let error = error as? AppError {
                continuation.resume(returning: .failure(.custom(error.localizedDescription)))
            }
        }
    }
}
