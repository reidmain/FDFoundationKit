#if !defined(FDLog)
	#if defined(DEBUG) || defined(AD_HOC)
		#define FDLog(logLevel, format, ...) FDLogger(logLevel, format, ##__VA_ARGS__)
	#else
		#define FDLog(logLevel, format, ...) do { } while (0)
	#endif
#endif


#pragma mark Enumerations

typedef enum
{
	FDLogLevelTrace = 0,
	FDLogLevelDebug = 1,
	FDLogLevelInfo = 2,
	FDLogLevelError = 3,
	FDLogLevelFatal = 4
} FDLogLevel;


#pragma mark - Constants

#if defined(DEBUG)
	#define CutoffLogLevel	FDLogLevelTrace
#elif defined(AD_HOC)
	#define CutoffLogLevel	FDLogLevelInfo
#else
	#define CutoffLogLevel	FDLogLevelFatal
#endif


#pragma mark - Methods

static inline void FDLogger(FDLogLevel logLevel, NSString *format, ...)
{
	// If the log level is below the cuttoff level do nothing.
	if (logLevel < CutoffLogLevel)
	{
		return;
	}
	
	// If no format exists do nothing.
	if (format == nil) 
	{
		return;
	}
	
	// Determine the log level prefix.
	const char *linePrefix = NULL;
	
	switch (logLevel)
	{
		case FDLogLevelTrace:
		{
			linePrefix = "TRACE";
			
			break;
		}
		
		case FDLogLevelDebug:
		{
			linePrefix = "DEBUG";
			
			break;
		}
		
		case FDLogLevelInfo:
		{
			linePrefix = "INFO\t";
			
			break;
		}
		
		case FDLogLevelError:
		{
			linePrefix = "ERROR";
			
			break;
		}
		
		case FDLogLevelFatal:
		{
			linePrefix = "FATAL";
			
			break;
		}
	}
	
	// Get a reference to the arguments that follow the format parameter.
	va_list argList;
	va_start(argList, format);
	
	// Perform format string argument substitution.
	NSString *formattedLine = [[NSString alloc] 
		initWithFormat: format 
			arguments: argList];
	
#ifdef DEBUG
	// Reinstate %% escapes.
	const char *line = [[formattedLine stringByReplacingOccurrencesOfString: @"%%" 
		withString:@"%%%%"] 
			UTF8String];
	
	printf("%s\t: %s\n", linePrefix, line);
#else
	NSLog(@"%s\t: %@", linePrefix, formattedLine);
#endif
	
	va_end(argList);
}