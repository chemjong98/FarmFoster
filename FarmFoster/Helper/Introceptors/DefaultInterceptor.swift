//
//  DefaultInterceptor.swift
//  FarmFoster
//
//  Created by ebpearls on 19/03/2024.
//

import Apollo
import FarmFosterAPI

class DefaultInterceptor: ApolloInterceptor {
    let id: String = "DefaultInterceptor"
    
    func interceptAsync<Operation>(chain: Apollo.RequestChain, 
                                   request: Apollo.HTTPRequest<Operation>,
                                   response: Apollo.HTTPResponse<Operation>?,
                                   completion: @escaping (Result<Apollo.GraphQLResult<Operation.Data>, Error>) -> Void
                                  )
                                   where Operation : ApolloAPI.GraphQLOperation
    {
        request.addHeader(name: "Authorization", value: "")
        
        chain.proceedAsync(request: request,
                           response: response, 
                           interceptor: self,
                           completion: completion)
    }
}
