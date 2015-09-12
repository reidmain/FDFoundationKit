// Inspiration for this macro taken from https://github.com/jspahrsummers/libextobjc
#define keypath(...) \
	fd_arg_count_greater_1(__VA_ARGS__)(keypathForObject(__VA_ARGS__))(keypathForClass(__VA_ARGS__))

#define keypathForObject(PATH) \
	(((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define keypathForClass(CLASS, PATH) \
	(((void)(NO && ((void)((CLASS *)nil).PATH, NO)), # PATH))

// Implementation details are below this comment. If you use anything below this I cannot guarantee that its details will not change arbitrarily.
#define fd_consume(...)
#define fd_exec(...) __VA_ARGS__

#define fd_concatenate(A, B) fd_concatenate_impl(A, B)
#define fd_concatenate_impl(A, B) A ## B

#define fd_arg_count(...) fd_arg_count_impl(__VA_ARGS__,5,4,3,2,1)
#define fd_arg_count_impl(_1,_2,_3,_4,_5,N,...) N

#define fd_arg_count_equal_1(...) __VA_ARGS__ fd_consume
#define fd_arg_count_equal_2(...) fd_exec

#define fd_arg_count_greater_1(...) \
	fd_concatenate(fd_arg_count_equal_, fd_arg_count(__VA_ARGS__))