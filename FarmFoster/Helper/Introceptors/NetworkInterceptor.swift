//
//  NetworkInterceptor.swift
//  FarmFoster
//
//  Created by ebpearls on 19/03/2024.
//

import Foundation
import Apollo
import FarmFosterAPI

class NetworkFetchInterceptorProvider: DefaultInterceptorProvider {
    
    init(store: ApolloStore) {
        super.init(store: store)
    }
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptor = super.interceptors(for: operation)
        interceptor.insert(DefaultInterceptor(), at: 0)
        return interceptor
    }
}
