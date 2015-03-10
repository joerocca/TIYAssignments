//
//  FormValidator.h
//  Form Validator
//
//  Created by Joe Rocca on 3/9/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormValidator : NSObject

- (BOOL)validateZipCode:(NSString *)zipCode;
- (BOOL)validateAddress:(NSString *)address;
- (BOOL)validateName:(NSString *)name;
- (BOOL)validateState:(NSString *)state;
- (BOOL)validateCity:(NSString *)city;
- (BOOL)validatePhoneNumber:(NSString *)phoneNumber;

@end
