// Inspiration for this macro taken from https://github.com/jspahrsummers/libextobjc
#if !defined(keypath)
	#define keypath(PATH) (((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))
#endif