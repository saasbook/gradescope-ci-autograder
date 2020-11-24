# @see https://gradescope-autograders.readthedocs.io/en/latest/specs/
# Optional: change to the name of your assignment.  $(NAME).zip will be produced as output
NAME = assignment
# Path to zip if not in your $PATH
ZIP  = zip


FILES = $(wildcard src/spec/*) src/run_autograder src/setup.sh src/*

default := all

.PHONY: all
all: clean $(NAME).zip

$(NAME).zip:
	cd src; $(ZIP) $@ *
	@mv src/$(NAME).zip ./

.PHONY: upload
upload:
	gradescope build -ag $(NAME).zip -c 208804 -a 868305

.PHONY: test
test: localenv
	echo 'Grading dummy assignment with run_autograder...'
	cd autograder && ./run_autograder
	echo 'Done, check autograder/results/results.json for results'

.PHONY: localenv
localenv: $(FILES)
	@echo 'Setting up environment to look like Gradescope docker container...'
	-rm -rf autograder
	mkdir autograder && cd autograder && mkdir source submission
	cp run_autograder autograder/
	cp Makefile README.md $(SOLUTIONS) rspec_gradescope_formatter.rb run_autograder setup.sh autograder/source
	cp -R spec autograder/source/
	cp $(SOLUTIONS) autograder/submission/

.PHONY: clean
clean:
	-rm -rf autograder $(NAME).zip
