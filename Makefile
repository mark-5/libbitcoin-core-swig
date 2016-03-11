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

perl_swig: $(foreach f,$(SWIGFILES),$(basename $(f)).pm)
	$(foreach f,$(shell find libbitcoin -name *.cxx.perl),mv $(f) perl/src/$(basename $(f));)
	$(foreach f,$(shell find libbitcoin -name *.pm),mv $(f) perl/lib/$(f);)

clean_perl_swig:
	rm -f $(foreach f,$(SWIGFILES),$(basename $(f)).pm)
	rm -f $(foreach f,$(SWIGFILES),perl/src/$(basename $(f)).cxx)
	rm -f $(foreach f,$(SWIGFILES),perl/lib/$(basename $(f)).pm)

perl_dist: perl_swig
	cd perl && $(PERL) Makefile.PL
	cd perl && make

clean_perl_dist:
	cd perl && make clean || true

clean_perl: clean_perl_dist clean_perl_swig


python: python_swig python_dist

python_swig: $(foreach f,$(SWIGFILES),$(basename $(f)).py)
	$(foreach f,$(shell find libbitcoin -name *.cxx.python),mv $(f) python/$(basename $(f));)
	$(foreach f,$(shell find libbitcoin -name *.py),mv $(f) python/$(f);)

python_dist: python_swig
	cd python && python setup.py build

clean_python: clean_python_swig clean_python_dist

clean_python_swig:
	rm -f $(foreach f,$(SWIGFILES),$(basename $(f)).py)
	rm -f $(foreach f,$(SWIGFILES),python/$(basename $(f)).cxx)
	rm -f $(foreach f,$(SWIGFILES),python/$(basename $(f)).pm)

clean_python_dist:
	cd python && python setup.py clean || true

