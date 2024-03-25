// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetPlantListQuery: GraphQLQuery {
  public static let operationName: String = "GetPlantList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetPlantList { GetAllPlants { __typename plants { __typename name id } } }"#
    ))

  public init() {}

  public struct Data: FarmFosterAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { FarmFosterAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("GetAllPlants", GetAllPlants.self),
    ] }

    public var getAllPlants: GetAllPlants { __data["GetAllPlants"] }

    /// GetAllPlants
    ///
    /// Parent Type: `GetAllPlantResponse`
    public struct GetAllPlants: FarmFosterAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { FarmFosterAPI.Objects.GetAllPlantResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("plants", [Plant].self),
      ] }

      public var plants: [Plant] { __data["plants"] }

      /// GetAllPlants.Plant
      ///
      /// Parent Type: `Plant`
      public struct Plant: FarmFosterAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { FarmFosterAPI.Objects.Plant }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
          .field("id", String.self),
        ] }

        public var name: String { __data["name"] }
        public var id: String { __data["id"] }
      }
    }
  }
}
