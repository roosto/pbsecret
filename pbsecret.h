/*
 * pbsecret
 */

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <unistd.h>

#define APP_NAME "pbsecret"
#define APP_VERSION "0.0.1"

typedef struct parameters {
    NSString* inputFilePath;
    BOOL printVersion;
    BOOL printUsage;
    BOOL inBadState;
    NSString* badStateMessage;
} Parameters;

void printUsageToStdout ();
void printUsageToStderr ();

void printUsage (BOOL useStderr);
void printVersion ();


Parameters parseArgs (int argc, char* const argv[]);
int main (int argc, char* const argv[]);
