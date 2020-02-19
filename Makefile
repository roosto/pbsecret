NAME := pbsecret

all:
	$(CC) -Wall -g -O3 -ObjC \
		-framework Foundation -framework AppKit \
		-o $(NAME) \
		$(NAME).m

clean:
	rm -rfv $(NAME).dSYM ;
	rm -v $(NAME);
