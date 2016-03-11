INC       = -I$(shell scripts/libbitcoin-inc)
PERL      = perl 
PYTHON	  = python
SWIG      = swig
SWIGCMD   = $(SWIG) -c++ $(INC)
SWIGFILES = $(shell find libbitcoin -name *.i)

%.pm : %.i
	mkdir -p perl/lib/libbitcoin perl/src/libbitcoin
	$(SWIGCMD) -perl -o $(basename $@)_wrap.cxx.perl $(basename $@).i

%.py : %.i
	mkdir -p python/libbitcoin
	$(SWIGCMD) -python -o $(basename $@)_wrap.cxx.python $(basename $@).i


default: perl python

perl: perl_swig perl_dist

python: python_swig python_dist

clean: clean_perl clean_python

test: test_perl

perl_swig: $(foreach f,$(SWIGFILES),$(basename $(f)).pm)
	$(foreach f,$(shell find libbitcoin -name *.cxx.perl),cp $(f) perl/src/$(basename $(f));)
	$(foreach f,$(shell find libbitcoin -name *.pm),cp $(f) perl/lib/$(f);)

clean_perl_swig:
	rm -f $(foreach f,$(SWIGFILES),$(basename $(f))_wrap.cxx.perl)
	rm -f $(foreach f,$(SWIGFILES),$(basename $(f)).pm)
	rm -f $(foreach f,$(SWIGFILES),perl/src/$(basename $(f)).cxx)
	rm -f $(foreach f,$(SWIGFILES),perl/lib/$(basename $(f)).pm)

perl_dist: perl_swig
	cd perl && $(PERL) Makefile.PL
	cd perl && make
	cd perl && make dist

clean_perl_dist:
	cd perl && make distclean || true

clean_perl: clean_perl_dist clean_perl_swig


test_perl: perl_dist
	cd perl && make test

python: python_swig python_dist

python_swig: $(foreach f,$(SWIGFILES),$(basename $(f)).py)
	$(foreach f,$(shell find libbitcoin -name *.cxx.python),cp $(f) python/$(basename $(f));)
	$(foreach f,$(shell find libbitcoin -name *.py),cp $(f) python/$(f);)

python_dist: python_swig
	cd python && $(PYTHON) setup.py build
	cd python && $(PYTHON) setup.py bdist

clean_python: clean_python_swig clean_python_dist

clean_python_swig:
	rm -f $(foreach f,$(SWIGFILES),$(basename $(f))_wrap.cxx.python)
	rm -f $(foreach f,$(SWIGFILES),$(basename $(f)).py)
	rm -f $(foreach f,$(SWIGFILES),python/$(basename $(f)).cxx)
	rm -f $(foreach f,$(SWIGFILES),python/$(basename $(f)).py)

clean_python_dist:
	cd python && $(PYTHON) setup.py clean --all || true

