#import <Foundation/Foundation.h>


typedef enum {
    OBCodeSignStateUnsigned = 1,
    OBCodeSignStateSignatureValid,
    OBCodeSignStateSignatureInvalid,
    OBCodeSignStateSignatureNotVerifiable,
    OBCodeSignStateSignatureUnsupported,
    OBCodeSignStateError
} OBCodeSignState;


@interface NSBundle (OBCodeSigningInfo)

- (BOOL)ob_comesFromAppStore;
- (BOOL)ob_isSandboxed;
- (OBCodeSignState)ob_codeSignState;

@end
