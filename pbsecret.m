/*
 * pbsecret
 */

#import "pbsecret.h"

void printUsageToStdout () {
	printUsage(NO);
	return;
}

void printUsageToStderr () {
	printUsage(YES);
	return;
}

void printUsage (BOOL useStderr) {
	FILE* outputStream = stdout;
	if ( useStderr ) {
		outputStream = stderr;
	}

    fprintf(outputStream,
		"Usage: %s [-hv]\n"
		"\n"
		"   -v: print version and exit\n"
		"   -h: print this help message and exit\n"
		"\n"
		"Copies data from STDIN to the general pasteboard as UTF-8 text. Copied\n"
		"data is tagged with \"org.nspasteboard.ConcealedType\" to prevent it from\n"
		"being saved in the history of a clipboard manager, as per the spec at:\n"
		"http://nspasteboard.org/\n",
        APP_NAME);
    
    return;
}

void printError (char* errorMessage) {
	fprintf(stderr, "%s: \n", errorMessage);
	return;
}

void printVersion () {
    fprintf(stdout, "%s v%s\n", APP_NAME, APP_VERSION);
    return;
}

Parameters parseArgs (int argc, char* const argv[]) {
    Parameters params;

    params.printVersion = NO;
    params.printUsage = NO;
    params.inBadState = NO;

    int opt;
    int optionArgs = 0;
    while ((opt = getopt(argc, argv, "vh")) != -1) {
    	optionArgs++;
        switch (opt) {
        case 'v':
            params.printVersion = YES;
            break;
        case 'h':
            params.printUsage = YES;
            break;
        case '?':
            params.inBadState = YES;
            break;
        }
    }

    if (argc - optionArgs > 1) {
        params.inBadState = YES;
        printError("accepts no arguments");
    }
    
    return params;
}

int main (int argc, char* const argv[]) {
    Parameters params = parseArgs(argc, argv);
    if (params.inBadState) {
       	printUsageToStderr();
        return EXIT_FAILURE;
    } else if (params.printUsage) {
        printUsageToStdout();
        return EXIT_SUCCESS;
    } else if (params.printVersion) {
        printVersion();
        return EXIT_SUCCESS;
    }


	NSFileHandle* standardInput = [NSFileHandle fileHandleWithStandardInput];
	NSData* inputData = [NSData dataWithData:[standardInput readDataToEndOfFile]];

	NSPasteboard* pasteboard= [NSPasteboard generalPasteboard];
	[pasteboard clearContents];

	[pasteboard setData: [@"" dataUsingEncoding:NSUTF8StringEncoding] forType: @"org.nspasteboard.ConcealedType"];
	[pasteboard setData: inputData forType: @"NSStringPboardType"];

	return EXIT_SUCCESS;
}
