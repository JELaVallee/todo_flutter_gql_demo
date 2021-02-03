const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "todofluttergqldemo": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://gbf7oclmjve4xe3pq5bxkrwfkm.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-l7nsuogjhzh4hgbsmqhg5fxq5m"
                }
            }
        }
    }
}''';