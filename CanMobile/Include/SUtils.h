//
//  SUtils.h
//  Foods
//
//  Created by Wony Shin on 01/03/2012.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SUtils : NSObject {

}

+ (NSString *)getFilePath:(NSString *)fileName;
+ (BOOL)isFileInDocumentDirectory:(NSString *)fileName;
+ (void)copyFileToDocumentDirectory:(NSString *)fileName;
+ (NSString *)getDocumentDirectory;
+ (NSString *)generateFileName: (BOOL) bMovie;
+ (NSString *)convertToLocalTime:(NSString *)GMTtime;

+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;

+ (NSString *) getDeviceToken;

+ (void) showAlertError: (NSString *) strErrorType Msg:(NSString *) msg;
+ (void) showAlertMsg: (NSString *) strMsg;
+ (void) showAlertMsg: (NSString *) strMsg  title:(NSString *) title;
+ (void) showAlertConfirm: (UIViewController *) delegae Msg:(NSString *) strMsg;

+ (NSString *) GetPhoneContact;

+ (NSString*) encodeToPercentEscapeString : (NSString *)string;
+ (NSString*) decodeFromPercentEscapeString : (NSString *)string;
@end

