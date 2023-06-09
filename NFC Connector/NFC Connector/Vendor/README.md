# SwaggerClient

A webservice for the glorious Auguris App

This ObjC package is automatically generated by the [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) project:

- API version: 1.0.0
- Package version: 
- Build package: io.swagger.codegen.languages.ObjcClientCodegen

## Requirements

The SDK requires [**ARC (Automatic Reference Counting)**](http://stackoverflow.com/questions/7778356/how-to-enable-disable-automatic-reference-counting) to be enabled in the Xcode project.

## Installation & Usage
### Install from Github using [CocoaPods](https://cocoapods.org/)

Add the following to the Podfile:

```ruby
pod 'SwaggerClient', :git => 'https://github.com//.git'
```

To specify a particular branch, append `, :branch => 'branch-name-here'`

To specify a particular commit, append `, :commit => '11aa22'`

### Install from local path using [CocoaPods](https://cocoapods.org/)

Put the SDK under your project folder (e.g. /path/to/objc_project/Vendor/SwaggerClient) and then add the following to the Podfile:

```ruby
pod 'SwaggerClient', :path => 'Vendor/SwaggerClient'
```

### Usage

Import the following:

```objc
#import <SwaggerClient/SWGApiClient.h>
#import <SwaggerClient/SWGDefaultConfiguration.h>
// load models
#import <SwaggerClient/SWGCycle.h>
#import <SwaggerClient/SWGTag.h>
// load API classes for accessing endpoints
#import <SwaggerClient/SWGTagApi.h>

```

## Recommendation

It's recommended to create an instance of ApiClient per thread in a multi-threaded environment to avoid any potential issues.

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```objc

SWGDefaultConfiguration *apiConfig = [SWGDefaultConfiguration sharedConfig];

// Configure API key authorization: (authentication scheme: api_key)
[apiConfig setApiKey:@"YOUR_API_KEY" forApiKeyIdentifier:@"api_key"];
// Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//[apiConfig setApiKeyPrefix:@"Bearer" forApiKeyIdentifier:@"api_key"];


SWGTag* *body = [[SWGTag alloc] init]; // Tag object that needs to be added to the database

SWGTagApi *apiInstance = [[SWGTagApi alloc] init];

// Add a new Tag
[apiInstance tagCreatePostWithBody:body
              completionHandler: ^(NSError* error) {
                            if (error) {
                                NSLog(@"Error: %@", error);
                            }
                        }];

```

## Documentation for API Endpoints

All URIs are relative to *https://odin.rassware.de/auguris/V1*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*SWGTagApi* | [**tagCreatePost**](docs/SWGTagApi.md#tagcreatepost) | **POST** /tag/create | Add a new Tag
*SWGTagApi* | [**tagGetTagIdGet**](docs/SWGTagApi.md#taggettagidget) | **GET** /tag/get/{tagId} | Returns a Tag
*SWGTagApi* | [**tagSterilizationTagIdPost**](docs/SWGTagApi.md#tagsterilizationtagidpost) | **POST** /tag/sterilization/{tagId} | Add a new sterilization
*SWGTagApi* | [**tagUpdateTagIdDelete**](docs/SWGTagApi.md#tagupdatetagiddelete) | **DELETE** /tag/update/{tagId} | Deletes a tag
*SWGTagApi* | [**tagUpdateTagIdPost**](docs/SWGTagApi.md#tagupdatetagidpost) | **POST** /tag/update/{tagId} | Posts tag info
*SWGTagApi* | [**tagUsecycleTagIdPost**](docs/SWGTagApi.md#tagusecycletagidpost) | **POST** /tag/usecycle/{tagId} | Add a new cycle


## Documentation For Models

 - [SWGCycle](docs/SWGCycle.md)
 - [SWGTag](docs/SWGTag.md)


## Documentation For Authorization


## api_key

- **Type**: API key
- **API key parameter name**: api_key
- **Location**: HTTP header


## Author

rc@rassware.de


