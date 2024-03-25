// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAnimalListQuery: GraphQLQuery {
  public static let operationName: String = "GetAnimalList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAnimalList { GetAllAnimals { __typename animals { __typename name id } } }"#
    ))

  public init() {}

  public struct Data: FarmFosterAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { FarmFosterAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("GetAllAnimals", GetAllAnimals.self),
    ] }

    public var getAllAnimals: GetAllAnimals { __data["GetAllAnimals"] }

    /// GetAllAnimals
    ///
    /// Parent Type: `GetAllAnimalResponse`
    public struct GetAllAnimals: FarmFosterAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { FarmFosterAPI.Objects.GetAllAnimalResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("animals", [Animal].self),
      ] }

      public var animals: [Animal] { __data["animals"] }

      /// GetAllAnimals.Animal
      ///
      /// Parent Type: `Animal`
      public struct Animal: FarmFosterAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { FarmFosterAPI.Objects.Animal }
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
