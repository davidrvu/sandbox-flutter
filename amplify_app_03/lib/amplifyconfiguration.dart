const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:0dda32c1-4fc6-438e-8f2f-d4d0fd299995",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_rVMTQ9kxG",
                        "AppClientId": "496rtaoq24hnkaqtkj9vvatedc",
                        "AppClientSecret": "1tmtko002l189qe7b2011sls057mpcejom93p2h7o9jfp27rh5sk",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "amplifyapp036f2f6803-6f2f6803-dev.auth.us-east-1.amazoncognito.com",
                            "AppClientId": "496rtaoq24hnkaqtkj9vvatedc",
                            "AppClientSecret": "1tmtko002l189qe7b2011sls057mpcejom93p2h7o9jfp27rh5sk",
                            "SignInRedirectURI": "myapp://callback/",
                            "SignOutRedirectURI": "myapp://signout/",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                }
            }
        }
    }
}''';